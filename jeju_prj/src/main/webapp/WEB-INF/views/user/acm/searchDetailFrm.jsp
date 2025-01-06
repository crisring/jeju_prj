<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>숙소 상세</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }

        .room-detail {
            padding: 20px;
            background-color: #fff;
            margin: 20px auto;
            max-width: 800px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .room-detail h2 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 24px;
        }

        .room-info {
            display: flex;
            gap: 20px;
        }

        .room-info .left {
            flex: 1;
        }

        .room-info .right {
            flex: 1;
        }

        .room-info img {
            width: 100%;
            height: auto;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .room-price {
            font-size: 20px;
            font-weight: bold;
            color: #007bff;
            margin-top: 20px;
        }

        .room-description {
            font-size: 16px;
            margin-top: 20px;
        }

        .room-gallery img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            margin-right: 10px;
            cursor: pointer;
        }

        .room-gallery {
            margin-top: 20px;
        }
    </style>
</head>
<body>

<div class="room-detail">
    <!-- 숙소 제목 -->
    <h2 id="room-title">숙소 제목</h2>

    <div class="room-info">
        <!-- 숙소 설명 및 가격 -->
        <div class="left">
            <div class="room-description" id="room-description">숙소 설명</div>
            <div class="room-price" id="room-price">가격: 0원</div>
        </div>

        <!-- 숙소 대표 사진 -->
        <div class="right">
            <img id="main-photo" src="" alt="Main Room Photo">
        </div>
    </div>

    <!-- 갤러리 -->
    <div class="room-gallery" id="photo-gallery">
        <!-- 사진이 동적으로 추가될 예정 -->
    </div>
</div>

<script>
    // 페이지 로드 시, Ajax로 받은 데이터를 활용하여 상세 정보 표시
    document.addEventListener("DOMContentLoaded", function() {
        const roomId = new URLSearchParams(window.location.search).get("roomId");

        // 서버에서 방 상세 정보를 가져오는 AJAX 요청
        fetch(`/room/details?roomId=${roomId}`)
            .then((response) => response.json())
            .then((data) => {
                // 받은 데이터를 페이지에 표시
                document.getElementById("room-title").innerText = data.title;
                document.getElementById("room-description").innerText = data.description;
                document.getElementById("room-price").innerText = `가격: ${data.price}원`;
                document.getElementById("main-photo").src = data.photos[0].url; // 첫 번째 사진을 대표 사진으로 설정

                // 갤러리 사진 표시
                const photoGallery = document.getElementById("photo-gallery");
                data.photos.forEach((photo) => {
                    const imgElement = document.createElement("img");
                    imgElement.src = photo.url;
                    imgElement.alt = "Room Photo";
                    imgElement.classList.add("gallery-photo");
                    photoGallery.appendChild(imgElement);
                });
            })
            .catch((error) => {
                console.error("Error fetching room details:", error);
            });
    });
</script>

</body>
</html>
