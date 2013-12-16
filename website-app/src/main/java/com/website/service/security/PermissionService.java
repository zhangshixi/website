package com.website.service.security;

import java.util.List;

import com.website.domain.security.Permission;
import com.website.service.BaseService;

public interface PermissionService extends BaseService<Permission> {
	
	public Permission findByCode(String code);
    
    public List<Permission> queryAll();
    
    public List<Permission> queryAll(Integer roleId);


}
