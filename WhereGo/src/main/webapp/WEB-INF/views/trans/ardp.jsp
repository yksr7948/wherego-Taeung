<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<label for="selectDate">Select Date</label>

<input type="date" id="selectDate" name="selectDate" value="" min="" max="" />

출발지 : <input type="text" id="departure" name="departure"/>
도착지 : <input type="text" id="arrival" name="arrival"/>

<button id="searchBtn">조회</button>


<table border="1"  id="result">
			<thead>
				<tr>
					<th>도착지</th>
					<th>도착시간</th>
					<th>비용</th>
					<th>출발지</th>
					<th>출발시간</th>
					<th>등급</th>
				</tr>
			</thead>
			<tbody>
	
			</tbody>
		</table>

<script>
$(function() {

	$("#searchBtn").click(
			function() {
			
				$.ajax({
					url : "getArdp.tr",
					data : {
						date : $("#selectDate").val().replace(/-/g, ""),
						departure : $("#departure").val(),
						arrival : $("#arrival").val()
					},
					success : function(data) {
						var check=data.response.body.totalCount;
						if(check==0){
							alert("해당 노선 없습니다.");
						}else{
							
						var items = data.response.body.items.item;
						
						console.log("확인성공");
					
						var str = "";
						for (var i = 0; i < items.length; i++) {

							var item = items[i];

							str += "<tr>" 
								+ "<td>"+item.arrPlaceNm+"</td>" 
								+ "<td>"+item.arrPlandTime+"</td>"
								+ "<td>"+item.charge+"</td>" 
								+ "<td>"+item.depPlaceNm+"</td>" 
								+ "<td>"+item.depPlandTime+"</td>" 
								+ "<td>"+item.gradeNm+"</td>" 
								+ "</tr>";
						}

						$("#result tbody").html(str);
						}
						
					},
					error : function() {
					}
				});

			}); 
});


console.log($("#selectDate").val());
function formatDate(date) {
    let d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;

    return [year, month, day].join('-');
}

const today = new Date();
const maxDate = new Date();
maxDate.setDate(today.getDate() + 30);

document.getElementById('selectDate').value = formatDate(today);
document.getElementById('selectDate').min = formatDate(today);
document.getElementById('selectDate').max = formatDate(maxDate);
</script>
</body>
</html>
    