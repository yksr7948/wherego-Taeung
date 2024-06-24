package com.go.wherego.member.controller;

import java.io.UnsupportedEncodingException;
import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.go.wherego.member.model.service.MemberService;
import com.go.wherego.member.model.vo.Member;


@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	
	
	@GetMapping("login.me")
	public String gologin() {
		//회원가입 페이지로 단순 이동처리
		return "member/login";
	} 
	
	
	@RequestMapping("login.me")
	public ModelAndView loginMember(Member m, ModelAndView mv, HttpSession session) {
		
		Member loginUser = memberService.loginMember(m);
		
		if (loginUser == null || !bcryptPasswordEncoder.matches(m.getUserPwd(), loginUser.getUserPwd())) {

			mv.addObject("errorMsg", "로그인 실패");
			mv.setViewName("redirect:/");

		} else {
			session.setAttribute("alertMsg", "로그인 성공!");
			session.setAttribute("loginUser", loginUser);
			mv.setViewName("main");
		}
		
		
		return mv;
		
	}
	
	@RequestMapping("logout.me")
	public String logoutMember(HttpSession session) {

		session.removeAttribute("loginUser");

		return "redirect:/";
	}
	
	@RequestMapping("insertEnrollForm.me")
	public String memberEnrollForm() {
		//System.out.println("왔나");
		return "member/memberEnrollForm";
	}
	
	@PostMapping("insert.me")
	public String insertMember(Member m, HttpSession session, ModelAndView mv) {
		String bcrPwd = bcryptPasswordEncoder.encode(m.getUserPwd());
		m.setUserPwd(bcrPwd);
		int result = memberService.insertMember(m);
		
		if (result > 0) { 
			session.setAttribute("alertMsg", "회원 가입 성공!");
			return "redirect:/";
		} else {
			mv.addObject("errorMsg", "회원 가입 실패");

			return "common/errorPage";
		}
	}
	
		@ResponseBody
		@RequestMapping("checkId.me")
		public String checkId(String checkId) {
			
			int count = memberService.checkId(checkId);
			
			
			String result = "";
			
			if(count>0) {//중복
				result = "NNNNN";
			}else {//중복아님(사용가능)
				result = "NNNNY";
			}
			//System.out.println(result);
			return result;
		}
	
}
