<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>해시태그 선택</title>
    <style>
        body {
        font-family: Arial, sans-serif;
        padding: 20px;
		text-align: center; /* 전체 내용을 가운데 정렬 */
    }
    .hashtags {
        display: grid;
        grid-template-columns: repeat(4, 1fr); /* 4열로 설정 */
        gap: 10px; /* 간격 조절 */
        max-width: 600px; /* 최대 너비 설정 */
		margin: 0 auto; /* 중앙 정렬을 위한 마진 설정 */
    }
    .hashtag {
        padding: 10px 20px; /* 타원형을 위해 좌우 패딩을 더 크게 */
        background-color: #f0f0f0;
        border-radius: 25px; /* 타원형을 위해 크게 설정 */
        border: 2px solid #ccc; /* 테두리 선 추가 */
        cursor: pointer;
        box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3), inset 1px 1px 3px rgba(255, 255, 255, 0.3); /* 그림자 추가 */
        text-align: center; /* 텍스트 가운데 정렬 */
        transition: background 0.3s, box-shadow 0.3s; /* 전환 효과 */
    }
        .selected {
            background: linear-gradient(145deg, #6d6d6d, #595959); /* 그라데이션 추가 */
            color: white;
            border-color: #696969; /* 선택된 상태일 때 테두리 색상 변경 */
            box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3), inset 1px 1px 3px rgba(255, 255, 255, 0.3); /* 그림자 추가 */
        }
        .hashtag:hover {
            background: linear-gradient(145deg, #5a5a5a, #796e6e); /* 호버 시 그라데이션 변경 */
            box-shadow: 2px 2px 7px rgba(0, 0, 0, 0.5), inset 1px 1px 5px rgba(255, 255, 255, 0.5); /* 호버 시 그림자 변경 */
        }
	button {
    background-color: white;
    text-align: center;
    color: black;
    padding: 10px 20px;
    margin-left: 20px;
    border: 2px solid black;
    border-radius: 5px;
    font-size: 16px;
    font-weight: 900;
    cursor: pointer;
    transition: background-color 0.3s, color 0.3s;
}
button:hover {
    background-color: black;
    color: white;
}
    </style>
</head>
<body>
	<div class="title">
	<a href="index.jsp"><img src="resources/img/removebg-preview.png" alt="Logo"></a>
  </div>
    <h1>MBTI 선택</h1>
    <div class="hashtags hashtags-MBTI">
        <span class="hashtag">INFP</span>
        <span class="hashtag">INFJ</span>
        <span class="hashtag">INTP</span>
        <span class="hashtag">INTJ</span>
        <span class="hashtag">ISFP</span>
        <span class="hashtag">ISTP</span>
        <span class="hashtag">ISFJ</span>
        <span class="hashtag">ISTJ</span>
        <span class="hashtag">ENFP</span>
        <span class="hashtag">ENFJ</span>
        <span class="hashtag">ENTP</span>
        <span class="hashtag">ENTJ</span>
        <span class="hashtag">ESFP</span>
        <span class="hashtag">ESTP</span>
        <span class="hashtag">ESFJ</span>
        <span class="hashtag">ESTJ</span>
        
        <!-- 필요한 해시태그를 더 추가하세요 -->
    </div>

    <h1>관심있는 해시태그 선택</h1>
    <div class="hashtags hashtags-words">
        <span class="hashtag">혼자서</span>
        <span class="hashtag">남자끼리</span>
        <span class="hashtag">여자끼리</span>
        <span class="hashtag">커플</span>
        <span class="hashtag">액티비티</span>
        <span class="hashtag">힐링</span>
        <span class="hashtag">학생</span>
        <span class="hashtag">MT</span>
        <span class="hashtag">바다</span>
        <span class="hashtag">산</span>
        <span class="hashtag">계곡</span>
        <span class="hashtag">여름</span>
        <span class="hashtag">봄</span>
        <span class="hashtag">가을</span>
        <span class="hashtag">겨울</span>
        <span class="hashtag">맛집</span>
        <!-- 필요한 해시태그를 더 추가하세요 -->
         
    </div>
    <form id="hashtagForm" action="additional.me" method="POST" accept-charset="UTF-8">
    	<input type="hidden" id="userId" name="userId" value="${userId}">
    	<input type="hidden" id="selectedMBTI" name="selectedMBTI" value="">
    	<input type="hidden" id="selectedWords" name="selectedWords" value="">
		<br>
        <button type="submit" onclick="updateFormValues()">확인</button>
    </form>

    <div class="check"></div> <!-- 결과 출력을 위한 div -->

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const MBTIHashtags = document.querySelectorAll('.hashtags-MBTI .hashtag');
            const wordsHashtags = document.querySelectorAll('.hashtags-words .hashtag');
            const selectedMBTIInput = document.getElementById('selectedMBTI');
            const selectedWordsInput = document.getElementById('selectedWords');
            const checkDiv = document.querySelector('.check'); // check 클래스를 가진 div 요소 선택

            MBTIHashtags.forEach(hashtag => {
                hashtag.addEventListener('click', () => {
                    if (hashtag.classList.contains('selected')) {
                        hashtag.classList.remove('selected');
                    } else {
                        MBTIHashtags.forEach(tag => tag.classList.remove('selected'));
                        hashtag.classList.add('selected');
                    }
                    updateSelectedMBTI();
                });
            });

            wordsHashtags.forEach(hashtag => {
                hashtag.addEventListener('click', () => {
                    if (hashtag.classList.contains('selected')) {
                        hashtag.classList.remove('selected');
                    } else {
                        hashtag.classList.add('selected');
                    }
                    updateSelectedWords(); // 선택된 해시태그 업데이트
                    updateSelectedWordsString(); // 선택된 해시태그 문자열 업데이트
                    displayResult(); // 결과 출력 업데이트
                });
            });

            function updateSelectedMBTI() {
                const selectedHashtags = document.querySelectorAll('.hashtags-MBTI .hashtag.selected');
                selectedMBTIInput.value = selectedHashtags.length > 0 ? selectedHashtags[0].innerText : '';
            }

            function updateSelectedWords() {
                const selectedHashtags = document.querySelectorAll('.hashtags-words .hashtag.selected');
                selectedWordsInput.value = updateSelectedWordsString(); // updateSelectedWordsString() 함수 호출하여 값 할당
            }

            function updateSelectedWordsString() {
                const selectedHashtags = document.querySelectorAll('.hashtags-words .hashtag.selected');
                const result = Array.from(selectedHashtags).map(tag => tag.innerText).join(', ');
                return result;
            }

            function displayResult() {
                const result = updateSelectedWordsString();
                console.log(result); // 선택된 해시태그 문자열 얻기
                console.log(selectedMBTIInput.value); // MBTI 선택 값 얻기
            }

            function updateFormValues() {
                updateSelectedWords(); // 선택된 해시태그 업데이트
                updateSelectedMBTI(); // 선택된 MBTI 업데이트
            }
        });
    </script>
</body>
</html>
    