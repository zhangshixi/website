package com.website.mapper.security;

import java.util.List;

import com.website.domain.security.Permission;
import com.website.mapper.BaseMapper;

public interface PermissionMapper extends BaseMapper<Permission> {
    
	public Permission selectByCode(String code);
	
    public List<Permission> selectAll(Integer roleId);
    
}
