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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.go.wherego.auth.model.NaverLoginBean;
import com.go.wherego.member.model.service.MemberService;
import com.go.wherego.member.model.vo.Member;
import com.go.wherego.member.model.vo.MemberAuth;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/naver")
@RequiredArgsConstructor
public class NaverLoginController {
	private final NaverLoginBean naverLoginBean;
	private final MemberService memberService;
	
	//네이버 로그인 페이지 요청하기 위한 요청
	@RequestMapping("/login")
	public String login(HttpSession session) throws UnsupportedEncodingException {
		String naverAuthUrl=naverLoginBean.getAuthorizationUrl(session);
		return "redirect:"+naverAuthUrl;
	}
	
	@RequestMapping("/callback")
	public String login(@RequestParam(required = false) String code
			, @RequestParam(required = false) String error
			, @RequestParam String state
			, HttpSession session) throws IOException, ParseException {

		if (error != null && "access_denied".equals(error)) {
	        // 사용자가 동의 창에서 취소한 경우
	        return "redirect:/";
	    }
		
		OAuth2AccessToken accessToken=naverLoginBean.getAccessToken(session, code, state);
		
		String apiResult=naverLoginBean.getUserProfile(accessToken);
		
		JSONParser parser=new JSONParser();
		Object object=parser.parse(apiResult);
		JSONObject jsonObject=(JSONObject)object;
		
		JSONObject responseObject=(JSONObject)jsonObject.get("response");
		System.out.println(responseObject);
		String id=(String)responseObject.get("id");
		String nickname=(String)responseObject.get("nickname");
		String name =(String)responseObject.get("name");
		String email=(String)responseObject.get("email");
		String birthday=(String)responseObject.get("birthyear")+(String)responseObject.get("birthday");
		String gender=(String)responseObject.get("gender");
		String phone=(String)responseObject.get("mobile");
	    
		//반환받은 네이버 사용자 프로필의 값 사용
		MemberAuth auth=new MemberAuth();
		auth.setId("naver_"+id);
		auth.setAuth("ROLE_SOCIAL");
		
		List<MemberAuth> authList=new ArrayList<MemberAuth>();
		authList.add(auth);
		
		Member m=new Member();
		m.setUserId("naver_"+id);
		m.setUserPwd(UUID.randomUUID().toString());
		m.setUserNickname(nickname);
		m.setUserName(name);
		m.setEmail(email);
		m.setGender(gender);
		m.setPhone(phone);
		//m.setAddress(null);
		//m.setEnabled("0");
		m.setSecurityAuthList(authList);
		
		// 네이버 로그인 사용자의 권한을 SECURITY_AUTH 테이블에 저장
		memberService.addNaverUserinfo(m);


		return "redirect:/";
	}
}