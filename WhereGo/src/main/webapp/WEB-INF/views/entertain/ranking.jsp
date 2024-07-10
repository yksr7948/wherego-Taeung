<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
main {
	padding: 20px;
	width: 60%;
	margin: auto;
	margin-top: 5%;
}

#area-title {
	font-weight: 900;
}

/* 지역별 이동 버튼 */
.area-container {
	text-align: left;
	margin-bottom: 40px;
	margin-left: 30px;
}

.area-container a {
	border: 2px solid black;
	background-color: white;
	color: black;
	padding: 10px 20px;
	border-radius: 5px;
	font-size: 16px;
	transition: background-color 0.3s, color 0.3s;
	margin-right: 10px;
}

.area-container a:hover {
	background-color: black;
	color: white;
	cursor: pointer;
}

/* 여행지 리스트 */
.card-container {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	justify-content: center;
	padding: 20px;
}

.card {
	background-color: #fff;
	border: 1px solid #ddd;
	border-radius: 8px;
	overflow: hidden;
	width: 300px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	transition: transform 0.2s;
	flex: 0 0 calc(25% - 20px);
	box-sizing: border-box;
}

.card:hover {
	transform: scale(1.05);
	cursor: pointer;
}

.card>img {
	width: 100%;
	height: 200px;
	object-fit: cover;
}

.card-content {
	padding: 15px;
}

.card-content h2 {
	margin: 0 0 10px;
	font-size: 18px;
}

.card-content p {
	margin: 0;
	color: #555;
	font-size: 11px;
}

.rank-button {
	background-color: white;
	text-align: center;
	color: black;
	padding: 9px 16px; /* Reduced padding */
	margin-left: 20px;
	border: 2px solid black;
	border-radius: 5px;
	font-size: 14px; /* Reduced font size */
	font-weight: 900;
	cursor: pointer;
	transition: background-color 0.3s, color 0.3s;
}

.rank-button:hover {
	background-color: black;
	color: white;
}
</style>
</head>
<body>

	<%@include file="/WEB-INF/views/common/header.jsp"%>


	<br>
	<br>
	<hr>
	<br>
	<br>
	<br>


	<div class="card-container">
		<c:forEach items="${list}" var="a" varStatus="status">
			<c:set var="w" value="${winList[status.index]}" />
			<c:set var="winRate" value="${w * 100 / entireGame}" />
			<div class="card">
				<input type="hidden" value="${a.contentId}" id="hiddenContentId${status.index}"> 
				<input type="hidden" value="${a.title}" id="hiddenTitle${status.index}">
				<img
					src="${a.firstImage2}" alt="">
				<div class="card-content">
					<h2>${status.index + 1}등
						${a.title} &nbsp;&nbsp;&nbsp;&nbsp; 승률:
						<fmt:formatNumber value="${winRate}" type="number"
							maxFractionDigits="1" />
						%
					</h2>
					<a class="rank-button mbti-btn" data-index="${status.index}">mbti</a>  <a href=""
						class="rank-button">해시태그</a> <a href="" class="rank-button">성별</a>
					<a href="" class="rank-button">나이</a>
				</div>
			</div>
		</c:forEach>
	</div>

	<br>
	<br>
	<br>

	<h1></h1>
	<div class="modal" id="updatePwdForm">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">비밀번호 변경</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body" align="center">
				
				</div>

				<!--  Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>

			</div>
		</div>
	</div>


	<script>
	 $(function() {
	        $(".card img").click(function() {
	        	 var contentId = $(this).siblings("input[type=hidden]").val();
		            location.href = "tripDetail.tl?contentId=" + contentId;
		            console.log(contentId);
	        });
	        $(".mbti-btn").click(function() {
	        	 var index = $(this).data("index");
	        	 var eachContentId = $("#hiddenContentId" + index).val();
	        	 var eachTitle = $("#hiddenTitle" + index).val();
	        	 
	        	 console.log("Content ID: " + eachContentId);
	        	 console.log("Title: " + eachTitle);
	        	 
	        	 $.ajax({
	        	        url: "wcInfo.en",
	        	        type: "POST",
	        	        data: {
	        	            contentId: eachContentId,
	        	            title: eachTitle
	        	        },
	        	        success: function(response) {
	        	            console.log("Data sent successfully.");
	        	            console.log("Response: " + response);
	        	        },
	        	        error: function(xhr, status, error) {
	        	            console.error("Error occurred: " + status + " - " + error);
	        	        }
	        	    });

	        	 // 각 변수를 저장하거나 원하는 작업을 수행합니다.
	        });
		});
	 
	 
	</script>

	<%@include file="/WEB-INF/views/common/footer.jsp"%>