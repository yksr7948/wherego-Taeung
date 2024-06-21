<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>해시태그 선택</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
        }
        .hashtag {
            display: inline-block;
            margin: 5px;
            padding: 10px;
            background-color: #f0f0f0;
            border-radius: 15px;
            cursor: pointer;
        }
        .selected {
            background-color: #ff69b4;
            color: white;
        }
    </style>
</head>
<body>
    <h1>해시태그 선택</h1>
    <div id="hashtags">
        <span class="hashtag">일상</span>
        <span class="hashtag">일상스타그램</span>
        <span class="hashtag">일상그램</span>
        <span class="hashtag">육아일상</span>
        <span class="hashtag">일상기록</span>
        <span class="hashtag">일상소통</span>
        <span class="hashtag">일상룩</span>
        <span class="hashtag">일상사진</span>
        <!-- 필요한 해시태그를 더 추가하세요 -->
    </div>
    <form id="hashtagForm" action="submit_form.php" method="POST">
        <input type="hidden" id="selectedHashtags" name="selectedHashtags" value="">
        <button type="submit">제출</button>
    </form>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const hashtags = document.querySelectorAll('.hashtag');
            const selectedHashtagsInput = document.getElementById('selectedHashtags');

            hashtags.forEach(hashtag => {
                hashtag.addEventListener('click', () => {
                    hashtag.classList.toggle('selected');
                    updateSelectedHashtags();
                });
            });

            function updateSelectedHashtags() {
                const selectedHashtags = [];
                document.querySelectorAll('.hashtag.selected').forEach(selectedHashtag => {
                    selectedHashtags.push(selectedHashtag.innerText);
                });
                selectedHashtagsInput.value = selectedHashtags.join(',');
            }
        });
    </script>
</body>
</html>