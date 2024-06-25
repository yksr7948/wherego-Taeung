<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<!-- Popper JS -->
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/alertify.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/alertify.min.css" rel="stylesheet">

<style>
	div{
		box-sizing:border-box;
	}
	#header{
		width:80%;
		height:100px;
		padding-top:20px;
		margin:auto;
	}
	#header>div{
		width:100%;
		margin-bottom:10px;
	}
	#header_1{
		height : 40%;
	}
	#header_2{
		height : 60%;
	}
	#header_1>div{
		height : 100%;
		float : left;
	}
	#header_1_left {
		width:30%;
		position:relative;
	}
	#header_1_center {
		width:40%;
	}
	#header_1_right{
		width:30%;
	}
	#header_1_left>img{
		height : 80%;
		position : absolute;
		margin:auto;
		top:0px;
		bottom:0px;
		right:0px;
		left:0px;
	}
	#header_1_right{
		text-align : center;
		line-height : 35px;
		font-size : 12px;
		text-indent:35px;
	}
	#header_1_right>a{
		margin : 5px;
	}
	#header_1_right>a:hover{
		cursor : pointer;
	}
	#header_2>ul{
		width:100%;
		height:100%;
		list-style-type:none;
		margin:auto;
		padding:0;
	}
	#header_2>ul>li{
		float:left;
		width:25%;
		height:100%;
		line-height:55px;
		text-align:center;
	}
	#header_2>ul>li a{
		text-decoration:none;
		color:black;
		font-size:18px;
		font-weight:900;
	}
	#header_2{
		border-top:1px solid lightgray;
	}
	#header a{
		text-decoration:none; 
		color:black;
	} 
	
	/*세부 페이지마다 필요한 공통 스타일*/
	.content{
		background-color: skyblue;
		width:80%;
		margin:auto;
	}
	.innerOuter{
		border:1px solid blue;
		width:80%;
		margin:auto;
		padding: 5% 10%;
		background-color: white;
	}
	
</style>

</head>
<body>
	

		<div class="content">
		<br> <br>
		<div class="innerOuter">
			<h2>회원가입</h2>
			<br>

			<form action="insert.me" method="post">
				<div class="form-group">
					<label for="enrollUserId">* ID</label> <input type="text"
						id="enrollUserId" name="userId" class="form-control"> <br>
					<div id="checkResult" style='font-size: 0.8em;'></div>

					<label for="enrollUserPwd">* PASSWORD</label> <input
						type="password" id="enrollUserPwd" name="userPwd"
						class="form-control"> <br> <label for="checkPwd">*
						PASSWORD CHECK</label> <input type="password" id="pwdCheck"
						class="form-control"> <br> <label for="userName">*
						NAME</label> <input type="text" id="userName" name="userName"
						class="form-control"> <br> <label for="email">
						&nbsp; EMAIL</label> <input type="email" id="email" name="email"
						class="form-control"> <br> <label for="age">
						&nbsp; AGE</label> <input type="number" id="age" name="age"
						class="form-control"> <br> <label for="phone">
						&nbsp; PHONE</label> <input type="tel" id="phone" name="phone"
						class="form-control" placeholder="(-)없이 입력">  <br>

					<label for=""> &nbsp; GENDER</label> &nbsp;&nbsp; <input
						type="radio" id="male" value="M" name="gender" checked> <label
						for="male">남자</label> &nbsp;&nbsp; <input type="radio" id="female"
						value="F" name="gender"> <label for="female">여자</label>
					&nbsp;&nbsp;
				</div>
				<div class="btns" align="center">
					<button type="submit" class="btn btn-primary" disabled>회원가입</button>
					<button type="reset" class="btn btn-danger">초기화</button>
				</div>
			</form>

			<script>
				$(function() {
					//사용자가 입력한 아이디가 중복인지 확인하는 작업 (비동기처리)
					//사용자가 키를 입력하면 이벤트 발생
					//중복인지 아닌지 확인하여 네이버에서 처럼 NNNNN 또는 NNNNY 로 응답데이터 돌려받기
					//돌려받은 응답데이터를 이용하여 result div에 사용 가능한 아이디입니다.
					//또는 사용불가능한 아이디입니다. 라는 텍스트를 담아 보여주기
					//이때 사용 가능하다면 회원가입 버튼이 활성화 되도록 작업하기
					//checkId() 메소드명 사용 

					//아이디 입력 인풋상자 요소 
					var inputId = $("#enrollUserId");

					inputId.keyup(function() {

						$.ajax({
							url : "checkId.me",
							data : {
								checkId : $(inputId).val()
							},
							success : function(result) {

								if (result == 'NNNNN') {//중복
									$("#checkResult").show();
									$("#checkResult").css("color", "red").text(
											"사용불가능한 아이디입니다.");

									//중복시 회원가입 버튼 비활성화
									$("button[type=submit]").attr("disabled",
											true);
								} else { //사용가능
									$("#checkResult").show();
									$("#checkResult").css("color", "green")
											.text("사용가능한 아이디입니다.");
									//사용가능시 회원가입 버튼 활성화
									$("button[type=submit]").attr("disabled",
											false);
								}

							},
							error : function() {
								console.log("통신 오류");
							}
						});

					});

				});
			</script>
		</div>
	</div>
	
</body>
</html>