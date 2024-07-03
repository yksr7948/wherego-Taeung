<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
    
<!DOCTYPE html>
<html lang="en">
<head>
      
    <meta charset="UTF-8">
    <title>Document</title>
    <style>
        @import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css");




canvas {
  margin-top : 100px;  
  transition: 2s;
}

#rotateButton {
  z-index : 1000;
  background: #febf00;
  margin-top: 1rem;
  padding: .8rem 1.8rem;
  border: none;
  font-size: 1.5rem;
  font-weight: bold;
  border-radius: 5px;
  transition: .2s;
  cursor: pointer;
}

#rotateButton:active {
  background: #444;
  color: #f9f9f9;
}
 
#part {
  width: 100%;
  height : 960px;
  overflow: hidden;
  display: flex;
  align-items: center;
  text-align : center;
  flex-direction: column;
  position: relative;
}

#part::before {
  margin-top : 100px; 
  content: "";
  position: absolute;
  width: 10px;
  height: 50px;
  border-radius: 5px;
  background: #000;
  top: -20px;
  left: 50%;
  transform: translateX(-50%);
  z-index: 22;
}

#resultButton {
            display: none;
            background-color: white;
            text-align: center;
            color: black;
            padding: 10px 20px;
            border: 2px solid black;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 900;
            cursor: pointer;
            transition: background-color 0.3s, color 0.3s;
            position: absolute;
            top: calc(50% + 50px); /* canvas의 중심에서 상대적인 위치 계산 */
            left: calc(50% + 550px); /* canvas의 중심에서 상대적인 위치 계산 */
            transform: translate(-50%, -50%);
        }

#resultButton:hover{
	background-color: black;
    color: white;
}
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <div id="part">
        <canvas width="600" height='600'></canvas>  <button id="resultButton" onclick="goToSearch()"></button>
        <button  id="rotateButton" onclick="rotate()">돌려돌려 돌림판</button>
      </div>
      <script>
      var jsonData = '${list}';
      var product = JSON.parse(jsonData);
      const $c = document.querySelector("canvas");
const ctx = $c.getContext('2d');
//const product = ["햄버거", "순대국", "정식당", "중국집", "구내식당"];
const colors = [];
let result="";

function shuffleImages() {
	images.sort(() => 0.5 - Math.random());
}


const newMake = () => {
  const [cw, ch] = [$c.width / 2, $c.height / 2];
  const arc = Math.PI / (product.length / 2);  
  for (let i = 0; i < product.length; i++) {
    ctx.beginPath();
    if(colors.length == 0){
      for(var l=0; l<product.length; l++){
        let r = Math.floor(Math.random() * 256);
        let g = Math.floor(Math.random() * 256);
        let b = Math.floor(Math.random() * 256);
        colors.push("rgb(" + r + "," + g + "," + b + ")");
      }
    }
    ctx.fillStyle = colors[i % (colors.length)];
    ctx.moveTo(cw, ch);
    ctx.arc(cw, ch, cw, arc * (i - 1), arc * i);
    ctx.fill();
    ctx.closePath();
  }

  ctx.fillStyle = "#fff";
  ctx.font = "18px Pretendard";
  ctx.textAlign = "center";

  for (let i = 0; i < product.length; i++) {
    const angle = (arc * i) + (arc / 2);

    ctx.save();

    ctx.translate(
      cw + Math.cos(angle) * (cw - 50),
      ch + Math.sin(angle) * (ch - 50)
    );

    ctx.rotate(angle + Math.PI / 2);

     product[i].title.split(" ").forEach((text, j) => {
        ctx.fillText(text, 0, 30 * j);
      }); 

    ctx.restore();
  }
}

const rotate = () => {
	  $c.style.transform = `initial`;
	  $c.style.transition = `initial`;
	  
	  setTimeout(() => {
	    
	    const ran = Math.floor(Math.random() * product.length);

	    const arc = 360 / product.length;
	    const rotate = (ran * arc) + 3600 + (arc * 3) - (arc/4);
	    
	    $c.style.transform = "rotate(-"+rotate+"deg)";
	    $c.style.transition = `2s`;
	    
	    /* setTimeout(() => alert( product[ran-1].title), 2000);
	    result=product[ran-1].title;
	    createResultButton(result); */
	    setTimeout(() => {
            result=product[ran-1].title;
            createResultButton(result);
        }, 2000);
	    
	  }, 1);
	};
	
	
	const createResultButton = (title) => {
	    const resultButton = document.getElementById('resultButton');
	    resultButton.innerText = title+" 구경하기";
	    resultButton.style.display = 'block';
	};
	
	const goToSearch = () => {
        const keyword = encodeURIComponent(result);
        window.location.href = "search.wherego?keyword="+keyword;
    };

newMake();
      </script>
      <%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>