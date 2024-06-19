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
				<table>
					<tr>
						<td><button class="location-btn">광역시</button></td>
						<td><button class="location-btn">경기도</button></td>
						<td><button class="location-btn">강원도</button></td>
						<td><button class="location-btn">충청도</button></td>
						<td><button class="location-btn">경상도</button></td>
						<td><button class="location-btn">전라도</button></td>
					</tr>
					<tr>
						<td colspan="6">
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
			<tr>
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
			<tr>
				<th>최저기온 / 최고기온</th>
				<td colspan="2">18℃ / 28℃</td>
				<td colspan="2">18℃ / 28℃</td>
				<td colspan="2">18℃ / 28℃</td>
				<td colspan="2">18℃ / 28℃</td>
				<td colspan="2">18℃ / 28℃</td>
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
	<%@ include file="../common/footer.jsp" %>
</body>
</html>