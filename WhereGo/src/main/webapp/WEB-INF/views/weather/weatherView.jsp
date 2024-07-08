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
	border: 2px solid #333;
    padding: 10px 20px;
    border-radius: 5px;
    font-size: 16px;
    margin-right: 10px;
}
.weather-info{
	margin:auto;
}
.weather-info th{
background-color:beige;
}
#wArea{
	height:70px;
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
width:90px;
height:110px;
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
.location-selected{
background-color:dodgerblue;
color:white;
}
.location-detail-btn{
width:80px;
background-color:lightblue;
color:black;
}
.location-detail-btn:hover{
background-color:#3333ff;
color:white;
}
.location-detail-selected{
background-color:#3333ff;
color:white;
}
#notice{
font-size:26px;
}
</style>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
	<main>
	<div class="weather-area">
		<table class="weather-container">
			<tr id="wArea">
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
	<h2 id="area">${area }의 날씨</h2>
		<table class="weather-info" border="1">
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
		<div id="notice"></div>
	</div>
	</main>
	<script>
	$(function(){
		showDate();/* 처음 실행시 날짜 구성 */
		showTemperature("${area}"); /* 처음실행시 기온 조회(서울) */
		showWeather("${area}"); /* 처음 실행시 날씨 및 강수확률 조회(서울) */
		
		$(".location-btn").click(function(){
			getDetailLocation($(this).html());
			$("button").removeClass("location-selected");
			$(this).addClass("location-selected");
		})
		
		$("#wLocation").on("click",".location-detail-btn",function(){
			var area=$(this).html();
			showTemperature(area);
			showWeather(area);
			$("#area").html(area+"의 날씨");
			$("button").removeClass("location-detail-selected");
			$(this).addClass("location-detail-selected");
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
					switch(list[i].substring(6,7)){
					case "토" : str +="<td colspan='2' style='color:blue'>"+list[i]+"</td>"; break;
					case "일" : str +="<td colspan='2' style='color:red'>"+list[i]+"</td>";break;
					default:
						str +="<td colspan='2'>"+list[i]+"</td>";
					}
					
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
		var sido=$(".location-selected").html();
		var area=location;
		$.ajax({
			url : "temperature.we",
			data : {
				location : area,
				sido : sido
			},
			success : function(result){
				var data=$(result).find('item');
				var hotFlag=false;
				var coldFlag=false;
				var changeFlag=false;
				var str="<th> 최저 / 최고기온 </th>";
					for(var i=3;i<8;i++) {
						var min="taMin"+i;
						var max="taMax"+i;
						var minTemp=$(data).find(min).text();
						var maxTemp=$(data).find(max).text();
						str +="<td colspan='2'><span style='color:blue'>"+minTemp+"℃</span> / <span style='color:red'>"+maxTemp+"℃ </span></td>"
						if(maxTemp>=35){
							hotFlag=true;
						} else if(minTemp<-5) {
							coldFlag=true;
						}
						if((maxTemp-minTemp)>10){
							changeFlag=true;
						}
					}
				$("#wTemp").html(str);
				var notice="";
				if(hotFlag) {
					notice +="해당 지역의 날씨가 매우 더울 것으로 예상되므로 여행 계획을 짤 때 주의하시기 바랍니다.<br>";
				}
				if(coldFlag) {
					notice +="해당 지역의 날씨가 매우 추울 것으로 예상되므로 여행 계획을 짤 때 주의하시기 바랍니다.<br>";
				}
				if(changeFlag) {
					notice +="해당 지역의 일교차가 매우 심할 것으로 예상되므로 여행 계획을 짤 때 주의하시기 바랍니다.<br>";
				}
				$("#notice").html(notice);
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
		var sido=$(".location-selected").html();
		$.ajax({
			url : "weather.we",
			data : {
				location : location,
				sido : sido
			},
			method : "post",
			success : function(result){
				var data=$(result).find('item');
				var str1="<th> 강수확률(%) </th>"
				for(var i=3;i<8;i++) {
					var am="rnSt"+i+"Am";
					var pm="rnSt"+i+"Pm";
					var rainAm=$(data).find(am).text();
					var rainPm=$(data).find(pm).text();
					str1 +="<td>"+rainAm+"</td>"
						  +"<td>"+rainPm+"</td>";
				}
				$("#wRain").html(str1);
				
				let arr=new Array();
				var str2="<th> 날씨 상태 </th>";
				for(var i=3;i<8;i++){
					var am="wf"+i+"Am";
					var pm="wf"+i+"Pm";
					arr.push($(data).find(am).text());
					arr.push($(data).find(pm).text());
				}
				for(var i=0;i<arr.length;i++){
					var weather="";
					switch(arr[i]){
					case "맑음": weather="sun"; break;
					case "구름많음": weather="sun_cloudy"; break;
					case "흐림": weather="cloud";	 break;
					case "흐리고 비": weather="rain"; break;
					case "구름많고 비": weather="rain"; break;
					case "구름많고 소나기": weather="sun_cloud_rain"; break;
					case "흐리고 눈": weather="snow"; break;
					}
					str2 +="<td><img src='resources/img/weather/"+weather+".png' width='65' height='65' alt='날씨'><br>"+arr[i]+"</td>";
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