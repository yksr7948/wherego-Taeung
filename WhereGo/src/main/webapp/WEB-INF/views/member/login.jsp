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
    width: 300px;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.signup-form h1, .login-form h1 {
    color: #007bff;
    margin-bottom: 20px;
    font-size: 1.5em;
    text-align: center;
}

.signup-form label, .login-form label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
    text-align: left;
    width: 100%;
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

.signup-form .gender, .signup-form .terms {
    margin-bottom: 15px;
    width: 100%;
}

.signup-form .gender input, .signup-form .terms input {
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
    margin-bottom: 20px;
}

.signup-form button:hover, .login-form button:hover {
    background-color: #0056b3;
}

a {
    margin-right: 10px;
    text-decoration: none;
    color: #007bff;
}

.social-login-buttons {
    display: flex;
    justify-content: center;
    gap: 10px;
    margin-top: 20px;
}

.social-login-buttons img {
    width: 60px;
    height: 60px;
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <div class="container">
        <form action="login.me" method="post" class="login-form">
            <h1>로그인을 위해 정보를 입력해주세요.</h1>
            <label for="userId">아이디</label>
            <input type="text" id="userId" name="userId" required>
            <label for="userPwd">비밀번호</label>
            <input type="password" id="userPwd" name="userPwd" required>
            <button type="submit">로그인하기</button>
        </form>
        <div>
            <a href="findId.me">아이디 찾기</a>
            <a href="findPwd.me">비밀번호 찾기</a>
        </div>
        <div class="social-login-buttons">
            <a href="naverlogin"><img class="naver-login-img" alt="네이버로그인" src="resources/img/naver_login.png"></a>
            <a href="kakaologin"><img class="kakao-login-img" alt="카카오로그인" src="resources/img/kakao_login.png"></a>
            <a href="googlelogin"><img class="google-login-img" alt="구글로그인" src="resources/img/google_login.png"></a>
        </div>
    </div>
    	<c:if test="${not empty errorMsg}">
		<script>
			alert("${errorMsg}");
		</script>
		<c:remove var="errorMsg" />
	</c:if>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
