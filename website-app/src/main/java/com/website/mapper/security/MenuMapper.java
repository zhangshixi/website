package com.website.mapper.security;

import java.util.List;

import com.website.domain.security.Menu;
import com.website.mapper.BaseMapper;

public interface MenuMapper extends BaseMapper<Menu> {

	public Menu selectByCode(String code);

	public List<Menu> selectAll(Boolean display);
	
}