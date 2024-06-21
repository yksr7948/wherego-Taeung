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

.main-title {
	font-size: 40px;
    font-weight: 900;
    text-align: center;
}
.data-info{
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 0;
}

#count{
    display: flex;
    align-items: center;
}


.image-info {
    text-align: center;
    margin-bottom: 20px;
}
.image-info img{
	width: 1000px;
	height: auto;
}

.description {
	margin-top: 70px;
    font-size: 16px;
    color: #333;
    line-height: 1.5;
}

.details-info {
    background-color: #fff;
    padding: 20px;
}
.details-info tr{
	height: 70px;
}
.details-info th{
	font-size: 20px;
	width: 200px;
}
</style>
</head>
<body>
<%@include file="/WEB-INF/views/common/header.jsp" %>
<main>

    <h1 class="main-title">${t.title}</h1>
    
    <br> <br>
    
    <div class="data-info">
    	<span id="date">제작일 : ${t.createdTime }<br>수정일 : ${t.modifiedTime} </span>
    	<span id="count">
    		<img alt="" src="resources/img/trip-board/eye-icon.png">&nbsp;${t.count } 
    		&nbsp; &nbsp;
    		<img alt="" src="resources/img/trip-board/heart-icon.png">&nbsp;${t.likeCount }
    	</span> 
    </div>
    
    <hr> 
    
    <br> <br> <br>

    <div class="image-info">
        <img src="${t.firstImage1 }" alt="화계사">
    </div>

    <div class="description">
       	${t.overView }
    </div>
    
	<br> <br> <hr> <br> <br> <br>
	

    <div class="details-info">
	    <h1 class="main-title">상세정보</h1>
    	<br> <br>
	    <table>
	    	<tbody>
				<c:if test="${t.homepage != ''}">
			    	<tr>
			    		<th>홈페이지</th>
			    		<td>${t.homepage }</td>
			    	</tr>
				</c:if>
		    	<tr>
		    		<th>주소</th>
		    		<td>${t.addr1 } ${t.addr2 } ${t.zipCode }</td>
		    	</tr>
	    	</tbody>
	    </table>
    </div>
    
    <script>
    	$(function(){
    		detailInfo();
    	});
    	function detailInfo(){
    		
    		$.ajax({
    			url : "detailInfo.tl",
    			data : {
    				contentId : ${t.contentId},
    				contentTypeId : ${t.contentTypeId}
    			},
    			success : function(data){
    				var item = data.response.body.items.item;
    				
    				var str = "";
    				
    				if (item[0].infocenter) {
    			        str += "<tr>"
    			            + "<th>문의 및 안내</th>"
    			            + "<td>" + item[0].infocenter + "</td>"
    			            + "</tr>";
    			    }
    				if (item[0].accomcount) {
    			        str += "<tr>"
    			            + "<th>수용 인원</th>"
    			            + "<td>" + item[0].accomcount + "</td>"
    			            + "</tr>";
    			    }else{
    			    	str += "<tr>"
    			    		+ "<th>수용 인원</th>"
    			    		+ "<td>∞</td>"
    			    		+ "</tr>"
    			    }
    			    if (item[0].usetime) {
    			        str += "<tr>"
    			            + "<th>이용시간</th>"
    			            + "<td>" + item[0].usetime + "</td>"
    			            + "</tr>";
    			    }else{
    			    	str += "<tr>"
    			    		+ "<th>이용 시간</th>"
    			    		+ "<td>∞</td>"
    			    		+ "</tr>"
    			    }
    			    if (item[0].expguide) {
    			        str += "<tr>"
    			            + "<th>체험 안내</th>"
    			            + "<td>" + item[0].expguide + "</td>"
    			            + "</tr>";
    			    }else{
    			    	str += "<tr>"
    			    		+ "<th>체험 안내</th>"
    			    		+ "<td>없음</td>"
    			    		+ "</tr>"
    			    }
    			    if (item[0].restdate) {
    			        str += "<tr>"
    			            + "<th>휴일</th>"
    			            + "<td>" + item[0].restdate + "</td>"
    			            + "</tr>";
    			    }else{
    			    	str += "<tr>"
    			    		+ "<th>휴일</th>"
    			    		+ "<td>없음</td>"
    			    		+ "</tr>"
    			    }
    			    if (item[0].parking) {
    			        str += "<tr>"
    			            + "<th>주차 시설</th>"
    			            + "<td>" + item[0].parking + "</td>"
    			            + "</tr>";
    			    }else{
    			    	str += "<tr>"
    			    		+ "<th>주차 시설</th>"
    			    		+ "<td>없음</td>"
    			    		+ "</tr>"
    			    }
        				
        			$(".details-info tbody").append(str);
    			},
    			error : function(){
    				console.log("통신 오류");
    			}
    		})
    	}
    </script>
</main>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>