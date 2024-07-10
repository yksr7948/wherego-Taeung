<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행 계획 상세 보기</title>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=7whhnl24e7"></script>
<style>
main {
    padding: 20px;
    width: 60%;
    margin: auto;
    margin-top: 5%;
}
font{
    cursor: auto;
}

/* 헤더부분 */
.main-title {
    font-size: 40px;
    font-weight: 900;
    text-align: center;
}
.data-info{
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 0;
}

/* 이미지부분 */
.image-info {
    text-align: center;
    margin-bottom: 20px;
}
.image-info img{
    width: 1000px;
    height: auto;
}

.description {
    margin-top: 70px;
    font-size: 16px;
    color: #333;
    line-height: 1.5;
}

/* 상세보기 */
.details-info {
    padding: 20px;
}
.details-info .day-section {
    margin-bottom: 20px;
}
.details-info th, .details-info td{
    padding: 10px;
}
.details-info th{
    font-size: 20px;
    width: 150px;
}
.day-header {
    background-color: #f0f0f0;
    padding: 10px;
    font-weight: bold;
}

/* 지도 */
#map-container{
    display: flex;
    justify-content: center;
    margin-top: 20px;
}
#map{
    width: 100%;
    height: 400px;
}

/* 날짜 버튼 */
#day-buttons {
    display: flex;
    justify-content: center;
    margin-bottom: 20px;
}
.day-btn {
    background-color: #ffffff;
    border: 2px solid #333;
    border-radius: 25px;
    padding: 10px 20px;
    margin: 0 10px;
    cursor: pointer;
    transition: all 0.3s ease;
}
.day-btn.active, .day-btn:hover {
    background-color: #333;
    color: #ffffff;
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<main>

    <div class="details-info">
        <h1 class="main-title">플래너 상세정보</h1>
        <br> <br>
        <div id="plan-details">
            <c:set var="dayCounter" value="1" />
            <c:forEach var="plan" items="${planDataList}" varStatus="status">
                <c:if test="${status.first || plan.day != previousDay}">
                    <div class="day-section" id="day${plan.day}">
                        <div class="day-header">Day ${dayCounter}</div>
                        <c:set var="dayCounter" value="${dayCounter + 1}" />
                </c:if>
                <div><br>
                    <th>방문시간: <c:out value="${plan.time}" /></th>
                    <td>방문하는 곳: <c:out value="${plan.name}" /></td>
                </div>
                <c:if test="${status.last || plan.day != planDataList[status.index + 1].day}">
                    </div>
                </c:if>
                <c:set var="previousDay" value="${plan.day}" />
            </c:forEach>
        </div>
    </div>
    
    <br> <br> <hr> <br> <br> <br>
    
    <!-- 지도 API -->  
    <h1 class="main-title">코스</h1>
    <br> <br>
    <div id="day-buttons">
        <c:forEach var="plan" items="${planDataList}" varStatus="status">
            <c:if test="${status.first || plan.day != previousDay}">
                <button class="day-btn" id="btn-day${plan.day}" onclick="showDay('${plan.day}')">Day ${status.index + 1}</button>
                <c:set var="previousDay" value="${plan.day}" />
            </c:if>
        </c:forEach>
    </div>
    <div id="map-container">
        <div id="map"></div>
    </div>  
    
    <script>
        var initialMapX = parseFloat('<c:out value="${initialMapX}" />');
        var initialMapY = parseFloat('<c:out value="${initialMapY}" />');

        var mapOptions = {
            center: new naver.maps.LatLng(initialMapY, initialMapX),
            zoom: 14
        };

        var map = new naver.maps.Map('map', mapOptions);

        var planDataList = JSON.parse('<c:out value="${planDataJson}" escapeXml="false" />');
        console.log('planDataList:', planDataList);  // 데이터를 콘솔에 출력하여 확인합니다.

        var markers = [];
        var polylines = [];

        var currentMarkers = [];
        var currentPolyline = null;

        var groupedData = planDataList.reduce(function(acc, location) {
            var day = location.day;  // 날짜 형식 변환 없이 그대로 사용
            if (!acc[day]) {
                acc[day] = {
                    markers: [],
                    path: []
                };
            }

            var marker = new naver.maps.Marker({
                position: new naver.maps.LatLng(parseFloat(location.mapy), parseFloat(location.mapx)),
                title: location.name,
                icon: {
                    url: 'https://navermaps.github.io/maps.js/docs/img/example/pin_default.png',
                    size: new naver.maps.Size(24, 37),
                    anchor: new naver.maps.Point(12, 37)
                }
            });

            var infowindow = new naver.maps.InfoWindow({
                content: '<div style="width:150px;text-align:center;padding:10px;">' + location.name + '</div>'
            });

            naver.maps.Event.addListener(marker, "mouseover", function(e) {
                infowindow.open(map, marker);
            });

            naver.maps.Event.addListener(marker, "mouseout", function(e) {
                infowindow.close();
            });

            acc[day].markers.push(marker);
            acc[day].path.push(marker.getPosition());

            return acc;
        }, {});

        console.log('groupedData:', groupedData);  // 그룹화된 데이터를 콘솔에 출력하여 확인합니다.

        function showDay(day) {
            console.log("Showing day: " + day);
            if (!groupedData[day]) {
                console.error("No data found for day: " + day);
                return;
            }
            
            // 기존 마커 제거
            currentMarkers.forEach(function(marker) {
                marker.setMap(null);
            });
            if (currentPolyline) {
                currentPolyline.setMap(null);
            }

            // 선택한 날짜의 마커와 경로 설정
            currentMarkers = groupedData[day].markers;
            currentMarkers.forEach(function(marker) {
                marker.setMap(map);
            });

            currentPolyline = new naver.maps.Polyline({
                map: map,
                path: groupedData[day].path,
                strokeColor: '#FF0000',
                strokeOpacity: 0.8,
                strokeWeight: 6
            });

            // 버튼 활성화 상태 설정
            document.querySelectorAll('.day-btn').forEach(function(button) {
                button.classList.remove('active');
            });
            var activeButton = document.getElementById('btn-day' + day);
            if (activeButton) {
                activeButton.classList.add('active');
            }
        }

        var firstDay = Object.keys(groupedData)[0];
        if (firstDay) {
            showDay(firstDay);
            var firstButton = document.getElementById('btn-day' + firstDay);
            if (firstButton) {
                firstButton.classList.add('active');
            }
        }
    </script>

</main>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
