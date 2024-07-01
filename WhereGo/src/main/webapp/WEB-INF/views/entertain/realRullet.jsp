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
    </style>
</head>
<body>
    <div id="part">
        <canvas width="600" height='600'></canvas>  
        <button  id="rotateButton" onclick="rotate()">돌려돌려 돌림판</button>
      </div>
      <script>
        const $c = document.querySelector("canvas");
const ctx = $c.getContext('2d');
const product = ["햄버거", "순대국", "정식당", "중국집", "구내식당"];
const colors = [];

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

    product[i].split(" ").forEach((text, j) => {
      ctx.fillText(text, 0, 30 * j);
    });

    ctx.restore();
  }
}

const rotate = () => {
  $c.style.transform = 'initial';
  $c.style.transition = 'initial';
  const alpha = Math.floor(Math.random()*100);

  setTimeout(() => {    
    const ran = Math.floor(Math.random() * product.length);
    const arc = 360 / product.length;
    const rotate = (ran * arc) + 3600 + (arc * 3) - (arc/4) + alpha;
    $c.style.transform = `rotate(-${rotate}deg)`;
    $c.style.transition = '2s';
    
  }, 1);
};


function add(){
  if(menuAdd.value != undefined && menuAdd.value != ""){
    product.push(menuAdd.value);
    let r = Math.floor(Math.random() * 256);
    let g = Math.floor(Math.random() * 256);
    let b = Math.floor(Math.random() * 256);
    colors.push("rgb(" + r + "," + g + "," + b + ")");
    newMake();
    menuAdd.value="";	
  }
  else{
    alert("메뉴를 입력한 후 버튼을 클릭 해 주세요");
  }
}

newMake();
      </script>
</body>
</html>