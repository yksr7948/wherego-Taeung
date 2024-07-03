<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<style>
	.content{
		width:80%;
		margin: auto;
		margin-top: 100px;
	}
</style>
</head>
<body>
	
	<div class="content" align="center">
		<h1>국토교통부-고속버스</h1>
		<br> <br>
		
		
		<!-- 
		<select id="departure">
			<option value="1">서울</option>
			<option value="2">인천</option>
			<option value="3">대전</option>
			<option value="4">대구</option>
			<option value="5">광주</option>
			<option value="6">부산</option>
			<option value="7">울산</option>
			<option value="31">경기</option>
			<option value="32">강원</option>
			<option value="39">제주</option>
		</select>  -->
		
		
		<button id="areaBtn">확인</button>
		<button id="saveBtn">저장하기</button>
	
		<br> <br>
		
		<div id="save-result">
			<h3></h3>
		</div>
		
		<br>
		<table border="1" align="center" id="result">
			<thead>
				<tr>
					<th>터미널ID</th>
					<th>터미널NAME</th>
				</tr>
			</thead>
			<tbody>
	
			</tbody>
		</table>

	<script>
		$(function() {

			$("#areaBtn").click(
					function() {
					
						$.ajax({
							url : "GBus.tr",
							
							success : function(data) {

								var items = data.response.body.items.item;
								
								console.log("확인성공");
							
								var str = "";
								for (var i = 0; i < items.length; i++) {

									var item = items[i];

									str += "<tr>" 
										+ "<td>"+item.terminalId+"</td>" 
										+ "<td>"+item.terminalNm+"</td>"  
										+ "</tr>";
								}

								$("#result tbody").html(str);

							},
							error : function() {
								console.log("통신오류");
							}
						});

					});
			
			$("#saveBtn").click(
					function() {
						
						$.ajax({
							url : "saveGTerminalInfo.tr",
							
							success : function(data) {
								$("#save-result>h3").text(data + "지역 저장성공");
								$("#save-result>h3").css({"color" : "green"});
							},
							error : function(data) {
								console.log("통신오류");
								$("#save-result>h3").text("저장실패(이미 저장된 데이터 입니다.)");
								$("#save-result>h3").css({"color" : "red"});
							}
						});

					});
		});
	</script>
	
	</div>
	
</body>
</html>