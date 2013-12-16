package com.website.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class IndexController extends BaseController {

	/* ---- index ---- */
	@RequestMapping(value="/index", method=RequestMethod.GET)
    public String index(ModelMap modelMap) {
		modelMap.put("login", getLoginAdmin() != null);
        return "index";
    }
	
	/* ---- version ---- */
    @RequestMapping(value="/version", method=RequestMethod.GET)
    public String version() {
        return "version";
    }
    
}