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
.search-box-list{
	border-bottom:2px solid lightgray;
	min-height: 100px;
	height: auto;
	text-align: center;
	justify-content: center;
	align-items: center;
	flex-direction: column;
}
.search-box-list img{
	width: 48px;
	float: left;
	margin-left: 10px;
	margin-top: 10px;
}
.search-box-list span{
	display: block;
	margin-top: 5px;
	margin-bottom: 5px;
}
.list-title{
	font-weight: 900;
	font-size: 18px;
}
.list-addr{
	font-size: 16px;
}
.search-box-list button{
	width: 36px;
	height: auto;
	float: center;
	text-align: center;
}
.search-box-list button:hover{
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
	justify-content: center;
	padding: 10px;
	margin-left: -15px;
	margin-bottom: 50px;
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
	                <div class="plan-box">
	                	<span class="plan-img"></span>
	                	<span class="plan-title">${status.count }. 로우앤슬로우</span>
	                	<span>시간 : <input type="time"></span>
	                	<span>메모 : <input type="text"></span>
	                </div>
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
        					
        					str += "<div class='search-box-list'>"
        						+ "<span><img src='resources/img/plan/location-icon.png'></span>"
        						+ "<span class='list-title'>"+item.title+"</span>"
        						+ "<span class='list-addr'>"+item.addr1+item.addr2+"</span>"
        						+ "<button>+</button>"
        						+ "</div>";
        				}
 						$(".search-box").append(str);		
        			},
        			error : function(){
        				console.log("통신오류");
        			}
        		});

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