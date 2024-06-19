<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>여행지도</title>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=7whhnl24e7"></script>
    <style>
        body {
            display: block;
            margin: 0;
        }
        #mapContainer {
            display: flex;
            width: 100%;
            height: calc(100vh - 60px); /* Adjust the height to fit below the header */
        }
        #map {
            width: 100%;
            height: 100%; /* Full height */
            transition: width 0.3s;
        }
        #sidebar {
            width: 30%;
            height: 100%; /* Full height */
            overflow-y: auto;
            background-color: #ffffff;
            padding: 20px;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
            display: none; /* Hide sidebar initially */
            font-family: Arial, sans-serif;
            color: #333;
        }
        #sidebar h2 {
            font-size: 24px;
            margin-bottom: 20px;
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
        }
        #sidebar p {
            margin: 10px 0;
            line-height: 1.6;
        }
        #sidebar img {
            margin-top: 20px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        #searchAgainBtn {
            display: none;
            position: absolute;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 10;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            cursor: pointer;
            font-size: 16px;
        }
        #searchAgainBtn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div id="mapContainer">
    <div id="map"></div>
    <div id="sidebar">
        <h2 id="title"></h2>
        <p id="addr1Wrapper"><strong>주소:</strong> <span id="addr1"></span></p>
        <p id="addr2Wrapper"><strong>상세 주소:</strong> <span id="addr2"></span></p>
        <p id="firstimageWrapper"><strong>대표 이미지:</strong></p>
        <img id="firstimage" src="" alt="대표 이미지" style="width:100%; height:auto;">
    </div>
</div>
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
                        title: location.title,
                        icon: {
                            url: 'https://navermaps.github.io/maps.js/docs/img/example/pin_default.png',
                            size: new naver.maps.Size(50, 50),
                            scaledSize: new naver.maps.Size(50, 50),
                            origin: new naver.maps.Point(0, 0),
                            anchor: new naver.maps.Point(25, 50)
                        }
                    });

                    var infowindow = new naver.maps.InfoWindow({
                        content: '<div style="width:150px;text-align:center;padding:10px;">' + location.title + '</div>'
                    });

                    naver.maps.Event.addListener(marker, "mouseover", function(e) {
                        infowindow.open(map, marker);
                    });

                    naver.maps.Event.addListener(marker, "mouseout", function(e) {
                        infowindow.close();
                    });

                    naver.maps.Event.addListener(marker, "click", function(e) {
                        displaySidebar(location);
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

    // 지도 클릭 이벤트 처리
    naver.maps.Event.addListener(map, 'click', function(e) {
        hideSidebar();
    });

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

    function displaySidebar(location) {
        var sidebar = document.getElementById('sidebar');
        var mapDiv = document.getElementById('map');

        document.getElementById('title').innerText = location.title || '정보 없음';

        if (location.addr1) {
            document.getElementById('addr1Wrapper').style.display = 'block';
            document.getElementById('addr1').innerText = location.addr1;
        } else {
            document.getElementById('addr1Wrapper').style.display = 'none';
        }

        if (location.addr2) {
            document.getElementById('addr2Wrapper').style.display = 'block';
            document.getElementById('addr2').innerText = location.addr2;
        } else {
            document.getElementById('addr2Wrapper').style.display = 'none';
        }

        var firstImageElement = document.getElementById('firstimageWrapper');
        if (location.firstimage) {
            firstImageElement.style.display = 'block';
            document.getElementById('firstimage').src = location.firstimage;
        } else {
            firstImageElement.style.display = 'none';
        }

        sidebar.style.display = 'block';
        mapDiv.style.width = '70%';
    }

    function hideSidebar() {
        var sidebar = document.getElementById('sidebar');
        var mapDiv = document.getElementById('map');

        sidebar.style.display = 'none';
        mapDiv.style.width = '100%';
    }
</script>
</body>
</html>
