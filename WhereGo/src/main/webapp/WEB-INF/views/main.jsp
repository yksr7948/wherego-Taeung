<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main-style.css">
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	
	<!-- 메인 슬라이드 영역 -->
	<div class="slide-container">
		<div class="slideshow-container">
			<div class="slide active-slide">
				<img src="resources/img/main/1.png" alt="">
				<div class="text-overlay">일상의 피로를 씻어줄 힐링 여행,<br> 떠날 준비 되셨나요?</div>
			</div>
		    <div class="slide">
		    	<img src="resources/img/main/2.png" alt="">
		    	<div class="text-overlay">숨 막히는 도시를 벗어나 자연 속으로,<br> 마음의 평화를 찾아 떠나요.</div>
		    </div>
		    <div class="slide">
		    	<img src="resources/img/main/3.png" alt="">
		    	<div class="text-overlay">여행은 최고의 스승입니다.<br> 새로운 경험과 추억을 쌓아보세요.</div>
		    </div>
		   	<div class="slide">
		    	<img src="resources/img/main/4.png" alt="">
		    	<div class="text-overlay">떠나보지 않으면 알 수 없는 곳,<br> 지금 바로 떠나세요.</div>
		    </div>
		    <div class="slide">
			    <img src="resources/img/main/5.png" alt="">
			    <div class="text-overlay">아름다운 풍경과 함께하는 행복한 시간,<br> 지금 떠나요.</div>
		    </div>
		</div>
	</div>
	
	<!-- 슬라이드 닷 영역 -->
	<div class="dots-container">
		<span class="dot" onclick="currentSlide(1)"></span>
		<span class="dot" onclick="currentSlide(2)"></span>
		<span class="dot" onclick="currentSlide(3)"></span>
		<span class="dot" onclick="currentSlide(4)"></span>
		<span class="dot" onclick="currentSlide(5)"></span>
	</div>
	
	<!--슬라이드 기능 -->
	<script>
		let slideIndex = 0;
		let slides = document.getElementsByClassName("slide");
		let dots = document.getElementsByClassName("dot");

		function showSlides() {
			for (let i = 0; i < slides.length; i++) {
				slides[i].classList.remove("active-slide");
			}
			slideIndex++;
			if (slideIndex > slides.length) {
				slideIndex = 1
			}
			slides[slideIndex - 1].classList.add("active-slide");
			updateDots();
			setTimeout(showSlides, 7000);
		}

		function currentSlide(n) {
			slideIndex = n;
			for (let i = 0; i < slides.length; i++) {
				slides[i].classList.remove("active-slide");
			}
			slides[slideIndex - 1].classList.add("active-slide");
			updateDots();
		}

		function updateDots() {
			for (let i = 0; i < dots.length; i++) {
				dots[i].classList.remove("active");
			}
			dots[slideIndex - 1].classList.add("active");
		}

		showSlides();
	</script>
	
	<!-- 여행지 TOP 5 슬라이드 영역 -->
	<div class="trip-container">
		<h1 class="trip-title">여행지 TOP 5</h1>
		<div class="trip-slideshow-container">
			<button class="trip-prev" onclick="changeTripSlide(-1)">&#10094;</button>
			<div class="trip-slides" id="trip-slides">
				<c:forEach items="${tripTopList }" var="topList" varStatus="loop">
					<div class="trip-slide">
						<div class="trip-description">
							<span class="rank">${loop.index + 1}등</span>
							<br> <br> <br>
							<input type="hidden" value=${topList.contentId }>
							<h1>${topList.title }</h1>
							<img alt="" src="resources/img/trip-board/eye-icon.png"> <span>${topList.count }</span>
							&nbsp; &nbsp; 
							<img src="resources/img/trip-board/heart-icon.png"> <span>${topList.likeCount }</span>
							<br>
							<button class="login-button" onclick="detailBtn(${topList.contentId});">자세히 보기</button>
						</div>
						<div class="trip-image">
							<img src=${topList.firstImage1 }>
						</div>
					</div>
				</c:forEach>
			</div>
			<button class="trip-next" onclick="changeTripSlide(1)">&#10095;</button>
			
		</div>
	</div>

	<!-- 여행지 TOP 5 슬라이드 기능 -->
	<script>
		
	 	<!-- 상세보기 페이지로 이동 -->
		function detailBtn(contentId){
			
			location.href="tripDetail.tl?contentId="+contentId;			
		}
	
		<!-- 슬라이드 기능 -->
		let tripSlideIndex = 0;
		const tripSlides = document.getElementById('trip-slides');

		function changeTripSlide(n) {
			tripSlideIndex += n;
			if (tripSlideIndex >= tripSlides.children.length) {
				tripSlideIndex = 0;
			} else if (tripSlideIndex < 0) {
				tripSlideIndex = tripSlides.children.length - 1;
			}
			updateTripSlidePosition();
		}

		function currentTripSlide(n) {
			tripSlideIndex = n;
			updateTripSlidePosition();
		}

		function updateTripSlidePosition() {
			tripSlides.style.transform = 'translateX('
					+ (-tripSlideIndex * 100) + '%)';
		}

		window.onload = updateTripSlidePosition;
	</script>       
    
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	
</body>
</html>