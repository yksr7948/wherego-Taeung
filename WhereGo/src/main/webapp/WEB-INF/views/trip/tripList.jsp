<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>

main {
    padding: 20px;
    width: 60%;
    margin: auto;
    margin-top: 5%;
}
#area-title{
	font-weight: 900;
}

/* 지역별 이동 버튼 */
.area-container {
    text-align: left;
    margin-bottom: 40px;
    margin-left: 30px;
}
.area-container a {
	border: 1px solid lightgrey;
	background-color: white;
    color: black;
    padding: 10px 20px;
    border-radius: 5px;
    font-size: 16px;
    transition: background-color 0.3s, color 0.3s;
    margin-right: 10px;
}
.area-container a:hover {  
	background-color: lightgrey;
    color: white;
    cursor: pointer;
}

/* 여행지 리스트*/
.card-container {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    justify-content: center;
    padding: 20px;
}
.card {
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 8px;
    overflow: hidden;
    width: 300px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    transition: transform 0.2s;
    flex: 0 0 calc(25% - 20px);
    box-sizing: border-box;
}

.card:hover {
    transform: scale(1.05);
    cursor: pointer;
}

.card>img {
    width: 100%;
    height: 200px;
    object-fit: cover;
}

.card-content {
    padding: 15px;
}

.card-content h2 {
    margin: 0 0 10px;
    font-size: 18px;
}

.card-content p {
    margin: 0;
    color: #555;
    font-size: 11px;
}


/* 페이징처리 */
.pagination {
    display: flex;
    justify-content: center;
    padding: 20px 0;
    margin:auto;
}
.pagination li>a{
	width: 50px;
	height: auto;
	color: black;
	text-align: center;
	margin-right: 10px;
}
.pagination li>a:hover {
    background-color: lightgray;
}
.current-page a{
	color: black;
	background: lightgray;
	cursor: auto;
}
</style>
</head>
<body>

<%@include file="/WEB-INF/views/common/header.jsp" %>

	
	<main>
		<h1 id="area-title"># 여행지 > 전체</h1>
		
		<br> <br> <hr> <br> <br> <br>
		
		<div class="area-container">
			<a href="areaList.tl?areaCode=1">서울</a>
			<a href="areaList.tl?areaCode=2">인천</a>
			<a href="areaList.tl?areaCode=3">대전</a>
			<a href="areaList.tl?areaCode=4">대구</a>
			<a href="areaList.tl?areaCode=5">광주</a>
			<a href="areaList.tl?areaCode=6">부산</a>
			<a href="areaList.tl?areaCode=7">울산</a>
			<a href="areaList.tl?areaCode=31">경기</a>
			<a href="areaList.tl?areaCode=32">강원</a>
			<a href="areaList.tl?areaCode=39">제주</a>
		</div>
		<div class="card-container">
			<c:forEach items="${tList }" var="t">
			<div class="card">
				<input type="hidden" value="${t.contentId }">
				<img src="${t.firstImage2 }" alt="">
				<div class="card-content">
					<h2>${t.title }</h2>
					<p>${t.addr1 }</p>
					<br>
					<p><img src="resources/img/trip-board/eye-icon.png"> ${t.count} &nbsp;
					   <img src="resources/img/trip-board/heart-icon.png"> ${t.likeCount}</p>
				</div>
			</div>
			</c:forEach>
		</div>
		
		<div id="pagingArea">
                <ul class="pagination">
                	
					<!-- 페이징바 이전처리 -->
                	<c:choose>
                		<c:when test="${pi.currentPage eq 1 }">
                			<li class="page-item disabled"><a class="page-link" href="#">&laquo;</a></li>
		                    <li class="page-item disabled"><a class="page-link" href="#">&lt;</a></li>
                		</c:when>
                		<c:otherwise>
                			<li class="page-item"><a class="page-link" href="tripList.tl?currentPage=1">&laquo;</a></li>
                			<li class="page-item"><a class="page-link" href="tripList.tl?currentPage=${pi.currentPage-1 }">&lt;</a></li>
                		</c:otherwise>
                	</c:choose>
                	
					<!-- 페이징바 번호 뽑아주기 -->
                	<c:forEach begin="${pi.startPage }" end="${pi.endPage }" var="p">
                		<li class="<c:if test='${pi.currentPage == p}'>current-page</c:if>">
        				<a class="page-link" href="tripList.tl?currentPage=${p}">${p}</a>
    					</li>
                	</c:forEach>
                    
                    <!-- 페이징바 다음처리 -->
                    <c:choose>
                    	<c:when test="${pi.currentPage eq pi.maxPage }">
                    		<li class="page-item disabled"><a class="page-link" href="#">&gt;</a></li>
                    		<li class="page-item disabled"><a class="page-link" href="#">&raquo;</a></li>
                    	</c:when>
                    	<c:otherwise>
                    		<li class="page-item"><a class="page-link" href="tripList.tl?currentPage=${pi.currentPage+1}">&gt;</a></li>
                    		<li class="page-item"><a class="page-link" href="tripList.tl?currentPage=${pi.maxPage}">&raquo;</a></li>
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
		})
	</script>

	<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>