<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>간단한 지도 표시하기</title>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=7whhnl24e7"></script>
    <style>
        #searchAgainBtn {
            display: none;
            position: absolute;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 10;
            padding: 20px 40px;
            background-color: #fff;
            border: 1px solid #ddd;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            cursor: pointer;
        }
    </style>
</head>
<body>
<div id="map" style="width:100%;height:1000px;"></div>
<button id="searchAgainBtn" onclick="searchAgain()">현재 위치에서 다시 검색하기</button>

<script>
    var mapX = ${mapX};
    var mapY = ${mapY};

    var mapOptions = {
        center: new naver.maps.LatLng(mapY, mapX),
        zoom: 15
    };

    var map = new naver.maps.Map('map', mapOptions);

    // 관광 데이터 파싱 및 마커 추가
    var touristData = '${touristData}';

    if (touristData) {
        try {
            var parsedData = JSON.parse(touristData);
            var items = parsedData.response.body.items.item;

            if (items && items.length) {
                items.forEach(function(location) {
                    var marker = new naver.maps.Marker({
                        position: new naver.maps.LatLng(parseFloat(location.mapy), parseFloat(location.mapx)),
                        map: map,
                        title: location.title
                    });

                    var infowindow = new naver.maps.InfoWindow({
                        content: '<div style="width:150px;text-align:center;padding:10px;">' + location.title + '</div>'
                    });

                    naver.maps.Event.addListener(marker, "click", function(e) {
                        if (infowindow.getMap()) {
                            infowindow.close();
                        } else {
                            infowindow.open(map, marker);
                        }
                    });
                });
            } else {
                document.write("No items found in the response");
            }
        } catch (e) {
            document.write("Error parsing JSON data: " + e);
        }
    } else {
        document.write("No touristData available");
    }

    // 지도 이동 이벤트 처리
    naver.maps.Event.addListener(map, 'dragend', function() {
        document.getElementById('searchAgainBtn').style.display = 'block';
    });

    // 현재 지도 중심에서 다시 검색
    function searchAgain() {
        var center = map.getCenter();
        var mapX = center.lng();
        var mapY = center.lat();

        window.location.href = '${pageContext.request.contextPath}/travelMap?mapX=' + mapX + '&mapY=' + mapY;
    }
</script>
</body>
</html>
