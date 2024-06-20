<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인</title>
<style>
body {
	font-family: 'Arial', sans-serif;
	background-color: #f0f4f8;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
}

.container {
	background-color: #fff;
	padding: 40px;
	border-radius: 10px;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
	width: 400px;
}

.signup-form h1, .login-form h1 {
	color: #007bff;
	margin-bottom: 20px;
	font-size: 1.5em;
}

.signup-form label, .login-form label {
	display: block;
	margin-bottom: 5px;
	font-weight: bold;
}

.signup-form input[type="email"], .signup-form input[type="text"],
	.signup-form input[type="password"], .login-form input[type="text"],
	.login-form input[type="password"] {
	width: calc(100% - 20px);
	padding: 10px;
	margin-bottom: 15px;
	border: 1px solid #ddd;
	border-radius: 5px;
}

.signup-form .gender {
	margin-bottom: 15px;
}

.signup-form .gender input {
	margin-right: 5px;
}

.signup-form .terms {
	margin-bottom: 15px;
}

.signup-form .terms input {
	margin-right: 5px;
}

.signup-form button, .login-form button {
	width: 100%;
	padding: 10px;
	background-color: #007bff;
	color: #fff;
	border: none;
	border-radius: 5px;
	font-size: 1em;
	cursor: pointer;
}

.signup-form button:hover, .login-form button:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>
	<div class="container">
		<form action="login.me" method="post" class="login-form">
			<h1>로그인을 위해 정보를 입력해주세요.</h1>
			<label for="userId">아이디</label> <input type="text" id="userId"
				name="userId" required> <label for="userPwd">비밀번호</label> <input
				type="password" id="userPwd" name="userPwd" required>

			<button type="submit">로그인하기</button>
		</form>
		<a
			href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=370b2ac32b1684b9567ff8f7e89edb05&redirect_uri=http://localhost:8777/wherego">
			<img src="resources/img/kakao_login_medium_narrow.png" />
		</a>
		<div id="naver_id_login" style="text-align: center">
			<a href="${url}"><img width="223"
				src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png" /></a>
		</div>
		<br>
		<!-- 구글 로그인 화면으로 이동 시키는 URL -->
		<!-- 구글 로그인 화면에서 ID, PW를 올바르게 입력하면 oauth2callback 메소드 실행 요청-->
		<div id="google_id_login" style="text-align: center">
			<a href="${google_url}"> <img width="230"
				src="resources/img/web_light_sq_SU@1x.png" />
			</a>
		</div>


	</div>
</body>
</html>
