<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/tripList-style.css">
</head>
<body>

<%@include file="/WEB-INF/views/common/header.jsp" %>

	
	<main>
		<h1 id="area-title"># ${type} > ${location}</h1>
		
		<br> <br> <hr> <br> <br> <br>
		
		<div class="area-container">
			<a href="areaList.tl?contentTypeId=${aList[0].contentTypeId}&areaCode=1">서울</a>
			<a href="areaList.tl?contentTypeId=${aList[0].contentTypeId}&areaCode=2">인천</a>
			<a href="areaList.tl?contentTypeId=${aList[0].contentTypeId}&areaCode=3">대전</a>
			<a href="areaList.tl?contentTypeId=${aList[0].contentTypeId}&areaCode=4">대구</a>
			<a href="areaList.tl?contentTypeId=${aList[0].contentTypeId}&areaCode=5">광주</a>
			<a href="areaList.tl?contentTypeId=${aList[0].contentTypeId}&areaCode=6">부산</a>
			<a href="areaList.tl?contentTypeId=${aList[0].contentTypeId}&areaCode=7">울산</a>
			<a href="areaList.tl?contentTypeId=${aList[0].contentTypeId}&areaCode=31">경기</a>
			<a href="areaList.tl?contentTypeId=${aList[0].contentTypeId}&areaCode=32">강원</a>
			<a href="areaList.tl?contentTypeId=${aList[0].contentTypeId}&areaCode=39">제주</a>
		</div>
		<div class="card-container">
			<c:forEach items="${aList }" var="a">
			<div class="card">
				<input type="hidden" value="${a.contentId }">
				<img src="${a.firstImage2 }" alt="">
				<div class="card-content">
					<h2>${a.title }</h2>
					<p>${a.addr1 }</p>
					<br>
					<p><img src="resources/img/trip-board/eye-icon.png"> ${a.count}</p>
					<p><img src="resources/img/trip-board/heart-icon.png"> ${a.likeCount}</p>
				</div>
			</div>
			</c:forEach>
		</div>
		
		<br> <br> <br>
		
		<h1></h1>
		
		<div id="pagingArea">
                <ul class="pagination">
                	
					<!-- 페이징바 이전처리 -->
                	<c:choose>
                		<c:when test="${pi.currentPage eq 1 }">
                			<li class="page-item disabled"><a class="page-link" href="#">&laquo;</a></li>
		                    <li class="page-item disabled"><a class="page-link" href="#">&lt;</a></li>
                		</c:when>
                		<c:otherwise>
                			<li class="page-item"><a class="page-link" href="areaList.tl?contentTypeId=${aList[0].contentTypeId}&areaCode=${aList[0].areaCode}&currentPage=1">&laquo;</a></li>
                			<li class="page-item"><a class="page-link" href="areaList.tl?contentTypeId=${aList[0].contentTypeId}&areaCode=${aList[0].areaCode}&currentPage=${pi.currentPage-1 }">&lt;</a></li>
                		</c:otherwise>
                	</c:choose>
                	
					<!-- 페이징바 번호 뽑아주기 -->
                	<c:forEach begin="${pi.startPage }" end="${pi.endPage }" var="p">
                		<li class="<c:if test='${pi.currentPage == p}'>current-page</c:if>">
        				<a class="page-link" href="areaList.tl?contentTypeId=${aList[0].contentTypeId}&areaCode=${aList[0].areaCode}&currentPage=${p}">${p}</a>
    					</li>
                	</c:forEach>
                    
                    <!-- 페이징바 다음처리 -->
                    <c:choose>
                    	<c:when test="${pi.currentPage eq pi.maxPage }">
                    		<li class="page-item disabled"><a class="page-link" href="#">&gt;</a></li>
                    		<li class="page-item disabled"><a class="page-link" href="#">&raquo;</a></li>
                    	</c:when>
                    	<c:otherwise>
                    		<li class="page-item"><a class="page-link" href="areaList.tl?contentTypeId=${aList[0].contentTypeId}&areaCode=${aList[0].areaCode}&currentPage=${pi.currentPage+1}">&gt;</a></li>
                    		<li class="page-item"><a class="page-link" href="areaList.tl?contentTypeId=${aList[0].contentTypeId}&areaCode=${aList[0].areaCode}&currentPage=${pi.maxPage}">&raquo;</a></li>
                    	</c:otherwise>
                    </c:choose>
                </ul>
          </div>
	</main>
	
	<script>
		$(function(){
			$(".card").click(function(){
				var contentId = $(this).children().first().val();
				location.href = "tripDetail.tl?contentId="+contentId;
			})
		});
	</script>

	<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>