<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행 계획 상세 보기</title>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=7whhnl24e7"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/planDetail-style.css">
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
    <div id="map-container">
        <div id="map"></div>
        <div id="legend"></div> <!-- 범례를 코스 아래에 추가 -->
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

        var markers = [];
        var polylines = [];

        var colorList = ['#FF0000', '#00FF00', '#0000FF', '#FFFF00', '#FF00FF', '#00FFFF'];  // 색깔 리스트
        var colorIndex = 0;

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


        var legend = document.getElementById('legend');

        // 모든 경로를 지도에 표시
        Object.keys(groupedData).forEach(function(day) {
            var color = colorList[colorIndex % colorList.length];  // 색깔을 순환하여 사용
            colorIndex++;
            
            // 마커를 지도에 표시
            groupedData[day].markers.forEach(function(marker) {
                marker.setMap(map);
            });

            // 경로를 지도에 표시
            var polyline = new naver.maps.Polyline({
                map: map,
                path: groupedData[day].path,
                strokeColor: color,
                strokeOpacity: 0.8,
                strokeWeight: 6
            });
            polylines.push(polyline);

            // 범례에 추가
            var legendItem = document.createElement('div');
            legendItem.innerHTML = '<span style="background-color:' + color + ';"></span> ' + day;
            legend.appendChild(legendItem);
        });

    </script>

</main>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
