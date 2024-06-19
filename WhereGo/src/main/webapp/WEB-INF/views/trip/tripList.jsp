<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>

/* 콘텐츠 영역 스타일링 */
main {
    padding: 20px;
    width: 80%;
    margin: auto;
    margin-top: 5%;
}
.img-container img{
	width: 100%;
	height: auto;
}

.area-container {
    text-align: left;
    margin-bottom: 40px;
    margin-left: 30px;
}

.area-container a {
	border: 2px solid black;
	background-color: white;
    color: black;
    padding: 10px 20px;
    border-radius: 5px;
    font-size: 16px;
    font-weight: 900;
    transition: background-color 0.3s, color 0.3s;
    margin-right: 30px;
}

.area-container a:hover {  
	background-color: black;
    color: white;
    cursor: pointer;
}

.card-container {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    justify-content: space-around;
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
}

.card:hover {
    transform: scale(1.05);
}

.card img {
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
}

.pagination {
    display: flex;
    justify-content: center;
    padding: 20px 0;
}

.pagination button {
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 4px;
    margin: 0 5px;
    padding: 10px 15px;
    cursor: pointer;
    transition: background-color 0.2s;
}

.pagination button:hover {
    background-color: #f0f0f0;
}

.card-container {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    justify-content: center;
}

.card {
    flex: 0 0 calc(25% - 20px);
    box-sizing: border-box;
}

</style>
</head>
<body>

<%@include file="/WEB-INF/views/common/header.jsp" %>

	
	<main>
		<h1># 여행지 > 전체</h1>
		
		<br> <br> <hr> <br> <br> <br>
		
		<div class="area-container">
			<a>서울</a>
			<a>인천</a>
			<a>대전</a>
			<a>대구</a>
			<a>광주</a>
			<a>부산</a>
			<a>울산</a>
			<a>경기</a>
			<a>강원</a>
			<a>제주</a>
		</div>
		<div class="card-container">
			<div class="card">
				<img src="http://tong.visitkorea.or.kr/cms/resource/88/2550988_image2_1.bmp" alt="">
				<div class="card-content">
					<h2>봉이밥 인사동점</h2>
					<p>한식과 전통적인 내부 인테리어를 함께 즐길 수 있는 곳</p>
				</div>
			</div>
			<div class="card">
				<img src="" alt="">
				<div class="card-content">
					<h2>봉이밥 인사동점</h2>
					<p>한식과 전통적인 내부 인테리어를 함께 즐길 수 있는 곳</p>
				</div>
			</div>
			<div class="card">
				<img src="" alt="">
				<div class="card-content">
					<h2>봉이밥 인사동점</h2>
					<p>한식과 전통적인 내부 인테리어를 함께 즐길 수 있는 곳</p>
				</div>
			</div>
			<div class="card">
				<img src="" alt="">
				<div class="card-content">
					<h2>봉이밥 인사동점</h2>
					<p>한식과 전통적인 내부 인테리어를 함께 즐길 수 있는 곳</p>
				</div>
			</div>
			<div class="card">
				<img src="" alt="">
				<div class="card-content">
					<h2>봉이밥 인사동점</h2>
					<p>한식과 전통적인 내부 인테리어를 함께 즐길 수 있는 곳</p>
				</div>
			</div>
			<div class="card">
				<img src="" alt="">
				<div class="card-content">
					<h2>봉이밥 인사동점</h2>
					<p>한식과 전통적인 내부 인테리어를 함께 즐길 수 있는 곳</p>
				</div>
			</div>
			<div class="card">
				<img src="" alt="">
				<div class="card-content">
					<h2>봉이밥 인사동점</h2>
					<p>한식과 전통적인 내부 인테리어를 함께 즐길 수 있는 곳</p>
				</div>
			</div>
			<div class="card">
				<img src="" alt="">
				<div class="card-content">
					<h2>봉이밥 인사동점</h2>
					<p>한식과 전통적인 내부 인테리어를 함께 즐길 수 있는 곳</p>
				</div>
			</div>
			<div class="card">
				<img src="" alt="">
				<div class="card-content">
					<h2>봉이밥 인사동점</h2>
					<p>한식과 전통적인 내부 인테리어를 함께 즐길 수 있는 곳</p>
				</div>
			</div>
			<div class="card">
				<img src="" alt="">
				<div class="card-content">
					<h2>봉이밥 인사동점</h2>
					<p>한식과 전통적인 내부 인테리어를 함께 즐길 수 있는 곳</p>
				</div>
			</div>
			<div class="card">
				<img src="" alt="">
				<div class="card-content">
					<h2>봉이밥 인사동점</h2>
					<p>한식과 전통적인 내부 인테리어를 함께 즐길 수 있는 곳</p>
				</div>
			</div>
			<div class="card">
				<img src="" alt="">
				<div class="card-content">
					<h2>봉이밥 인사동점</h2>
					<p>한식과 전통적인 내부 인테리어를 함께 즐길 수 있는 곳</p>
				</div>
			</div>
		</div>
		<div class="pagination">
			<button>&laquo;</button>
			<button>1</button>
			<button>2</button>
			<button>3</button>
			<button>4</button>
			<button>5</button>
			<button>&raquo;</button>
		</div>
	</main>

<%@include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>