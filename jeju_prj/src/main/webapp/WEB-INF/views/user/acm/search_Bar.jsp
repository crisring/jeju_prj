<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>숙소 검색</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }

        .accommodation-search {
            padding: 20px;
            background-color: #fff;
            margin: 20px auto;
            max-width: 800px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .accommodation-search h2 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 24px;
        }

        .search-form {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .search-input, .date-picker, .guest-picker {
            display: flex;
            align-items: center;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #fff;
            padding: 5px 10px;
            flex: 1;
        }

        .search-input input {
            border: none;
            outline: none;
            flex-grow: 1;
            padding: 8px;
        }

        .date-button, .guest-button {
            cursor: pointer;
            border: none;
            background-color: transparent;
            font-size: 16px;
        }

        .search-button {
            margin-left: auto;
        }

        .search-submit {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .search-submit:hover {
            background-color: #0056b3;
        }

        .guest-picker {
            display: flex;
            align-items: center;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #fff;
            padding: 5px 10px;
            position: relative;
            width: 120px;
            cursor: pointer;
        }

        .guest-picker span {
            margin-right: 10px;
        }

        .guest-dropdown {
            display: none;
            position: absolute;
            top: 100%;
            left: 0;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            width: 120px;
            z-index: 10;
        }

        .guest-dropdown button {
            background-color: transparent;
            border: none;
            font-size: 18px;
            cursor: pointer;
            margin: 5px 0;
            width: 100%;
            text-align: left;
        }

        .guest-dropdown button:hover {
            background-color: #f1f1f1;
        }

        .guest-picker.active + .guest-dropdown {
            display: block;
        }

        .guest-modal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            z-index: 1000;
        }

        .guest-modal.active {
            display: block;
        }

        .modal-content {
            text-align: center;
        }

        .modal-button {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 20px;
        }

        .modal-button:hover {
            background-color: #0056b3;
        }

        .close-modal {
            background-color: #ccc;
            border: none;
            padding: 5px 10px;
            margin-top: 10px;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="accommodation-search">
        <h2>숙소 검색</h2>
		<form id="searchForm" role="search" class="search-form" method="GET" action="/acm/searchProcess">
		    <!-- 검색 입력란 -->
		    <div id="search-live-display">검색어: </div>
		    <input id="search-term" name="search_term" type="text" placeholder="여행지나 숙소를 검색해보세요." maxlength="50" autocomplete="off" oninput="updateLiveDisplay()" required>

		    <!-- 날짜 선택 -->
		    <div class="date-picker">
		        <button type="button" class="date-button" id="open-calendar" aria-label="Select dates">
		            <span>날짜 선택</span>
		        </button>
		        <input type="hidden" id="hidden-date-input" name="date_range">
		    </div>

		    <!-- 인원 선택 -->
		    <div class="guest-picker" id="guest-picker">
		        <span id="guest-display">인원 2명</span>
		        <button type="button" class="guest-button" id="guest-button">인원 선택</button>
		        <input type="hidden" id="guest-count" name="numberPeople" value="2">
		    </div>

		    <!-- 검색 버튼 -->
		    <div class="search-button">
		        <button type="submit" class="search-submit">
		            <span>검색</span>
		        </button>
		    </div>
		</form>

		<script>
		    // 날짜 포맷 지정 및 전송 데이터 업데이트
		    flatpickrInstance.config.onChange = function (selectedDates) {
		        if (selectedDates.length > 0) {
		            const startDate = selectedDates[0];
		            const endDate = selectedDates[1] || startDate;
		            const dateRangeText = formatDateRange(startDate, endDate);
		            dateButton.querySelector('span').innerText = dateRangeText;
		            document.getElementById("hidden-date-input").value = `${startDate.toISOString().slice(0, 10)} to ${endDate.toISOString().slice(0, 10)}`;
		        }
		    };

		    // 인원 선택 데이터 업데이트
		    document.getElementById('increase-guest').addEventListener('click', () => {
		        if (guestCount < 10) {
		            guestCount++;
		            updateGuestDisplay();
		        }
		    });

		    document.getElementById('decrease-guest').addEventListener('click', () => {
		        if (guestCount > 1) {
		            guestCount--;
		            updateGuestDisplay();
		        }
		    });

		    function updateGuestDisplay() {
		        document.getElementById('guest-count').value = guestCount;
		        modalGuestDisplay.innerText = `${guestCount}명`;
		        guestDisplay.innerText = `인원 ${guestCount}명`;
		    }

		    // 검색 버튼 클릭 이벤트 처리
		    document.querySelector('.search-submit').addEventListener('click', (event) => {
		        const searchTerm = document.querySelector('#search-term').value.trim();
		        if (searchTerm === "") {
		            event.preventDefault(); // 폼 전송 막기
		            alert('검색어를 입력해주세요.');
		        }
		    });
		</script>
		</head>
