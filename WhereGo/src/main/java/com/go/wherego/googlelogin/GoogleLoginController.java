package com.go.wherego.googlelogin;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

@Controller
@CrossOrigin("*")
public class GoogleLoginController {
//	@Value("${google.client.id}")
	private String googleClientId = "467100631012-ad3nc4fctun670g7e6n6aqqhat1bcdv8.apps.googleusercontent.com";
//    @Value("${google.client.pw}")
	private String googleClientPw = "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";

	@RequestMapping(value = "/api/v1/oauth2/google", method = RequestMethod.POST)
	public String loginUrlGoogle() {
		String reqUrl = "https://accounts.google.com/o/oauth2/v2/auth?client_id=" + googleClientId
				+ "&redirect_uri=http://localhost:8080/api/v1/oauth2/google&response_type=code&scope=email%20profile%20openid&access_type=offline";
		return reqUrl;
	}

	@RequestMapping(value = "/api/v1/oauth2/google", method = RequestMethod.GET)
	public String loginGoogle(@RequestParam(value = "code") String authCode) {
		RestTemplate restTemplate = new RestTemplate();
		GoogleRequest googleOAuthRequestParam = GoogleRequest.builder().clientId(googleClientId)
				.clientSecret(googleClientPw).code(authCode).redirectUri("http://localhost:8080/api/v1/oauth2/google")
				.grantType("authorization_code").build();

		ResponseEntity<GoogleResponse> resultEntity = restTemplate.postForEntity("https://oauth2.googleapis.com/token",
				googleOAuthRequestParam, GoogleResponse.class);
		String jwtToken = resultEntity.getBody().getId_token();
		Map<String, String> map = new HashMap<>();
		map.put("id_token", jwtToken);
		ResponseEntity<GoogleInfResponse> resultEntity2 = restTemplate
				.postForEntity("https://oauth2.googleapis.com/tokeninfo", map, GoogleInfResponse.class);
		String email = resultEntity2.getBody().getEmail();
		return email;
	}

}
