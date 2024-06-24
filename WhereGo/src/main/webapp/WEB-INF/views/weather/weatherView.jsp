<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>날씨</title>
<style>
main {
    padding: 20px;
    width: 60%;
    margin: auto;
    margin-top: 5%;
}
.weather-area{
width:100%;
margin:auto;
}
.weather-container,.weather-info{
text-align:center;
}
.weather-container{
width:100%;
border-top: 2px solid black;
border-bottom: 2px solid black;
border-left: 2px solid black;
border-right: 2px solid black;
background-color:aliceblue;
}
.weather-container button{
    padding: 10px 20px;
    border-radius: 5px;
    font-size: 16px;
    margin-right: 10px;
}
.weather-info{

}
.weather-info th{
background-color:beige;
}
#wLocation{
background-color:skyblue;
width:100%;
height:150px;
text-align:center;
vertical-align:text-top;
}
#wLocation tr{
height:50px;
}
#wLocation td{
width:14%;
}
#wLocation button{
font-size:12px;
}

#wWeather>td{
width:80px;
height:100px;
}
.location-btn{
width:80%;
background-color:azure;
color:black;
transition:background-color 0.3s,color 0.3s;
}
.location-btn:hover{
background-color:dodgerblue;
color:white;
}
.location-detail-btn{
width:80px;
background-color:lightblue;
color:black;
}
.location-detail-btn:hover{
background-color:mediumblue;
color:white;
}
</style>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
	<main>
	<div class="weather-area">
		<table class="weather-container">
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
			<table id="wLocation">
			<tr>
				<td style="text-align:left">
				<!-- ajax를 통해 버튼 클릭시 해당 구역에 속하는 시 이름들 버튼 나열 -->
			</td>
			</tr>
			</table>
			</td>
		</tr>
		</table>
	<br>
	<h2 id="area">서울의 날씨</h2>
		<table class="weather-info" border="1">
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
	</main>
	<script>
	$(function(){
		showDate();/* 처음 실행시 날짜 구성 */
		showTemperature("${area}"); /* 처음실행시 기온 조회(서울) */
		showWeather("${area}"); /* 처음 실행시 날씨 및 강수확률 조회(서울) */
		
		$(".location-btn").click(function(){
			getDetailLocation($(this).html());
		})
		
		$("#wLocation").on("click",".location-detail-btn",function(){
			var area=$(this).html();
			showTemperature(area);
			showWeather(area);
			$("#area").html(area+"의 날씨");
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
				var str="<tr>";
				for(var i=0;i<result.length;i++){
					str +="<td><button class='location-detail-btn'>"+result[i].locationName+"</button></td>";
					if((i+1)%7==0){
						str +="</tr><tr>";
					}
				}
				if(result.length<7){
					for(var i=result.length;i<7;i++){
						str+="<td></td>";
					}
				}
				str +="</tr>"
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
				var str="<th> 최저 / 최고기온 </th>";
					str +="<td colspan='2'>"+$(data).find("taMin3").text()+"℃ / "+$(data).find("taMax3").text()+"℃ </td>"
						+"<td colspan='2'>"+$(data).find("taMin4").text()+"℃ / "+$(data).find("taMax4").text()+"℃ </td>"
						+"<td colspan='2'>"+$(data).find("taMin5").text()+"℃ / "+$(data).find("taMax5").text()+"℃ </td>"
						+"<td colspan='2'>"+$(data).find("taMin6").text()+"℃ / "+$(data).find("taMax6").text()+"℃ </td>"
						+"<td colspan='2'>"+$(data).find("taMin7").text()+"℃ / "+$(data).find("taMax7").text()+"℃ </td>";
				$("#wTemp").html(str);
			},
			error : function(){
				console.log("정보 가져오기 실패");
				var str="<th> 최저 / 최고기온 </th>"
					+"<td colspan='10'>데이터를 가져오는데 실패했습니다.</td>";
				$("#wTemp").html(str);
			}
		});
	}
	
	//날씨 표시함수(처음 및 지역버튼 클릭시 실행)
	function showWeather(location){
		$.ajax({
			url : "weather.we",
			data : {
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