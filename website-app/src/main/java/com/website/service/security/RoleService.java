package com.website.service.security;

import java.util.List;

import com.website.domain.security.Role;
import com.website.service.BaseService;

public interface RoleService extends BaseService<Role> {

	public Role findByCode(String code);

	public List<Role> queryAll(Integer adminId);

	public void authorize(Integer roleId, Integer[] permissionIds);
	
}
