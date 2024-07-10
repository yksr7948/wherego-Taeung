<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=r0j6vqaf5j"></script>
<style>
main {
    padding: 20px;
    width: 60%;
    margin: auto;
    margin-top: 5%;
}
font{
	cursor: auto;
}

/* 헤더부분 */
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
#title-heart{
	color: #ff6b81;
}

/* 이미지부분 */
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

/* 상세보기 */
.details-info {
    padding: 20px;
}
.details-info tr{
	height: 70px;
}
.details-info th{
	font-size: 20px;
	width: 200px;
}

/* 지도 */
#map-container{
	display: flex;
	justify-content: center;
}
#map{
	width: 80%;
	height: 400px;
}

/* 좋아요 */
#like-container{
	display: flex;
	justify-content: center;
}
.like-btn{ /* 버튼 클릭 안되었을때 */
    background-color: white;
    border: 2px solid #ff6b81;
    border-radius: 25px;
    padding: 10px 20px;
    color: #ff6b81;
    font-size: 18px;
    font-weight: 900;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    gap: 10px;
}

.like-btn:hover {
    transform: scale(1.1);
}

/* 댓글 영역 */
#reply-container {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
	border-radius: 4px;
}
#reply-container thead{
	border: 1px solid #ddd;
	border-radius: 4px;
}
#content {
	width: 100%;
	height: 100px;
	padding: 10px;
	box-sizing: border-box;
	border: 1px solid #ddd;
	border-radius: 4px;
	resize: none;
}
.login-button {
	float: right;
	margin-top: 10px;
	padding: 10px 20px;
}
#reply-container tbody tr{
	border-bottom: 1px solid #ddd;
	height: 100px;
}
#reply-container th {
	text-align: left;
	padding: 8px;
	width: 50px;
}
#reply-container td {
	vertical-align: top;
	padding: 8px 16px;
}
#reply-container td div {
	padding: 8px 0px;
}
#reply-container img{
	width: 48px;
	height: auto;
}
.update{
	float: right;
	cursor: pointer;
	color: #888;
}

</style>
</head>
<body>
<%@include file="/WEB-INF/views/common/header.jsp" %>
<main>

    <h1 class="main-title">${t.title}</h1>
    
    <br> <br>
    
    <div class="data-info">
    	<span id="date">
    		제작일 : ${t.createdTime }
    		<br>
    		수정일 : ${t.modifiedTime} </span>
    	<span id="count">
    		<b id="title-heart" class="far fa-heart"></b>&nbsp;<span id="likeCount">${t.likeCount }</span>
    		<br>
    		<img alt="" src="resources/img/trip-board/eye-icon.png">&nbsp;${t.count } 
    	</span> 
    </div>
	
	<hr> <br> <br> <br> <br>

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
    
    <!-- 상세정보 가져오기 -->
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
    
    <br> <br> <hr> <br> <br> <br>
    
    <!-- 지도 API -->  
    <h1 class="main-title">상세위치</h1>
    <br> <br>
    <div id="map-container">
	    <div id="map"></div>
    </div>  
    
    <!-- 지도 API -->
    <script>
    	var map = new naver.maps.Map('map', {
		    center: new naver.maps.LatLng(${t.mapy}, ${t.mapx}),
		    zoom: 15
		});
    	
    	var marker = new naver.maps.Marker({
    	    position: new naver.maps.LatLng(${t.mapy}, ${t.mapx}),
    	    map: map
    	});

    </script>
    
    <br> <br> <hr> <br> <br> <br>
    
    <!-- 좋아요 기능 -->
	<div id="like-container">
		<button class="like-btn" onclick="like();"><b id="heartIcon" class="far fa-heart"></b> 좋아요</button>
	</div>
	
	<script>
			
	    // 유저 좋아요 여부
	    var likeYN = false;
	    var userId = "${loginUser.userId}";
		var contentId = ${t.contentId};
		var heart = document.getElementById("title-heart");
		
			
		if(userId != ""){
			$.ajax({
				url : "likeYN.tl",
				data : {
					userId,
					contentId
				},
				success : function(result){
					
					likeYN = result;
					
			    	if (likeYN) {
				        $(".like-btn").css({"background-color":"#ff6b81","color":"white"});
				        heart.classList.remove("far");
	    	            heart.classList.add("fas");
					} else {
				        $(".like-btn").css({"background-color":"white","color":"#ff6b81"});
				        heart.classList.remove("fas");
	    	            heart.classList.add("far");
				    }
					
				},
				error : function(){
					console.log("통신 오류");
				}
			});
		}
    	
	    function like() {
	        
	    	if(userId == ""){
	    		alertify.alert('<img src="resources/img/removebg-preview.png" style="width: 30px;" alt="이미지 설명">' ,"로그인 후 사용 가능합니다.");
	    	}else if (likeYN) {
	        	
	    		$.ajax({
	    			url : "deleteLike.tl",
	    			data : {
	    				userId,
	    				contentId
	    			},
	    			success : function(result){
	    				
	    				if(result >= 0){
	    				$(".like-btn").css({"background-color":"white","color":"#ff6b81"});
	    				heart.classList.remove("fas");
		    	        heart.classList.add("far");
	        	        likeYN = false;
	        	        alertify.alert('<img src="resources/img/removebg-preview.png" style="width: 30px;" alt="이미지 설명">', "좋아요를 취소하였습니다.");
	        	        $("#likeCount").text(result);
	    				}
	    			},
	    			error : function(){
	    				console.log("통신 오류");
	    			}
	    			
	    		});
	        } else {
	        	
	        	$.ajax({
	        		url : "insertLike.tl",
	        		data : {
	        			userId,
	        			contentId
	        		},
	        		success : function(result){
						if(result >= 0){
		        	        $(".like-btn").css({"background-color":"#ff6b81","color":"white"});
		        	        heart.classList.remove("far");
		        	        heart.classList.add("fas"); // 채워진 하트로 변경
		        	        likeYN = true;
		        	        alertify.alert('<img src="resources/img/removebg-preview.png" style="width: 30px;" alt="이미지 설명">' ,"좋아요!!");
		        	        $("#likeCount").text(result);
						}
	        		},
	        		error : function(){
	        			console.log("통신 오류");
	        		}
	        	});
	        	


	        }
    }

	</script>
    
    <br> <br> <br> <br> <br> <br>
    
	<!-- 댓글 작성 -->
	<h3 style="font-weight: 900;">댓글(<span id="rcount"></span>)</h3>
    <table id="reply-container">
        <thead>
            <tr>
                <th colspan="2">
                    <c:choose>
                        <c:when test="${empty loginUser}">
                            <textarea class="form-control" id="content" cols="55" rows="2" readonly>로그인 후 이용해주세요</textarea>
                        </c:when>
                    	<c:otherwise>
                                <textarea class="form-control" id="content" cols="55" rows="2" required></textarea>
                                <button class="login-button" onclick="insertReply();">등록하기</button>
                        </c:otherwise>
                    </c:choose>
                </th>
            </tr>
        </thead>
        <tbody>

        </tbody>
    </table>
    
    <script>
    
     	//댓글 리스트 불러오기
    	$(function(){
    		replyList();
    	});
    	
    	function replyList(){
    		
    		var loginUser = "${loginUser.userId}";
    		
     		$.ajax({
    			url : "replyList.tl",
     			data: {
     				contentId : ${t.contentId}
     			},
     			success : function(data){
    				
    				var str = ""
    				
    				for(var i in data){
    					var date=new Date(data[i].createDate);
    					var dFormat=date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate()+" "+date.getHours()+":"+date.getMinutes();
     					str += "<tr>";
    					str += "<th><img src='resources/img/trip-board/user_profile.png'></th>";
    					str += "<td>";
   						str += "<span style='font-weight: bold; margin-right: 10px;'>"+data[i].userId+"</span>";
   						
     					str += "<span style='color:#888'>"+dFormat+"</span>";
   					if(loginUser === data[i].userId){
 	    					str += "<span class='update'><a onclick='deleteReply("+data[i].replyNo+")'>삭제하기</a></span>";
 	    					str += "<span class='update'><font> &nbsp; / &nbsp;</font></span>";
 	    					str += "<span class='update'><a onclick='updateBtn("+data[i].replyNo+");'>수정하기</a></span>"; 
     					}
   				 			str += "<div id='replyContent" + data[i].replyNo + "'>" + data[i].replyContent + "</div>";
   				 			str += "<div id='editContent" + data[i].replyNo + "'style='display:none;'>";
   				 			str += "<textarea class='form-control' id='update-content" + data[i].replyNo + "' cols='55' rows='2' style='resize: none' required>"+data[i].replyContent+"</textarea>";
   				 			str += "<button class='login-button' onclick='cancleBtn(" + data[i].replyNo + ");'>취소</button>"
   				 			str += "<button class='login-button' onclick='saveReply(" + data[i].replyNo + ");'>저장하기</button></div>"
			   		        str += "</td>";
			   		        str += "</tr>";
     				}
    				
     				$("#reply-container tbody").html(str);
     				$("#rcount").text(data.length);
     			},
     			error: function(){
     				console.log("통신오류");
     			}
     		});
    	}

     	//댓글 작성
    	function insertReply(){
    			
	    	var contentId = ${t.contentId};
	    	var userId = "${loginUser.userId}";
	    	var replyContent = $("#content").val();
    			
    		$.ajax({
    			url : "insertReply.tl",
    			data : {
    				contentId,
    				userId,
    				replyContent
    			},
    			success : function(result){
    				if(result > 0){
    					alertify.alert('<img src="resources/img/removebg-preview.png" style="width: 30px;" alt="이미지 설명">' ,"댓글 작성 성공!");
						$("#content").val("");
						replyList();
    				}else{
    					alertify.alert('<img src="resources/img/removebg-preview.png" style="width: 30px;" alt="이미지 설명">' ,"댓글 작성 실패 ㅠㅠ");
    				}
    			},
    			error : function(){
    				console.log("통신 실패");
    			}
    		});
    	}
  	
     	//수정 버튼 클릭시
     	function updateBtn(replyNo) {
     		$("#replyContent"+replyNo).css({"display":"none"});
     		$("#editContent"+replyNo).css({"display":"block"});
		}
		
     	//취소 버튼 클릭시
     	function cancleBtn(replyNo) {
     		$("#replyContent"+replyNo).css({"display":"block"});
     		$("#editContent"+replyNo).css({"display":"none"});
		}
     	
     	//저장 버튼 클릭시
     	function saveReply(replyNo){
     		
     		var updateContent = $("#update-content"+replyNo).val();
     		
     		$.ajax({
     			url : "updateReply.tl",
     			data : {
     				updateContent,
     				replyNo
     			},
     			success : function(result){
     				
     				alertify.alert('<img src="resources/img/removebg-preview.png" style="width: 30px;" alt="이미지 설명">' ,"댓글 수정 성공!!");
     	     		$("#replyContent"+replyNo).css({"display":"block"});
     	     		$("#editContent"+replyNo).css({"display":"none"});
     	     		replyList();
     			},
     			error : function(){
     				console.log("통신오류");
     			}
     		});
     	}
     	
     	//댓글 삭제
     	function deleteReply(replyNo){
     		
     		var result = confirm("댓글을 삭제하시면 다시 되돌릴 수 없습니다. 정말 삭제하시겠습니까?");
     		
     		if(result){
     			$.ajax({
     				url : "deleteReply.tl",
     				data : {
     					replyNo
     				},
     				success : function(data){
     					if(data > 0){
     						alertify.alert('<img src="resources/img/removebg-preview.png" style="width: 30px;" alt="이미지 설명">' ,"댓글 삭제 되었습니다.");
	     					replyList();
     					}else{
     						alertify.alert('<img src="resources/img/removebg-preview.png" style="width: 30px;" alt="이미지 설명">' ,"댓글 삭제 실패");
     					}
     				},
     				error : function(){
     					console.log("통신오류");
     				}
     			});
     			
     		}
     		
     	}
    </script>
    
</main>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>