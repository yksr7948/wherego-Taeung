<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* 플래너 리스트 */
.planner-container {
    width: 60%;
    min-height: 800px;
    margin: 20px auto;
    margin-top: 5%;
    padding: 20px;
    background-color: white;
    border: 1px solid lightgray;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}
.plan-title {
    display: flex;
    justify-content: space-between;
    align-items: center;
}
.plan-title p {
	font-weight: 900;
	font-size: 48px;
    text-align: left;
    color: #333;
}
.login-button {
	text-align: right;
}
.planner-grid {
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
}
.planner-empty{
	width: 100%; 
	font-size: 24px; 
	font-weight: 900; 
	text-align: center;
	margin-top: 30px;
}
.planner-item {
    background-color: #fafafa;
    border: 1px solid #ddd;
    border-radius: 10px;
    width: 300px;
    margin-bottom: 20px;
    box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
}
.planner-item img {
    width: 300px;
    height: 200px;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
}
.planner-info {
    padding: 15px;
}
.planner-info p {
    margin: 5px 0;
    color: #555;
}
.detail-button {
    display: block;
    width: 100%;
    padding: 10px;
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
.detail-button:hover {
    background-color: black;
    color: white;
}

/* 모달 영역 */
#plannerModal{
	display: none; 
    position: fixed; 
    z-index: 9999; 
    left: 0;
    top: 0;
    width: 100%; 
    height: 100%; 
    overflow: auto; 
    background-color: rgb(0,0,0); 
    background-color: rgba(0,0,0,0.4); 
    padding-top: 60px; 
}
.date-form {
	display: flex;
	align-items: center;
	gap: 0.5rem;
	margin-bottom: 20px;
}

.date-form input {
    width: 120px;
}

.input-group {
	display: flex;
	align-items: center;
}

.input-group-text {
	margin-left: 0.5rem;
	cursor: pointer;
}
.ui-datepicker {
	z-index: 9999 !important; /* 캘린더가 모달 앞에 오도록 z-index 설정 */
}
</style>
</head>
<body>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
    
    <div class="planner-container">
        <div class="plan-title">
        	<p>내 플래너</p>
			<button class="login-button" data-toggle="modal" data-target="#plannerModal">새 플래너 작성</button>
        </div>
        
        <hr>
        
        <div class="planner-grid">
        		<c:choose>
	        		<c:when test="${empty plannerList }">
	        			<div class="planner-empty" >조회된 결과가 없습니다.</div>
	        		</c:when>
	        		<c:otherwise>
        				<c:forEach items="${plannerList}" var="planner" varStatus="status">
				            <div class="planner-item">
				                <img src="${planList[status.index].firstImage }" alt="">
				                <div class="planner-info">
				                    <p style="font-size: 24px; font-weight: 900;">${planner.title }</p>
				                    <p>${planner.description }</p>
				                    <p style="color: #888; font-size: 16px">${planner.startDate } ~ ${planner.endDate }</p>
            						<button class="detail-button" onclick="location.href='plannerDetailView.pl?plannerNo=${planner.plannerNo}'">상세보기</button>
				                </div>
				            </div>
			        	</c:forEach>
	        		</c:otherwise>
        		</c:choose>
        </div>
    </div>
    
    <script>

    </script>
    
    <!-- 모달 -->

	<div class="modal fade" id="plannerModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h2 class="modal-title" style="font-weight: 900; font-size:36px;">플래너 만들기</h2>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	
	        <form action="insertPlanner.pl">
	      		<!-- Modal body -->
	      		<div class="modal-body">
	      			
	      			<input type="hidden" value="${loginUser.userId }">
		        	<label for="planner-title" style="font-weight: 900;">여행제목 :</label>
		        	<input type="text" class="form-control mb-2 mr-sm-2" id="planner-title" name="title" required> <br>
		        	
		        	<label for="startDate" style="font-weight: 900;">여행기간 :</label>
    				<div class="date-form">
      					<div class="input-group mb-2 mr-sm-2">
        					<input type="text" id="startDate" class="form-control" name="startDate" placeholder="시작 날짜" required/>
        					<label class="input-group-text" for="startDate"><i class="fa-regular fa-calendar"></i></label>
      					</div>
      					<span>~</span> &nbsp;
				      	<div class="input-group mb-2 mr-sm-2">
				        	<input type="text" id="endDate" class="form-control" name="endDate" placeholder="마지막 날짜" required/>
				        	<label class="input-group-text" for="endDate"><i class="fa-regular fa-calendar"></i></label>
				      	</div>
				    </div>
					
		        	<label for="description" style="font-weight: 900;">여행설명 :</label>
		        	<input type="text" class="form-control mb-2 mr-sm-2" id="description" name="description"> <br>
		        	
	     		</div>
	
	      		<!-- Modal footer -->
		    	<div class="modal-footer">
			        <button type="submit" class="login-button">작성</button>
			        <button type="button" class="login-button" data-dismiss="modal">닫기</button>
			    </div>
	        </form>
	
	    </div>
	  </div>
	</div>
	
	<script>
		$(document).ready(function () {
			
			
			$("#startDate").datepicker({
				dateFormat: "yy-mm-dd", // 날짜의 형식
				minDate: 0,
				nextText: ">",
				prevText: "<",
				onSelect: function (date) {
					var endDate = $('#endDate');
					var startDate = $(this).datepicker('getDate');
					var minDate = $(this).datepicker('getDate');
					endDate.datepicker('setDate', minDate);
					//여행일은 최대 10개까지
					startDate.setDate(startDate.getDate() + 9);
					endDate.datepicker('option', 'maxDate', startDate);
					endDate.datepicker('option', 'minDate', minDate);
				}
			});
			$('#endDate').datepicker({
				dateFormat: "yy-mm-dd", // 날짜의 형식
				nextText: ">",
				prevText: "<"
			});
		});
	</script>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.10.2/umd/popper.min.js"></script>
</body>
</html>