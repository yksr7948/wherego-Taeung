<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>날씨</title>
<style>
.weather-area{
width:90%;
margin:auto;
border:1px solid black;
background-color:white;
}
.location-btn{
width:80%;
background-color:azure;
color:black;
}
</style>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
	<div class="weather-area">
	<h2>날씨</h2>
	<table border="1">
		<thead>
			<tr>
				<th colspan="11">
				<table style="width:100%; text-align:center">
					<tr>
						<td><button class="location-btn">광역시</button></td>
						<td><button class="location-btn">경기도</button></td>
						<td><button class="location-btn">강원도</button></td>
						<td><button class="location-btn">충청도</button></td>
						<td><button class="location-btn">경상도</button></td>
						<td><button class="location-btn">전라도</button></td>
					</tr>
					<tr>
						<td colspan="6" style="text-align:left">
						<!-- ajax를 통해 버튼 클릭시 해당 구역에 속하는 시 이름들 버튼 나열 -->
						<button>서울</button>
						<button>인천</button>
						<button>세종</button>
						<button>대전</button>
						<button>대구</button>
						<button>광주</button>
						<button>울산</button>
						<button>부산</button>
						<button>제주</button>
						</td>
					</tr>
				</table>
				</th>
			</tr>
		</thead>
		<tbody>
		<!-- 처음은 서울 날씨 보여주고 다른 버튼 클릭시 해당 지역의 날씨 조회 -->
		<!-- aspect 기능을 사용해 매일 06시마다 날짜갱신 -->
			<tr id="wDate">
				<th rowspan="2">날짜</th>
				<td colspan="2">3일후</td>
				<td colspan="2">4일후</td>
				<td colspan="2">5일후</td>
				<td colspan="2">6일후</td>
				<td colspan="2">7일후</td>
			</tr>
			<tr>
				<td>오전</td>
				<td>오후</td>
				<td>오전</td>
				<td>오후</td>
				<td>오전</td>
				<td>오후</td>
				<td>오전</td>
				<td>오후</td>
				<td>오전</td>
				<td>오후</td>
			</tr>
			<tr id="wTemp">
				<!-- 최저기온 / 최고기온 -->
				<th>최저기온 / 최고기온</th>
				<td colspan="10">데이터를 불러오는 중입니다.</td>
			</tr>
			<tr>
				<th>날씨 상태</th>
				<td><img src="resources/img/weather/sun.png" width="60" height="60" alt=""><br>맑음</td>
				<td><img src="resources/img/weather/sun_cloudy.png" width="60" height="60" alt=""><br>맑음</td>
				<td><img src="resources/img/weather/cloud.png" width="60" height="60" alt=""><br>맑음</td>
				<td><img src="resources/img/weather/rain.png" width="60" height="60" alt=""><br>맑음</td>
				<td><img src="resources/img/weather/snow.png" width="60" height="60" alt=""><br>맑음</td>
				<td><img src="resources/img/weather/sun.png" width="60" height="60" alt=""><br>맑음</td>
				<td><img src="resources/img/weather/sun.png" width="60" height="60" alt=""><br>맑음</td>
				<td><img src="resources/img/weather/sun.png" width="60" height="60" alt=""><br>맑음</td>
				<td><img src="resources/img/weather/sun.png" width="60" height="60" alt=""><br>맑음</td>
				<td><img src="resources/img/weather/sun.png" width="60" height="60" alt=""><br>맑음</td>
			</tr>
			<tr>
				<th>강수확률(%)</th>
				<td>0</td>
				<td>10</td>
				<td>20</td>
				<td>30</td>
				<td>40</td>
				<td>50</td>
				<td>60</td>
				<td>70</td>
				<td>80</td>
				<td>90</td>
			</tr>
		</tbody>
	</table>
	</div>
	<script>
	$(function(){
		showWeather("서울"); /* 처음실행시 서울날씨 조회 */
	});
	function showWeather(location){
		console.log("대충 날씨관련 함수함들기");
		var area=location;
		console.log(area);
		$.ajax({
			url : "location.we",
			data : {
				location : area
			},
			success : function(result){
				var data=$(result).find('item');
				var str="<th> 최저기온 / 최고기온 </th>";
					str +="<td colspan='2'>"+$(data).find("taMin3").text()+"℃ / "+$(data).find("taMax3").text()+"℃ </td>"
						+"<td colspan='2'>"+$(data).find("taMin4").text()+"℃ / "+$(data).find("taMax4").text()+"℃ </td>"
						+"<td colspan='2'>"+$(data).find("taMin5").text()+"℃ / "+$(data).find("taMax5").text()+"℃ </td>"
						+"<td colspan='2'>"+$(data).find("taMin6").text()+"℃ / "+$(data).find("taMax6").text()+"℃ </td>"
						+"<td colspan='2'>"+$(data).find("taMin7").text()+"℃ / "+$(data).find("taMax7").text()+"℃ </td>";
				$("#wTemp").html(str);
			},
			error : function(){
				console.log("정보 가져오기 실패");
			}
		});
	}
	</script>
	<%@ include file="../common/footer.jsp" %>
</body>
</html>