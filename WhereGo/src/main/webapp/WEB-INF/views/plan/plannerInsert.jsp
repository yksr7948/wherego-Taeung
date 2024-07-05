<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=7whhnl24e7"></script>
<style>
.plan-container {
	width: 100%;
	margin: 0px auto;
	display: flex;
	min-height: 1000px;
	height: auto;
}

/* 일정(days) */
.days-box {
	width: 8%;
	box-sizing: border-box;
	background-color: #2C3E50;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

.days-box-content {
	display: flex;
	flex-direction: column;
}

.days-box-title {
	height: 80px;
	color: white;
	text-align: center;
	font-size: 36px;
	font-weight: 900;
	border-bottom: 2px solid lightgray;
	display: flex;
	align-items: center;
	justify-content: center;
}

.day-box {
	height: 100px;
	color: white;
	text-align: center;
	font-size: 24px;
	font-weight: 900;
	border-bottom: 2px solid lightgray;
	cursor: pointer;
}

.day-box span {
	display: block;
	margin: 15px 0;
}

.fomat-date {
	font-size: 16px;
}

/* plan-box(플랜 목록) */
.day-plan-box {
	width: 15%;
	background-color: #f4f4f9;
	border: 2px solid lightgray;
}
.plans-box-title {
	height: 80px;
	color: white;
	text-align: center;
	font-size: 24px;
	font-weight: 900;
	display: flex;
	align-items: center;
	justify-content: center;
	background-color: rgba(0, 0, 0, 0.5);
}
.plan-box {
	text-align: center;
	justify-content: center;
	align-items: center;
	height: 200px;
	border-bottom: 2px solid lightgray;
	display: flex;
	flex-direction: column; /* 세로로 정렬 */
}
.plan-title {
	font-size: 24px;
	font-weight: 900;
}
.plan-box span {
	display: block;
	margin-bottom: 15px;
}
.plan-box input{
	width: 170px;
}

/* search-box(검색) */
.search-box {
	width: 22%;
	background-color: #f4f4f9;
	border: 2px solid lightgray;
}

.search-box input {
	width: 60%;
	height: 30px;
	border-radius: 5px;
	font-size: 16px;
}

.search-box button {
	margin-left: 10px;
	width: 80px;
	height: 30px;
	background-color: white;
	text-align: center;
	color: black;
	border: 2px solid black;
	border-radius: 5px;
	font-size: 16px;
	font-weight: 900;
	cursor: pointer;
	transition: background-color 0.3s, color 0.3s;
}

.search-box-list {
	border-bottom: 2px solid lightgray;
	min-height: 100px;
	display: flex;
	align-items: center;
	padding: 10px;
}

.search-box-list img {
	width: 12%;
}

.list-content {
	width: 80%;
	display: flex;
	flex-direction: column;
	text-align: center;
}

.list-title {
	font-size: 21px;
	font-weight: 900;
}

.list-addr {
	color: grey;
}
.search-box-list button {
	width: 8%;
	margin-left: auto;
	display: flex;
	justify-content: center;
	align-items: center;
}
.search-box-list button:hover {
	background-color: black;
	color: white;
}

/* map(맵) */
.map-box {
	width: 55%;
	background-color: #f4f4f9;
}

/* 버튼 */
.save-button {
	display: flex;
	justify-content: center; padding : 10px;
	margin-left: -15px;
	margin-bottom: 50px;
	padding: 10px;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<!-- 플래너 작성 -->
	<div class="plan-container">
	
        <!-- days div -->
        <div class="days-box">
            <div class="days-box-content">
                <div class="days-box-title">일정</div>
                
                <c:forEach items="${days }" var="day" varStatus="status">
	                <div class="day-box" onclick="planChange(${status.count})">
	                    <span>DAY${status.count }</span>
	                    <span class="fomat-date"><fmt:formatDate value="${day}" pattern="MM.dd (E)" /></span>
	                </div>
                </c:forEach> 
            </div>
        </div>

        <!-- days plan div -->
        <div class="day-plan-box">
        
        	<c:forEach items="${days }" var="day" varStatus="status">
	            <div class="plans-box" data-date="<fmt:formatDate value="${day }" pattern="yyyy-MM-dd"/>">
	                <div class="plans-box-title">DAY${status.count } | <fmt:formatDate value="${day }" pattern="MM.dd E요일"/></div>
	            </div>
        	</c:forEach>
        	
        </div>
        
        <!-- day-box 변경 -->        
       	<script>
       			
      	var planslide =  document.querySelectorAll(".plans-box");
       	
	    planChange(1);
	      		
	    function planChange(n){
	      	
	    	for(var i=1; i<=planslide.length; i++){
	    		planslide[i-1].style.display = "none";
	    	}
	    	planslide[n-1].style.display = "block";
	    }
		</script>
		
        <!-- search-box -->
        <div class="search-box">
            <div class="days-box-title">
                <input type="text" id="plan-keyword" size="15">
                <button type="button" onclick="searchPlace();">검색</button>
            </div>
        </div>
        
        <!-- search js -->
        <script>
	        var markers = [];
	        var paths = [];
            
        	function searchPlace(){
        		
        		$(".search-box-list").remove();
        		
        		$.ajax({
        			url : "searchPlace.pl",
        			data : {
        				keyword : $("#plan-keyword").val()
        			},
        			success : function(list){
        				
	        			var items = list.response.body.items.item;
	        			
	        			var str = "";
	        			
        				for(var i=0;i<items.length;i++){
        					
        					var item = items[i];
        					var itemStr = JSON.stringify(item);
        					
        					str += "<div class='search-box-list'>"
        						+ "<img src='resources/img/plan/location-icon.png'>"
        						+ "<span class='list-content'>"
        						+ "<span class='list-title'>"+item.title+"</span>"
        						+ "<span class='list-addr'>"+item.addr1+item.addr2+"</span>"
        						+ "</span>"
        						+ "<button class='add-plan-button' data-item='" + itemStr + "'>+</button>"
        						+ "</div>";
        				}
 						$(".search-box").append(str);	
 						
 			        	$(".add-plan-button").on("click",function(){
 			        		var item = $(this).data("item");
 			        		addPlan(item);
 			        	});
        			},
        			error : function(){
        				console.log("통신오류");
        			}
        		});
        	}
        	
        	function addPlan(item){
        		
        		 var parent =  $('.plans-box[style*="display: block"]');
        	     var data_date = parent.attr('data-date');
        	     var num = parent.children().length; // 하위 엘리먼트기에 일정 - 제목 (DAY) 부분도 포함됨
        	     
        	     var latlng = new naver.maps.LatLng(item.mapy, item.mapx);
                 var marker = new naver.maps.Marker({
                     position: latlng,
                     map: map,
                     title: item.title // 타이틀 추가
                 });
                 
                 markers.push(marker);
                 map.setCenter(latlng);
                 
              // 마커 사이에 선 긋기
                 if (markers.length > 1) {
                     var path = new naver.maps.Polyline({
                         map: map,
                         path: [markers[markers.length - 2].getPosition(), marker.getPosition()],
                         strokeColor: '#5347AA',
                         strokeWeight: 2
                     });
                     paths.push(path);
                 }
		
        	    if(num<6){ // 일정은 5개까지만 추가 가능
        	        parent.append(getHtml(item.title, item.mapx, item.mapy, num, data_date));
        	    }else{
        	        alert("한번에 5개의 관광지를 선택 할 수 있습니다.");
        	    }
        	}
        	
        	function getHtml(title, mapx, mapy, num, data_date){
        	   
        		var div = '<div class="plan-box" data-date="' + data_date + '" data-y = "' + mapy + '" data-x = "' + mapx + '" data-place = "' + title + '" data-planNo="">';
					div += '<span class="plan-title">' + num + " . "+ title + '</span>'
					div += '<span>시간 : <input type="time"></span>'
					div += '<span>메모 : <input type="text"></span>'
					div += '</div>';

        	    return div;
        	}
        </script>

         <!-- map -->
        <div class="map-box" id="plan-map">
            
        </div>
        
	    <!-- map api -->
	    <script>
	    
		var map = new naver.maps.Map('plan-map', {
		    center: new naver.maps.LatLng(37.5536472, 126.9678003),
		    zoom: 15
		});
        
	    </script>
    </div>
    
    <br> <br> <br> 
    <div class="save-button">
		<button class="login-button">저장</button>
		<button class="login-button">취소</button>
	</div>
    
	
      
	
	
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>