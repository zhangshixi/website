package com.website.service.security;

import java.util.List;

import com.website.domain.security.Menu;
import com.website.service.BaseService;

public interface MenuService extends BaseService<Menu> {

	public Menu findByCode(String code);

	public List<Menu> queryAll(Boolean display);
	
	public List<Menu> queryAllTree(Boolean display);
	
}
