package com.website.mapper.security;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.website.domain.security.Admin;
import com.website.mapper.BaseMapper;

public interface AdminMapper extends BaseMapper<Admin> {
	
    public Admin selectByLoginName(String name);
    
    public List<Admin> selectAll();

	public int deleteRelateRoles(Integer adminId);

	public int insertRelateRoles(@Param("adminId") Integer adminId, @Param("roleIds") Integer[] roleIds);
    
}