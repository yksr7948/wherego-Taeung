<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이상형 월드컵</title>
<style>
body {
	font-family: Arial, sans-serif;
	padding: 20px;
}

.option-selector {
	display: inline-block;
	text-align: left;
	margin-bottom: 20px;
}

img {
	width: 500px;
	height: 500px;
	margin: 10px;
}

#imageContainer {
	display: flex;
	justify-content: center;
	align-items: center;
}

#modal-backdrop {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	z-index: 1000;
	display: none;
	pointer-events: none;
	transition: backdrop-filter 0.3s ease-out;
}

.wcForm {
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	z-index: 1001;
	display: none;
}


#start-worldcup {
	font-size: 18px;
	padding: 12px 24px;
}

.container {
	display: flex;
	justify-content: center;
	align-items: center;
}

.cal-container {
	text-align: center;
	margin-bottom: 20px;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="container">
		<div>
			<h1>이상형 월드컵</h1>
			<h1 id="round"></h1>
			<p id="cal"></p>

			<div class="option-selector">
				<label><input type="radio" name="option" value="16" checked
					onchange="handleRoundChange(this)"> 16강</label> <label><input
					type="radio" name="option" value="32"
					onchange="handleRoundChange(this)"> 32강</label> <label><input
					type="radio" name="option" value="64"
					onchange="handleRoundChange(this)"> 64강</label>
				<button id="start-worldcup" onclick="initializeIdealTypeWorldCup()">시작</button>
			</div>
		</div>
	</div>

	<div id="modal-backdrop"></div>
	<div class="modal" id="wcForm">
		<div class="modal-content">
			<div class="modal-body" align="center">
				<form id="resultForm" action="wcResult.en" method="post">
					<input type="hidden" name="userId" value="${loginUser.userId}">
					<input type="hidden" name="winnerName" id="winner" value="">
					<input type="hidden" name="check" id="checkInput" value="">
					<table>
						<tr>
							<td>우승 : <span id="winnerName"></span></td>
						</tr>
					</table>
					<br>
					<button type="submit" class="btn btn-danger"
						onclick="setCheckValue(0);">다시하기</button>
					<button type="submit" class="btn btn-danger"
						onclick="setCheckValue(1);">랭킹보기</button>
				</form>
			</div>
		</div>
	</div>

	<div id="imageContainer">
		<div>
			<img id="image" onclick="handleImageSelection(0)">
			<p id="imageText"></p>
		</div>
		<div>
			<img id="images" onclick="handleImageSelection(1)">
			<p id="imagesText"></p>
		</div>
	</div>

	
	<script>
	var jsonData = '${list}';
	var images = JSON.parse(jsonData);
	let selectedImages = [];
	let currentPairIndex = 0;
	let round = parseInt(document.querySelector('input[name="option"]:checked').value);
	let winner = "";

	function shuffleImages() {
		images.sort(() => 0.5 - Math.random());
	}

	function displayCurrentImagePair() {
		if (currentPairIndex < images.length - 1) {
			document.getElementById('image').src = images[currentPairIndex].firstImage1;
			document.getElementById('images').src = images[currentPairIndex + 1].firstImage1;
			document.getElementById('imageText').innerText = images[currentPairIndex].title;
			document.getElementById('imagesText').innerText = images[currentPairIndex + 1].title;
		}
	}

	function handleImageSelection(selectedImageIndex) {
		selectedImages.push(images[currentPairIndex + selectedImageIndex]);
		currentPairIndex += 2;

		if (currentPairIndex < images.length - 1) {
			displayCurrentImagePair();
		} else if (selectedImages.length > 1) {
			images = selectedImages;
			shuffleImages();
			selectedImages = [];
			currentPairIndex = 0;
			round = round / 2;
			if (round == 2) {
				document.getElementById('round').innerText = "결승전";
				displayCurrentImagePair();
			} else {
				document.getElementById('round').innerText = round + "강 대전";
				displayCurrentImagePair();
			}
		} else {
			const winnerImageName = selectedImages[0].title;
			document.getElementById('image').src = selectedImages[0].firstImage1;
			document.getElementById('images').style.display = "none";
			document.getElementById('round').innerText = winnerImageName + " 우승!";
			document.getElementById('winnerName').innerText = winnerImageName;
			document.getElementById('winner').value = winnerImageName;
			document.getElementById('imageText').innerText = "";
			document.getElementById('imagesText').innerText = "";
			document.getElementById('image').onclick = null;
			showWinnerModal();
		}
	}
	
	function showWinnerModal() {
		document.getElementById('modal-backdrop').style.display = 'block';
		document.getElementById('modal-backdrop').style.pointerEvents = 'auto';
		document.getElementById('wcForm').style.display = 'block';
	}
	

	function initializeIdealTypeWorldCup() {
		round = parseInt(document.querySelector('input[name="option"]:checked').value); 
		document.getElementById('round').innerText = round + "강 대전";
		shuffleImages();
		images = images.slice(0, round);
		currentPairIndex = 0;
		selectedImages = [];
		displayCurrentImagePair();
	}

	function handleRoundChange(radioButton) {
		round = parseInt(radioButton.value);
		initializeIdealTypeWorldCup();
	}

	function setCheckValue(value) {
		document.getElementById('checkInput').value = value;
	}

</script>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>
