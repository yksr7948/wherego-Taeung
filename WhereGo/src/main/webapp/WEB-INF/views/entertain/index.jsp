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
	display: flex;
	flex-direction: column;
	gap: 10px;
	max-width: 300px;
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

#buttons {
	display: none;
	margin-top: 20px;
}

button {
	margin: 5px;
	padding: 10px 20px;
	font-size: 16px;
}
</style>
</head>
<body>

	<h1>이상형 월드컵</h1>
	<h1 id="round"></h1>
	<p id="cal"></p>
	<div class="option-selector">
		<label> <input type="radio" name="option" value="16" checked onchange="handleRoundChange(this)"> 16강 </label>
		<label> <input type="radio" name="option" value="32" onchange="handleRoundChange(this)"> 32강 </label>
		<label> <input type="radio" name="option" value="64" onchange="handleRoundChange(this)"> 64강 </label>
		<button id="start-worldcup" onclick="initializeIdealTypeWorldCup()">시작</button>
	</div>
	<div id="buttons">
		<button id="confirmButton">확인</button>
		<button onclick="restartWorldCup()">다시하기</button>
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
    let round = 16;

    function shuffleImages() {
        images.sort(() => 0.5 - Math.random());
    }

    function displayCurrentImagePair() {
        if (currentPairIndex < images.length - 1) {
            document.getElementById('image').src = images[currentPairIndex].firstImage2;
            document.getElementById('images').src = images[currentPairIndex + 1].firstImage2;
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
            document.getElementById('image').src = selectedImages[0].firstImage2;
            document.getElementById('images').style.display = "none";
            document.getElementById('round').innerText = "우승!";
            document.getElementById('imageText').innerText = "";
            document.getElementById('imagesText').innerText = "";
            ///document.getElementById('image').onclick = null;
            //document.getElementById('buttons').style.display = 'block';
            
            //alert("우승자는: " + winnerImageName+"!");

            // Show buttons and bind click event to confirm button
            /* var confirmButton = document.getElementById('confirmButton');
            confirmButton.onclick = function() {
                $.ajax({
                    url: "worldcupresult.en",
                    type: "post",
                    data: {
                        winner: winnerImageName
                    },
                    success: function() {
                        alert("우승자가 확인되었습니다!");
                        // Additional actions on success if needed
                    },
                    error: function() {
                        console.log("통신오류");
                    }
                });
            }; */
        }
    }

    function initializeIdealTypeWorldCup() {
        round = parseInt(document.querySelector('input[name="option"]:checked').value); // 선택된 라디오 버튼 값 가져오기
        document.getElementById('round').innerText = round + "강 대전";
        shuffleImages();
        images = images.slice(0, round);
        currentPairIndex = 0;
        selectedImages = [];
        /* document.getElementById('buttons').style.display = 'none'; // Hide buttons initially
        document.getElementById('image').onclick = function() {
            handleImageSelection(0);
        }; // Enable image click event
        document.getElementById('images').onclick = function() {
            handleImageSelection(1);
        }; // Enable images click event */
        displayCurrentImagePair();
    }

    function handleRoundChange(radioButton) {
        round = parseInt(radioButton.value);
        initializeIdealTypeWorldCup();
    }

    function restartWorldCup() {
        initializeIdealTypeWorldCup();
    }

    initializeIdealTypeWorldCup();
	</script>

</body>
</html>
