package com.website.service.security;

import com.website.domain.security.Admin;
import com.website.service.BaseService;

public interface AdminService extends BaseService<Admin> {

    public Admin findByLoginName(String loginName);

	public void authorize(Integer id, Integer[] roleIds);
    
}