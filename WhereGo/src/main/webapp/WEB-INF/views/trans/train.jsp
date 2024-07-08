<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>열차 테스트</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
main {
    padding: 20px;
    width: 85%;
    margin: auto;
    margin-top: 5%;
}
select{
	height:30px;
}
.detail-area{
border:1px solid black;
width: 49%;
height:250px;
margin:auto;
display:inline-block;
overflow:visible auto;
}
.detail-title{
border-top:1px solid black;
border-left:1px solid black;
border-right:1px solid black;
background-color:azure;
text-align:center;
width:49%;
height:40px;
margin:auto;
display:inline-block;
}

.station{
	border: 2px solid #333;
    padding: 10px 10px;
    border-radius: 5px;
    font-size: 12px;
    margin-right: 5px;
    margin-bottom:5px;
    width:105px;
	background-color:lightblue;
	color:black;
}
.station-select{
background-color:dodgerblue;
color:white;
}
.area{
	width:150px;
	height:30px;
}
.traintime{
	background-color:orange;
}
#departDate{
	width:150px;
	height:30px;
}
#depdetail,#arrdetail{
	width:100%;
	text-align:center;
	margin-left:auto;
	margin-right:auto;
	margin-top:5px;
}
#stationroute{
	font-size:28px;
	font-weight:900;
	display:none;
}
#search{
	margin:5px 5px;
	width:120px;
	height:40px;
}
#searchResult{
	width:80%;
	display:none;
}
#searchResult th,td{
	text-align:center;
	height:25px;
}
#searchResult th{
	background-color:beige;
}
#loadingContainer {
            display: flex;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(255, 255, 255, 0.8);
            z-index: 9999;
            align-items: center;
            justify-content: center;
            opacity: 0;
            pointer-events: none;
            transition: opacity 0.5s ease;
        }
        #loadingContainer.show {
            opacity: 1;
            pointer-events: auto;
        }
        #loadingAnimation {
            width: 500px;
            height: 500px;
            background-repeat: no-repeat;
            background-size: contain;
            transition: background-image 0.5s ease;
        }
</style>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
	<main>
	<h1>#열차시간표</h1>

	
	
	<div>
		<div class="detail-title">
		<span style="font-size:22px; font-weight:900">출발역 목록 - </span> <select class="area" id="depselect"></select>
		</div>
		<div class="detail-title">
		<span style="font-size:22px; font-weight:900">도착역 목록 - </span> <select class="area" id="arrselect"></select>
		</div>
	<div class="detail-area">
	<table id="depdetail">
	
	</table>
	</div>
	<div class="detail-area">

	<table id="arrdetail">
	
	</table>
	</div>
	
	</div>
	날짜 : <input type="date" id="departDate">
	열차 종류 : 
		<select id="trainselect">
		<option value="0">전체</option>
		<option value="00">KTX</option>
		<option value="01">새마을호</option>
		<option value="02">무궁화호</option>
		</select>
	<br>
	<button id="search" class="btn btn-primary">조회하기</button><br>
	<div id="stationroute">
	<span id="depart"></span>역 >>> <span id="arrive"></span>역
	</div>
	<table border="1" id="searchResult">
	<thead>
		<tr>
			<th style="width:15%">출발지</th>
			<th style="width:20%">출발예정시간</th>
			<th style="width:15%">도착지</th>
			<th style="width:20%">도착예정시간</th>
			<th style="width:10%">열차번호</th>
			<th style="width:20%">열차종류</th>
		</tr>
	</thead>
	<tbody id="trainResult">
	
	</tbody>
	</table>
	</main>
	<!-- 로딩 애니메이션 -->
    <div id="loadingContainer">
        <div id="loadingAnimation"></div>
    </div>
	<script>
	$(function(){
		getArea();
		
		function getArea(){
			$.ajax({
				url : "getArea.tr",
				data : {},
				success : function(result){
					var str="<option value='0'>지역 선택</option>";
					for(var i=0;i<result.length;i++){
						str += "<option value='"+result[i].cityCode+"'>"+result[i].city+"</option>";
					}
					$(".area").html(str);
				},
				error : function(){
					console.log("정보 못가져옴");
				}
			})
		};
		$(".area").on("change", function(){
			console.log("변화감지됨");
			var id=$(this).prop("id");
			var area=$(this).val();
			showLoading();
			$.ajax({
				url : "areadetail.tr",
				data : {
					area : area
				},
				success : function(result){
					var items=$(result).find('item');
					str="<tr>";
					if(id=="depselect"){
					items.each(function(index,item){
						str +="<td><button class='station' name='depstation' value='"+$(item).find('nodeid').text()+"'>"+$(item).find('nodename').text()+"</button></td>"						
						if((index+1)%5==0){
							str +="</tr><tr>";
						} 
					});
					str +="</tr>"
					$("#depdetail").html(str);
					} else if(id=="arrselect") {
					items.each(function(index,item){
						str +="<td><button class='station' name='arrstation' value='"+$(item).find('nodeid').text()+"'>"+$(item).find('nodename').text()+"</button></td>"						
						if((index+1)%5==0){
							str +="</tr><tr>";
						}
					});
					str +="</tr>"
					$("#arrdetail").html(str);
					}
					
				},
				error : function(){
					console.log("확인불가");
				},
				complete : function(){
					hideLoading();
				}
			}); 
		});

		
		$("#search").click(function(){
			var train=$("#trainselect").val();
			var depart=$("#departid").val();
			var arrive=$("#arriveid").val();
			var date=$("#departDate").val();
			if(depart==arrive || depart==null || arrive==null) {
				alert("출발지와 목적지가 제대로 선택되지 않았습니다.");
			} else if(date==""){
				alert("날짜가 선택되지 않았습니다.");
			} else {
				showLoading();
				$.ajax({
					url : "traintest.tr",
					data : {
						departDate : date,
						departNo : depart,
						arriveNo : arrive,
						trainNo : train
					},
					success : function(result){
						var count=$(result).find('totalCount').text();
						if(count=="0"){
							alert("검색된 결과가 없습니다.");
						} else {
						var str="";
						var items=$(result).find('item');
						items.each(function(index,item){
							var dTime=$(item).find('depplandtime').text().substring(8,10)+"시 "+$(item).find('depplandtime').text().substring(10,12)+"분";
							var aTime=$(item).find('arrplandtime').text().substring(8,10)+"시 "+$(item).find('arrplandtime').text().substring(10,12)+"분";
							str +="<tr>"
								+"<td>"+$(item).find('depplacename').text()+"</td>"
								+"<td class='traintime'>"+dTime+"</td>"
								+"<td>"+$(item).find('arrplacename').text()+"</td>"								
								+"<td class='traintime'>"+aTime+"</td>"
								+"<td>"+$(item).find('trainno').text()+"</td>"
								+"<td>"+$(item).find('traingradename').text()+"</td>"
								+"</tr>";
						});
						$("#trainResult").html(str);
						$("#searchResult").show();
						$("#stationroute").show();
					}},
					error : function(){
						console.log("실행실패");
					},
					complete : function(){
						hideLoading();
					}
				});
			}
		});
		
		$(document).on("click","button[class=station]",function(){
			var station=$(this).prop("name");
			var id=$(this).val();
			var name=$(this).text();
			var str="";
			if(station=="depstation"){
				str +="<input type='hidden' id='departid' value='"+id+"'>"
					+name;
				$("#depart").html(str);
				$("#depdetail button").removeClass("station-select");
				$(this).addClass("station-select");
			} else {
				str +="<input type='hidden' id='arriveid' value='"+id+"'>"
				+name;
				$("#arrive").html(str);
				$("#arrdetail button").removeClass("station-select");
				$(this).addClass("station-select");
			}
			
		});
		
		function formatDate(date) {
		    let d = new Date(date),
		        month = '' + (d.getMonth() + 1),
		        day = '' + d.getDate(),
		        year = d.getFullYear();

		    if (month.length < 2) month = '0' + month;
		    if (day.length < 2) day = '0' + day;

		    return [year, month, day].join('-');
		}

		const today = new Date();
		const maxDate = new Date();
		maxDate.setDate(today.getDate() + 30);
		
		$("#departDate").attr("value",formatDate(today));
		$("#departDate").attr("min",formatDate(today));
		$("#departDate").attr("max",formatDate(maxDate));
		
		//로딩창 구현 메소드
		var loadingInterval;
        var loadingVisible = false;

        function showLoading() {
            var loadingContainer = document.getElementById('loadingContainer');
            loadingContainer.classList.add('show');
            var loadingAnimation = document.getElementById('loadingAnimation');
            var imageIndex = 1;

            loadingInterval = setInterval(function() {
                imageIndex = (imageIndex % 5) + 1;
                loadingAnimation.style.backgroundImage = 'url("<c:url value="/resources/image/loading/load' + imageIndex + '.png" />")';
            }, 250);
            loadingVisible = true;
        }

        function hideLoading() {
            var loadingContainer = document.getElementById('loadingContainer');
            loadingContainer.classList.remove('show');
            clearInterval(loadingInterval);
            loadingVisible = false;
        }

	});
	</script>
	<%@ include file="../common/footer.jsp" %>
</body>
</html>