<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색-여행지</title>
<style>
main {
    padding: 10px;
    width: 80%;
    margin: auto;
    margin-top: 2%;
}
.card-container {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    justify-content: left;
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
.content-type{
	border: 2px solid black;
	background-color: white;
    color: black;
    padding: 10px 20px;
    border-radius: 5px;
    font-size: 16px;
    transition: background-color 0.3s, color 0.3s;
    margin-right: 10px;
}
.content-type:hover{
	background-color: black;
    color: white;
    cursor: pointer;
}
.content-type-selected{
	background-color: black;
    color: white;
}
</style>
</head>
<body>
	<%@ include file="header.jsp" %>
	<main>
		<h2>${keyword }(으)로 검색된 여행지 : </h2>
		<div>
			<c:forEach items="${contentType }" var="ct">
			<c:choose>
			<c:when test="${ct.value eq id }">
				<button class="content-type content-type-selected" value="${ct.value }">${ct.key} </button>
			</c:when>
			<c:otherwise>
				<button class="content-type" value="${ct.value }">${ct.key} </button>
			</c:otherwise>
			</c:choose>
			</c:forEach>
			</div>
			<br><br>
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
                			<li class="page-item"><a class="page-link" href="searchDetail.wherego?keyword=${keyword }&currentPage=1">&laquo;</a></li>
                			<li class="page-item"><a class="page-link" href="searchDetail.wherego?keyword=${keyword }&currentPage=${pi.currentPage-1 }">&lt;</a></li>
                		</c:otherwise>
                	</c:choose>
                	
					<!-- 페이징바 번호 뽑아주기 -->
                	<c:forEach begin="${pi.startPage }" end="${pi.endPage }" var="p">
                		<li class="<c:if test='${pi.currentPage == p}'>current-page</c:if>">
        				<a class="page-link" href="searchDetail.wherego?keyword=${keyword }&contentTypeId=${id}&currentPage=${p}">${p}</a>
    					</li>
                	</c:forEach>
                    
                    <!-- 페이징바 다음처리 -->
                    <c:choose>
                    	<c:when test="${pi.currentPage eq pi.maxPage }">
                    		<li class="page-item disabled"><a class="page-link" href="#">&gt;</a></li>
                    		<li class="page-item disabled"><a class="page-link" href="#">&raquo;</a></li>
                    	</c:when>
                    	<c:otherwise>
                    		<li class="page-item"><a class="page-link" href="searchDetail.wherego?keyword=${keyword }&currentPage=${pi.currentPage+1}">&gt;</a></li>
                    		<li class="page-item"><a class="page-link" href="searchDetail.wherego?keyword=${keyword }&currentPage=${pi.maxPage}">&raquo;</a></li>
                    	</c:otherwise>
                    </c:choose>
                </ul>
          </div>
	</main>
	<%@ include file="footer.jsp" %>
	<script>
	$(function(){
		
		$(".card").click(function(){
			var contentId = $(this).children().first().val();
			location.href = "tripDetail.tl?contentId="+contentId;
		});
		
		$(".content-type").click(function(){
			var contentTypeId=$(this).val();
			location.href="searchDetail.wherego?keyword=${keyword}&contentTypeId="+contentTypeId;
		});
	})
	</script>
</body>
</html>