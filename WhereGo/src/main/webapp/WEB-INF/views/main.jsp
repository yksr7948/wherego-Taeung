<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
/* 슬라이드 영역 */
.slide-container {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100%;
}
.slideshow-container {
	position: relative;
	width: 100%;
	overflow: hidden;
	border: 20px solid white;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	background-color: #fff;
	border-radius: 15px;
}
.slide {
	display: none;
	width: 100%;
	position: absolute;
	transition: transform 1s ease;
}
.active-slide {
	display: block;
	position: relative;
}
.slide img {
	width: 100%;
	height: auto;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}
.text-overlay {
	position: absolute;
	bottom: 1px;
	left: 30px;
	color: white;
	font-size: 36px;
	font-weight: 900;
	background-color: rgba(0, 0, 0, 0.1);
	padding: 10px;
	border-radius: 10px;
}
.dots-container {
	text-align: center;
	padding: 20px;
}
.dot {
	cursor: pointer;
	height: 15px;
	width: 15px;
	margin: 0 2px;
	background-color: #bbb;
	border-radius: 50%;
	display: inline-block;
	transition: background-color 0.6s ease;
}
.active, .dot:hover {
	background-color: #717171;
}

/* 메인 영역 */
.trip-container {
	padding: 20px;
	width: 80%;
	margin: auto;
	margin-top: 3%;
	text-align: center;
}
.trip-title {
	font-size: 40px;
	font-weight: 900;
	text-align: center;
	margin-bottom: 100px;
}

/* 슬라이드 쇼 영역 */
.trip-slideshow-container {
	position: relative;
	width: 100%;
	margin: auto;
	overflow: hidden;
	display: flex;
	align-items: center;
	border: 1px solid white;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	background-color: #fff;
	border-radius: 15px;
}
.trip-slides {
	display: flex;
	transition: transform 0.5s ease-out;
}
.trip-slide {
	min-width: 100%;
	box-sizing: border-box;
	display: flex;
	align-items: center;
}
.trip-description {
	width: 40%;
	padding: 20px;
	text-align: left;
	margin-left: 50px;
}
.rank{
	font-size: 50px;
	font-weight: 900;
	margin-left: 35%;
	background-color: gold;
	border: 1px solid glod;
	border-radius: 20%; 
}
.trip-description h2 {
	font-size: 24px;
	margin: 0 0 10px;
}
.trip-description p {
	font-size: 14px;
	margin: 5px 0 20px;
}
.trip-description button {
	margin-top: 10%;
	margin-left: 30%;
}
.trip-image {
	width: 60%;
	border: 20px solid lightgray;
	border-radius: 20px;
}
.trip-image img {
	width: 100%;
	height: 600px; /* 이미지 높이를 늘림 */
	object-fit: cover;
}
button.trip-prev, button.trip-next {
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
	background-color: #f4f4f9;
	color: black;
	border: none;
	padding: 10px;
	cursor: pointer;
	z-index: 1;
}
button.trip-prev {
	left: 10px;
}
button.trip-next {
	right: 10px;
}
</style>
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
			setTimeout(showSlides, 10000);
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
				<div class="trip-slide">
					<div class="trip-description">
						<span class="rank">1등</span>
						<br> <br> <br>
						<h1>가락몰 빵축제 전국빵지자랑</h1>
						<img alt="" src="resources/img/trip-board/eye-icon.png"> <span>0</span>
						&nbsp; &nbsp; 
						<img src="resources/img/trip-board/heart-icon.png"> <span>0</span>
						<br>
						<button class="login-button">자세히 보기</button>
					</div>
					<div class="trip-image">
						<img src="http://tong.visitkorea.or.kr/cms/resource/84/2791384_image2_1.jpg" alt="Trip 1">
					</div>
				</div>
				<button class="trip-next" onclick="changeTripSlide(1)">&#10095;</button>
			</div>
		</div>
	</div>

	<!-- 여행지 TOP 5 슬라이드 기능 -->
	<script>
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