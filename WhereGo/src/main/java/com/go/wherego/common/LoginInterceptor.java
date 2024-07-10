package com.go.wherego.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import com.go.wherego.member.model.vo.Member;

public class LoginInterceptor implements HandlerInterceptor{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session=request.getSession();
		
		Member loginUser=(Member)session.getAttribute("loginUser");
		if(loginUser==null) {
			session.setAttribute("alertMsg", "로그인 후 사용 가능합니다");
			response.sendRedirect("loginPage.me");
			return false;
		}
		
		return HandlerInterceptor.super.preHandle(request, response, handler);
	}

}
