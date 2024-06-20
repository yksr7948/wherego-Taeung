<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>문서</title>
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
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f9;
      color: #333;
    }
    a {
      text-decoration: none;
    }
    li {
      list-style-type: none;
    }

    .hbody {
      background-color: #fff;
      width: 100%;
      height: 150px;
      box-shadow: 0 2px 4px rgba
    }
    .nav {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 20px 50px;
      color: #333;
    }
    .title {
      display: flex;
      align-items: center;
    }


    .title img {
      width: 100px;
      height: auto;
      margin-left: 10px;
    }
    .login-button {
      background-color: white;
      text-align: center;
      color: black;
      padding: 10px 20px;
      margin-left: 20px;
      border: 2px solid black;
      border-radius: 5px;
      font-size: 16px;
      font-weight: 900;
      cursor: pointer;
      transition: background-color 0.3s, color 0.3s;
    }
    .login-button:hover {
      background-color: black;
      color: white;
    }

    .search-bar {
      flex-grow: 0.3;
      display: flex;
      justify-content: center;
      align-items: center;
      margin: 0 20px;
    }
    .search-bar input {
      width: 250px;
      max-width: 400px;
      padding: 10px;
      border: none;
      border-bottom: 1px solid black;
      font-size: 16px;
      outline: none;
    }
    #serach-icon{
        width: 32px;
        height: auto;
        cursor: pointer;
    }

    #menu {
      font: bold 20px "malgun gothic";
      width: 700px;
      height: 50px;
      color: #333;
      line-height: 50px;
      margin: 0 auto;
      text-align: center;
      position: relative;
    }
    #menu > ul > li {
      float: left;
      width: 140px;
      position: relative;
    }

    #menu > ul > li > a {
      color: #333;
      transition: color 0.3s;
    }
    #menu > ul > li > a:hover {
      color: #8B4513;
    }

    .submenu {
      width: 140px;
      opacity: 0;
      visibility: hidden;
      transform: translateY(-20px);
      transition: opacity 1s ease, visibility 1s ease, transform 1s ease; 
      position: absolute;
      top: 50px; 
      left: 0; 
      background-color: white;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    .submenu li {
      margin-top: 10px;
      margin-bottom: 10px;
    }
    .submenu li a {
      color: #333;
      padding: 10px;
      display: block;
      transition: background-color 0.3s, color 0.3s;
    }
    .submenu li a:hover {
      background-color: #f4f4f9;
      color: #8B4513;
    }

    #menu > ul > li:hover .submenu {
      opacity: 1;
      visibility: visible;
      transform: translateY(0); /* 슬라이드 위치를 아래로 이동 */
    }

    /*화면 크기 1300이상*/
    @media screen and (min-width: 1300px) {
      #menu {
        display: flex;
      }
      #menu > li {
        padding: 20px 30px;
        font-size: 20px;
      }
    }
    
    /*화면 크기 1300이하*/
    @media screen and (max-width: 1300px) {
      .nav {
        padding: 30px 40px;
      }
      #menu {
        display: none;
      }
    }
  </style>
</head>
<body>
  <header>
    <section class="hbody">
      <article class="nav">
        <div class="title">
          <a href="index.jsp"><img src="resources/img/removebg-preview.png" alt="Logo"></a>
        </div>
        <div id="menu">
          <ul>
            <li><a href="index.jsp">홈</a></li>
            <li><a href="">여행지</a>
              <div class="submenu">
                <ul>
                  <li><a href="tripList.bo?currentPage=1">여행지1</a></li>
                  <li><a href="#">여행지2</a></li>
                  <li><a href="#">여행지3</a></li>
                  <li><a href="#">여행지4</a></li>
                  <li><a href="#">여행지5</a></li>
                </ul>
              </div>
            </li>
            <li><a href="">날씨</a></li>
            <li><a href="${pageContext.request.contextPath}/travelMap">지도</a></li>
            <li><a href="">게시판</a>
              <div class="submenu">
                <ul>
                  <li><a href="#">게시판1</a></li>
                  <li><a href="#">게시판2</a></li>
                </ul>
              </div>
            </li>
          </ul>
        </div>
        <div class="search-bar">
            <form action="">
                <input type="text" placeholder="검색어를 입력하세요...">
                <img id="serach-icon" src="resources/img/search-icon.png" alt="">
            </form>
        </div>
        <!-- <button class="login-button" id="login">LOGIN</button>
         <button class="login-button" id="enroll">회원가입</button> -->
         
         		<c:choose>
					<%--로그인 전 --%>
					<c:when test="${empty loginUser }">
						<a href="loginPage.me" class="login-button">로그인</a> <a href="insertEnrollForm.me" class="login-button">회원가입</a>
					</c:when>
					<%-- 로그인 후 --%>				
					<c:otherwise>
						<label>${loginUser.userName}님 환영합니다</label> &nbsp;&nbsp; 
						<a href="mypage.me" class="login-button">마이페이지</a> <a href="logout.me" class="login-button">로그아웃</a>
					</c:otherwise>
				</c:choose>
        <script>
        	
        </script>
      </article>
    </section>
  </header>
  <hr>
</body>
</html>

