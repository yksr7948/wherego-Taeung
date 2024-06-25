package com.go.wherego.auth.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.go.wherego.auth.exception.MemberExistException;
import com.go.wherego.auth.exception.MemberNotFoundException;
import com.go.wherego.auth.model.GoogleLoginBean;
import com.go.wherego.member.model.service.MemberService;
import com.go.wherego.member.model.vo.Member;
import com.go.wherego.member.model.vo.MemberAuth;

import lombok.RequiredArgsConstructor;

@Controller

@RequiredArgsConstructor
public class GoogleLoginController {
	private final GoogleLoginBean googleLoginBean;
	private final MemberService memberService;

	@RequestMapping("/googlelogin")
	public String googlelogin(HttpSession session) throws UnsupportedEncodingException {
		String googleAuthUrl = googleLoginBean.getAuthorizationUrl(session);
		return "redirect:" + googleAuthUrl;
	}

	@RequestMapping("/googlecallback")
	public String googlelogin(@RequestParam String code, @RequestParam String state, HttpSession session, Model model)
			throws IOException, ParseException, MemberExistException, MemberNotFoundException, ParseException {
		OAuth2AccessToken accessToken = googleLoginBean.getAccessToken(session, code, state);

		String apiResult = googleLoginBean.getUserProfile(accessToken);

		JSONParser parser = new JSONParser();
		Object object = parser.parse(apiResult);
		JSONObject responseObject = (JSONObject) object;

		// 사용자 json 데이터를 각각 id, email 등 각각 나눠서 저장
		System.out.println(responseObject);
		String id = (String)responseObject.get("id");
		String email = (String)responseObject.get("email");
		String name=(String)responseObject.get("family_name")+(String)responseObject.get("given_name");
		String nickname = (String)responseObject.get("name");
		String profile=(String)responseObject.get("picture");
		
		
		
		// (spring-security) 소셜 로그인 계정에 "ROLE_SOCIAL" 권한 부여
//		MemberAuth auth = new MemberAuth();
//		auth.setId("google_" + id);
//		auth.setAuth("ROLE_SOCIAL");
//
//		List<MemberAuth> authList = new ArrayList<MemberAuth>();
//		authList.add(auth);

		
		Member m=new Member();
		m.setUserId("google_"+id);
		m.setUserPwd(UUID.randomUUID().toString());
		m.setUserName(name);
		m.setUserNickname(nickname);
		m.setEmail(email);
		m.setProfile(profile);
		//m.setAddress(null);
		//m.setEnabled("0");
		//m.setSecurityAuthList(authList);
		System.out.println(m);
		
		int checkId = memberService.checkId(m.getUserId());
		if(checkId>0) {
			session.setAttribute("loginUser", m);
			return "redirect:/";
		}else {
			// 사용자의 정보를 userinfo 테이블과 auth 테이블에 저장
			memberService.addGoogleUserinfo(m);
			model.addAttribute("userId",m.getUserId());
			session.setAttribute("loginUser", m);
			return "member/additional";
		}
		

			
		
	}
}
