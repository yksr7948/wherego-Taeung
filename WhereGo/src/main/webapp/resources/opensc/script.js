const imageNames = [
    "고기볶음밥.jpg", "김밥.jpg", "비빔밥.jpg", "치킨.jpg", "삼겹살.jpg", 
    "비빔밥2.jpg", "크림스파게티.jpg", "만두.jpg", "떡볶이.jpg", "짜장면.jpg", 
    "짬뽕.jpg", "돈까스.jpg", "분짜.jpg", "뭔지안보임.jpg", "볶음밥.jpg", "피자.jpg"
];

// 파일 이름 배열을 'image/' 폴더 경로가 붙은 배열로 변환하는 함수
function prependImagePath(imageNames) {
    return imageNames.map(imageName => `image/${imageName}`);
}

let images = prependImagePath(imageNames);
let selectedImages = [];
let currentPairIndex = 0;
let round = 16;

function shuffleImages() {
    images.sort(() => 0.5 - Math.random());
}

function displayCurrentImagePair() {
    if (currentPairIndex < images.length - 1) {
        document.getElementById('image').src = images[currentPairIndex];
        document.getElementById('images').src = images[currentPairIndex+1];
        document.getElementById('imageText').innerText = images[currentPairIndex].split('/')[1].slice(0, -4);
        document.getElementById('imagesText').innerText = images[currentPairIndex+1].split('/')[1].slice(0, -4);
    }
}


function handleImageSelection(selectedImageIndex) {
    selectedImages.push(images[currentPairIndex + selectedImageIndex]);
    currentPairIndex += 2;

    if (currentPairIndex < images.length - 1) {
        displayCurrentImagePair();
    } else if (selectedImages.length > 1) {
        images = selectedImages;
        selectedImages = [];
        currentPairIndex = 0;
        round = round / 2;
        document.getElementById('round').innerText = round + "강 대전";
        displayCurrentImagePair();
    } else {
        // 우승자가 정해졌을 때
        const winnerImageName = selectedImages[0].split('/')[1].slice(0, -4); // 'image/' 부분을 제거
        document.getElementById('cal').innerText = "우승자는: " + winnerImageName;
        document.getElementById('image').src = selectedImages[0];
        document.getElementById('images').style.display = "none";
        document.getElementById('round').innerText = "우승!";
        document.getElementById('imageText').innerText = "";
        document.getElementById('imagesText').innerText = "";
    }
    
}

function initializeIdealTypeWorldCup() {
    shuffleImages();
    document.getElementById('round').innerText = round + "강 대전";
    displayCurrentImagePair();
}

initializeIdealTypeWorldCup();
