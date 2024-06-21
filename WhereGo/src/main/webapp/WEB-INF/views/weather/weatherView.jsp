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
.weather-table{
text-align:center;
}
.location-btn{
width:120px;
background-color:azure;
color:black;
}
.location-detail-btn{
width:70px;
background-color:lightblue;
color:black;
}
</style>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
	<div class="weather-area">
	<h2>서울의 날씨</h2>
	<table class="weather-table" border="1">
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
					<tr id="wLocation">
						<td colspan="6" style="text-align:left">
						<!-- ajax를 통해 버튼 클릭시 해당 구역에 속하는 시 이름들 버튼 나열 -->
						<button class="location-detail-btn">서울</button>
						<button class="location-detail-btn">인천</button>
						<button class="location-detail-btn">세종</button>
						<button class="location-detail-btn">대전</button>
						<button class="location-detail-btn">대구</button>
						<button class="location-detail-btn">광주</button>
						<button class="location-detail-btn">울산</button>
						<button class="location-detail-btn">부산</button>
						<button class="location-detail-btn">제주</button>
						</td>
					</tr>
				</table>
				</th>
			</tr>
		</thead>
		<tbody>
		<!-- 처음은 서울 날씨 보여주고 다른 버튼 클릭시 해당 지역의 날씨 조회 -->
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
			<tr id="wWeather">
				<th>날씨 상태</th>
				<td colspan="10">데이터를 불러오는 중입니다.</td>
			</tr>
			<tr id="wRain">
				<th>강수확률(%)</th>
				<td colspan="10">데이터를 불러오는 중입니다.</td>
			</tr>
		</tbody>
	</table>
	</div>
	<script>
	$(function(){
		showDate();/* 처음 실행시 날짜 구성 */
		showTemperature("서울"); /* 처음실행시 기온 조회(서울) */
		showWeather("광역시","서울"); /* 처음 실행시 날씨 및 강수확률 조회(서울) */
		
		$(".location-btn").click(function(){
			getDetailLocation($(this).html());
		})
	});
	//시,도버튼 클릭시 상세지역 버튼 출력 함수
	function getDetailLocation(location){
		$.ajax({
			url : "location.we",
			data : {
				location : location
			},
			success : function(result){
				var str="";
				for(var i=0;i<result.length;i++){
					str +="<td><button class='location-detail-btn'>"+result[i].locationName+"</button></td>";
				}
				$("#wLocation").html(str);
			},
			error : function(){
				console.log("지역 불러오기 실패");
			}
		})
	}
	
	//날짜 표시함수(처음에만 실행)
	function showDate(){
		$.ajax({
			url : "date.we",
			data : {},
			success : function(list){
				var str="<th rowspan='2'>날짜</th>"
				for(var i=0;i<list.length;i++){
					str +="<td colspan='2'>"+list[i]+"</td>";
				}
				$("#wDate").html(str);
			},
			error : function(){
				console.log("날짜 가져오기 실패");
			}
		})
	}
	
	//기온 표시함수(처음실행 및 지역버튼 클릭시 실행)
	function showTemperature(location){
		var area=location;
		$.ajax({
			url : "temperature.we",
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
				var str="<th> 최저기온 / 최고기온 </th>"
					+"<td colspan='10'>데이터를 가져오는데 실패했습니다.</td>";
				$("#wTemp").html(str);
			}
		});
	}
	
	//날씨 표시함수(처음 및 지역버튼 클릭시 실행)
	function showWeather(area,location){
		$.ajax({
			url : "weather.we",
			data : {
				area : area,
				location : location
			},
			method : "post",
			success : function(result){
				var data=$(result).find('item');
				var str1="<th> 강수확률(%) </th>"
						+"<td>"+$(data).find("rnSt3Am").text()+"</td>"
						+"<td>"+$(data).find("rnSt3Pm").text()+"</td>"
						+"<td>"+$(data).find("rnSt4Am").text()+"</td>"
						+"<td>"+$(data).find("rnSt4Pm").text()+"</td>"
						+"<td>"+$(data).find("rnSt5Am").text()+"</td>"
						+"<td>"+$(data).find("rnSt5Pm").text()+"</td>"
						+"<td>"+$(data).find("rnSt6Am").text()+"</td>"
						+"<td>"+$(data).find("rnSt6Pm").text()+"</td>"
						+"<td>"+$(data).find("rnSt7Am").text()+"</td>"
						+"<td>"+$(data).find("rnSt7Pm").text()+"</td>";
				$("#wRain").html(str1);
				
				let arr=new Array();
				for(var i=3;i<8;i++){
					var am="wf"+i+"Am";
					var pm="wf"+i+"Pm";
					arr.push($(data).find(am).text());
					arr.push($(data).find(pm).text());
				}
				var str2="<th> 날씨 상태 </th>";
				for(var i=0;i<arr.length;i++){
					var keyword="wf"+Math.floor(3+i/2);
					if(i%2==0){
						keyword+="Am";
					} else {
						keyword+="Pm";
					}
					switch(arr[i]){
					case "맑음":
						str2 +="<td><img src='resources/img/weather/sun.png' width='60' height='60' alt=''><br>"+$(data).find(keyword).text()+"</td>";
						break;
					case "구름많음":
						str2 +="<td><img src='resources/img/weather/sun_cloudy.png' width='60' height='60' alt=''><br>"+$(data).find(keyword).text()+"</td>";
						break;
					case "흐림":
						str2 +="<td><img src='resources/img/weather/cloud.png' width='60' height='60' alt=''><br>"+$(data).find(keyword).text()+"</td>";
						break;
					case "흐리고 비":
						str2 +="<td><img src='resources/img/weather/rain.png' width='60' height='60' alt=''><br>"+$(data).find(keyword).text()+"</td>";
						break;
					case "흐리고 눈":
						str2 +="<td><img src='resources/img/weather/snow.png' width='60' height='60' alt=''><br>"+$(data).find(keyword).text()+"</td>";
						break;
					}
				}
				$("#wWeather").html(str2);
			},
			error : function(){
				console.log("날씨 가져오기 실패");
				var str1="<th> 강수확률(%) </th>"
					+"<td colspan='10'>데이터를 가져오는데 실패했습니다.</td>";
				$("#wRain").html(str);
				var str2="<th> 날씨 상태 </th>"
					+"<td colspan='10'>데이터를 가져오는데 실패했습니다.</td>";
				$("#wWeather").html(str);
			}
		})
	}
	</script>
	<%@ include file="../common/footer.jsp" %>
</body>
</html>