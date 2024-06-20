package com.go.wherego.member.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
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

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.go.wherego.member.model.service.MemberService;
import com.go.wherego.member.model.vo.Member;
import com.go.wherego.naverlogin.NaverLoginBo;


@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	
	
//	@GetMapping("loginPage.me")
//	public String gologin() {
//		
//		return "member/login";
//	} 
	
	private NaverLoginBo naverLoginBO;
	private String apiResult = null;

	@Autowired
	private void setNaverLoginBO(NaverLoginBo naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}
	// 로그인 첫 화면 요청 메소드

	@RequestMapping(value = "/loginPage.me", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(Model model, HttpSession session) {
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		
		// https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
		// redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
		System.out.println("네이버:" + naverAuthUrl);
		// 네이버
		model.addAttribute("url", naverAuthUrl);
		return "member/login";
	}
	
	//네이버 로그인 성공시 callback호출 메소드	
	@RequestMapping(value = "/callback", method = { RequestMethod.GET, RequestMethod.POST })	
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session) throws IOException, ParseException {
		System.out.println("여기는 callback");		
		OAuth2AccessToken oauthToken;        
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		
		 //1. 로그인 사용자 정보를 읽어온다.		
		apiResult = naverLoginBO.getUserProfile(oauthToken);  //String형식의 json데이터				
		/** apiResult json 구조		
		 * {"resultcode":"00",		 
		 * "message":"success",		
		 *  "response":{"id":"33666449","nickname":"shinn****","age":"20-29","gender":"M","email":"sh@naver.com","name":"\uc2e0\ubc94\ud638"}}		
		 *  **/
		
		//2. String형식인 apiResult를 json형태로 바꿈		
		JSONParser parser = new JSONParser();		
		Object obj = parser.parse(apiResult);		
		JSONObject jsonObj = (JSONObject) obj;
		
		//3. 데이터 파싱 		
		//Top레벨 단계 _response 파싱		
		JSONObject response_obj = (JSONObject)jsonObj.get("response");		
		//response의 nickname값 파싱		
		String nickname = (String)response_obj.get("nickname"); 		
		System.out.println(nickname);				
		//4.파싱 닉네임 세션으로 저장		
		session.setAttribute("sessionId",nickname); //세션 생성				
		model.addAttribute("result", apiResult);	     		
		return "member/naverlogin";

	}
	
	//로그아웃	@RequestMapping(value = "/logout", method = { RequestMethod.GET, RequestMethod.POST })	
	public String logout(HttpSession session)throws IOException {			
		System.out.println("여기는 logout");			
		session.invalidate(); 	        			
		return "redirect:member/login.jsp";		
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
