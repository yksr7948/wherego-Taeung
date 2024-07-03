<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.plan-container {
	width: 100%;
	margin: 0px auto;
	display: flex;
	min-height: 900px;
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

.save-button {
	display: flex;
	justify-content: space-around;
	padding: 10px;
	margin-left: -15px;
	margin-bottom: 100px;
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
	justify-content: center; /* 세로 중앙 정렬 */
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

/* map(맵) */
.map-box {
	width: 55%;
	background-color: #f4f4f9;
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
            <div class="save-button">
                <button class="login-button">저장</button>

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
                <input type="text" value="이태원 맛집" id="keyword" size="15">
                <button type="submit">검색</button>
            </div>
        </div>

         <!-- map -->
        <div class="map-box">
            
        </div>
    </div>
	
	
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>