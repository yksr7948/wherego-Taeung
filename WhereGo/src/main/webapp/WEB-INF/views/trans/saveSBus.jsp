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
		<h1>국토교통부-시외버스</h1>
		<br> <br>

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
					<th>도시</th>
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
							url : "SBus.tr",
							
							success : function(data) {

								var items = data.response.body.items.item;
								
								console.log("확인성공");
							
								var str = "";
								for (var i = 0; i < items.length; i++) {

									var item = items[i];

									str += "<tr>" 
										+ "<td>"+item.terminalId+"</td>" 
										+ "<td>"+item.terminalNm+"</td>"
										+ "<td>"+item.cityName+"</td>"  
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
							url : "saveSTerminalInfo.tr",
							
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