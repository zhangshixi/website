package com.website.controller.security;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mtoolkit.page.Page;
import com.website.controller.BaseController;
import com.website.domain.security.Permission;
import com.website.domain.security.Role;
import com.website.service.security.PermissionService;
import com.website.service.security.RoleService;

@Controller
@RequestMapping("/role")
public class RoleController extends BaseController {
    
	@Autowired
    private RoleService roleService;
	@Autowired
    private PermissionService permissionService;

	@RequestMapping(method=RequestMethod.GET)
	public String index(ModelMap modelMap) {
		return "role/list";
	}
	
	@ResponseBody
	@RequestMapping(value="/list", method=RequestMethod.POST)
	public Object showList(Page<Role> page, Role role) {
		List<Role> roleList = roleService.queryByPage(page, role);
		page.setResultList(roleList);
		return page;
	}
	
	@ResponseBody
	@RequestMapping(value="/new", method=RequestMethod.GET)
	public Object toAdd() {
		return null;
	}
	
	@ResponseBody
	@RequestMapping(value="/new", method=RequestMethod.POST)
	public Object add(@Valid Role role) {
	    roleService.add(role);
	    
	    return success();
	}
	
	@ResponseBody
	@RequestMapping(value="/{id}", method=RequestMethod.GET)
	public Object show(@PathVariable Integer id, ModelMap modelMap) {
		Role targetRole = roleService.findById(id);
	    modelMap.put("target", targetRole);
	    
		return targetRole;
	}
	
	@ResponseBody
	@RequestMapping(value="/{id}", method=RequestMethod.PUT)
	public Object edit(@PathVariable Integer id, Role role) {
	    role.setId(id);
	    roleService.editSelective(role);
	    
	    return success();
	}
	
	@ResponseBody
	@RequestMapping(value="/{id}", method=RequestMethod.DELETE)
	public Object remove(@PathVariable Integer id) {
		roleService.removeById(id);
		
		return success();
	}
	
	@RequestMapping(value="{id}/authorize", method=RequestMethod.GET)
	public String toAuthorize(@PathVariable Integer id, ModelMap modelMap) {
		Role targetRole = roleService.findById(id);
		if (targetRole == null) {
			return redirectTo("/error/404");
		}
		
		List<Permission> allPermissionList = permissionService.queryAll();
		List<Permission> ownPermissionList = permissionService.queryAll(id);

		modelMap.put("target", targetRole);
		modelMap.put("allPermissionList", allPermissionList);
		modelMap.put("ownPermissionList", ownPermissionList);
		
		return view("authorize");
	}

	@RequestMapping(value="{id}/authorize", method=RequestMethod.PUT)
	public String authorize(@PathVariable Integer id, @RequestParam(value="permissionId[]", required=false) Integer[] permissionIds) {
		roleService.authorize(id, permissionIds);
		
		return redirectTo("/role/{id}/authorize", id);
	}
	
	
	/* ---- check methods ---- */
	@ResponseBody
	@RequestMapping(value="/check/code", method=RequestMethod.GET)
	public boolean checkCode(String code) {
		return roleService.findByCode(code) == null;
	}
	
}