package com.nuri.shopping.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.nuri.shopping.model.CateVO;
import com.nuri.shopping.service.UserService;

@Controller
public class MainController {
	@Autowired
	UserService userService;
	
	@RequestMapping(value= {"/", "/home"}, method=RequestMethod.GET)
	public String main(Model model,
			HttpServletRequest request, 
            HttpServletResponse response,HttpSession session) {
		
		List<CateVO> cate_list = userService.getProducts(1);
		model.addAttribute("cate_list", cate_list);
		
		int categrp_idx = cate_list.get(0).getCategory_idx();
		model.addAttribute("categrp_idx", categrp_idx);
		//System.out.println("cate_list: " + cate_list);
		model.addAttribute("user_idx", session.getAttribute("user_idx"));
		return "main";
	}

}
