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
import com.go.wherego.auth.model.KakaoLoginBean;
import com.go.wherego.member.model.service.MemberService;
import com.go.wherego.member.model.vo.Member;
import com.go.wherego.member.model.vo.MemberAuth;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/kakao")
@RequiredArgsConstructor
public class KaKaoLoginController {
	private final KakaoLoginBean kakaoLoginBean;
	private final MemberService memberService;
	
	//카카오 로그인 페이지 요청
	@RequestMapping("/login")
	public String login(HttpSession session) throws UnsupportedEncodingException {
		String kakaoAuthUrl=kakaoLoginBean.getAuthorizationUrl(session);
		return "redirect:"+kakaoAuthUrl;
	}
	
	@RequestMapping("/callback")
	public String login(@RequestParam(value = "code", required = false) String code
			, @RequestParam(value = "state", required = false) String state
			, HttpSession session) throws IOException, ParseException{
		
		OAuth2AccessToken accessToken=kakaoLoginBean.getAccessToken(session, code, state);
		
		String apiResult=kakaoLoginBean.getUserProfile(accessToken);
		
		//JSONParser 객체 : JSON 형식의 문자열을 JSON 객체로 변환
		JSONParser parser=new JSONParser();
		//JSONParser.parse(String json) : JSON 형식의 문자열을 Object 객체로 변환
		Object object=parser.parse(apiResult);
		//Object 객체로 JSONObject 객체로 변환하여 저장
		JSONObject jsonObject=(JSONObject)object;
		
		//JSON 객체에 저장된 값을 제공받아 저장 - 파싱(Parsing)
		//JSONObject.get(String name) : JSONObject 객체에 저장된 값(객체)을 반환하는 메소드
		// => Object 타입으로 값(객체)를 반환하므로 반드시 형변환하여 저장
		// String id=(String)jsonObject.get("id");
		String id=Long.toString((long) jsonObject.get("id"));
		JSONObject account =(JSONObject) jsonObject.get("kakao_account");
		JSONObject profile = (JSONObject) account.get("profile");
		System.out.println("profile :"+profile);
		String name= (String)profile.get("nickname");
		
		//반환받은 카카오 사용자 프로필의 값을 사용하여 Java 객체의 필드값으로 저장
		MemberAuth auth=new MemberAuth();
		auth.setId("kakao_"+id);
		auth.setAuth("ROLE_SOCIAL");
		
		List<MemberAuth> authList=new ArrayList<MemberAuth>();
		authList.add(auth);
		
		Member m=new Member();
		m.setUserId("kakao_"+id);
		m.setUserPwd(UUID.randomUUID().toString());
		m.setUserName(name);
		//m.setEmail(email);
		//m.setAddress(null);
		//m.setEnabled("0");
		m.setSecurityAuthList(authList);
		int checkId = memberService.checkId(m.getUserId());
		if(checkId>0) {
			session.setAttribute("loginUser", m);
			return "redirect:/";
		}else {
			// 사용자의 정보를 userinfo 테이블과 auth 테이블에 저장
			memberService.addGoogleUserinfo(m);
			return "member/additional";
		}

	}
	
}
