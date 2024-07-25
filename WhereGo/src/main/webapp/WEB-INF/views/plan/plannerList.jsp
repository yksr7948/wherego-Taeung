<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/planList-style.css">
</head>
<body>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
    <input id="userId" type="hidden" value="${loginUser.userId }">
    
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
				                <!-- 플래너 번호에 맞는 이미지 가져오기 -->
				            	<c:set var="firstImage" value="" />
				                <c:forEach items="${planList}" var="plan" varStatus="planStatus">
							            <c:if test="${plan.plannerNo == planner.plannerNo && empty firstImage}">
							            	<c:set var="firstImage" value="${plan.firstImage}" />
							            </c:if>
						        </c:forEach>

						        <img src="${firstImage}" alt="">
				                <div class="planner-info">
				                    <p style="font-size: 24px; font-weight: 900;">${planner.title }</p>
				                    <p>${planner.description }</p>
				                    <p style="color: #888; font-size: 16px">${planner.startDate } ~ ${planner.endDate }</p>
            						<div class="button-area">
	            						<button class="detail-button" onclick="location.href='plannerDetailView.pl?plannerNo=${planner.plannerNo}'">상세보기</button>
	            						<button class="delete-button" onclick="deletePlanner('${planner.plannerNo}');">삭제하기</button>
            						</div>
				                </div>
				            </div>
			        	</c:forEach>
	        		</c:otherwise>
        		</c:choose>
        </div>
    </div>
    
    <script>
    	//플래너 삭제하기
		function deletePlanner(plannerNo){
    		
			var result = confirm("댓글을 삭제하시면 다시 되돌릴 수 없습니다. 정말 삭제하시겠습니까?");
			
			if(result){
				$.ajax({
					url : "deletePlanner.pl",
					data : {
						plannerNo
					},
					success : function(response){
						console.log(response);
						if(response == '1'){
							alertify.alert('<img src="resources/img/removebg-preview.png" style="width: 30px;">',"삭제되었습니다.",function(){
								location.href = "planner.pl?userId="+$("#userId").val();
							});
						}else{
							alertify.alert('<img src="resources/img/removebg-preview.png" style="width: 30px;">',"삭제 도중 오류 발생...");
						}
					},
					error : function(){
						console.log("에러");
					}
				});
			}
    		
		}
    	
    	
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