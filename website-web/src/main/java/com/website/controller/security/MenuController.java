package com.website.controller.security;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.website.controller.BaseController;
import com.website.domain.security.Menu;
import com.website.service.security.MenuService;

@Controller
@RequestMapping("/menu")
public class MenuController extends BaseController {
    
	@Autowired
    private MenuService menuService;

	@RequestMapping(method=RequestMethod.GET)
	public String index(ModelMap modelMap) {
		return "menu/list";
	}
	
	@RequestMapping(value="/new", method=RequestMethod.GET)
	public String toAdd() {
		return view("add");
	}
	
	@RequestMapping(method=RequestMethod.POST)
	public String add(@Valid Menu menu) {
		menu.setUpdateAdmin(getLoginAdmin());
	    menuService.add(menu);
	    
		return redirectTo("/menu");
	}
	
	@ResponseBody
	@RequestMapping(value="/{id}", method=RequestMethod.GET)
	public Object show(@PathVariable Integer id) {
		return menuService.findById(id);
	}

	@RequestMapping(value="/{id}/edit", method=RequestMethod.GET)
	public String toEdit(@PathVariable Integer id, ModelMap modelMap) {
		Menu menu = menuService.findById(id);
	    if (menu == null) {
	        return redirectTo("/error/404");
	    } else {
	        modelMap.put("target", menu);
	        return view("edit");
	    }
	}
	
	@RequestMapping(value="/{id}", method=RequestMethod.PUT)
	public String edit(@PathVariable Integer id, Menu menu) {
	    menu.setId(id);
	    menu.setUpdateAdmin(getLoginAdmin());
	    menuService.editSelective(menu);
	    
		return redirectTo("/menu/{0}", id);
	}
	
	@RequestMapping(value="/{id}", method=RequestMethod.DELETE)
	public String remove(@PathVariable Integer id) {
		menuService.removeById(id);
		
	    return redirectTo("/menu");
	}
	
	@ResponseBody
	@RequestMapping(value="/list", method=RequestMethod.POST)
	public List<Menu> showList() {
		List<Menu> menuList = menuService.queryAllTree(null);
		
		return menuList;
	}
	
}