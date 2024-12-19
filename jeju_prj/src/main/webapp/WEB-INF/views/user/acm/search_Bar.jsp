<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
        <form role="search" class="search-form">
            <!-- 검색 입력란 -->
            <div class="search-input">
                <input id="search-term" name="search_term" type="text" placeholder="여행지나 숙소를 검색해보세요." maxlength="50" autocomplete="off">
            </div>

            <!-- 날짜 선택 -->
            <div class="date-picker">
                <button type="button" class="date-button" id="open-calendar" aria-label="Select dates">
                    <span>날짜 선택</span>
                </button>
                <input type="text" id="hidden-date-input" style="display: none;">
            </div>

            <!-- 인원 선택 -->
            <div class="guest-picker" id="guest-picker">
                <span id="guest-display">인원 2명</span>
                <button type="button" class="guest-button" id="guest-button">인원 선택</button>
            </div>

            <!-- 검색 버튼 -->
            <div class="search-button">
                <button type="submit" class="search-submit">
                    <span>검색</span>
                </button>
            </div>
        </form>
    </div>

    <!-- 모달 -->
    <div class="guest-modal" id="guest-modal">
        <div class="modal-content">
            <h3>인원 선택</h3>
            <button id="decrease-guest" class="guest-button">-</button>
            <span id="modal-guest-display">2명</span>
            <button id="increase-guest" class="guest-button">+</button>
            <button id="complete-button" class="modal-button">완료</button>
        </div>
    </div>

</body>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script>
 // 날짜 선택기 설정
    const dateInput = document.getElementById("hidden-date-input");
    const dateButton = document.getElementById("open-calendar");

    const flatpickrInstance = flatpickr(dateInput, {
        mode: "range",
        dateFormat: "Y-m-d",  // 날짜 포맷을 Y-m-d로 설정
        onChange: function (selectedDates) {
            if (selectedDates.length > 0) {
                const startDate = selectedDates[0];
                const endDate = selectedDates[1] || startDate;
                const dateRangeText = formatDateRange(startDate, endDate);
                dateButton.querySelector('span').innerText = dateRangeText;
            }
        }
    });

    dateButton.addEventListener('click', () => {
        flatpickrInstance.open();
    });

    // 날짜 포맷: 월.일 요일 형식으로 변환 (옛날 방식)
    function formatDateRange(startDate, endDate) {
        const startMonthDay = formatDate(startDate);  // 시작일
        const endMonthDay = formatDate(endDate);  // 종료일
        return startMonthDay + " - " + endMonthDay;
    }

    // 월.일 요일 형식으로 날짜 변환
    function formatDate(date) {
        const months = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"];
        const daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"];

        const month = months[date.getMonth()];  // 월
        const day = date.getDate();  // 일
        const weekday = daysOfWeek[date.getDay()];  // 요일

        return month + "." + day + " " + weekday;
    }

        // 인원 선택 모달 열기
        const guestButton = document.getElementById('guest-button');
        const guestModal = document.getElementById('guest-modal');
        guestButton.addEventListener('click', () => {
            guestModal.classList.add('active');
        });

        // 기본 인원 수 2명, 최대 10명
        let guestCount = 2;
        const modalGuestDisplay = document.getElementById('modal-guest-display');
        const guestDisplay = document.getElementById('guest-display');

        document.getElementById('increase-guest').addEventListener('click', () => {
            if (guestCount < 10) {
                guestCount++;
                // 인원 표시용 변수 생성
                var guestText = guestCount + "명";  // 일반 변수로 텍스트 생성
                modalGuestDisplay.innerText = guestText;  // 모달의 숫자 갱신
                guestDisplay.innerText = "인원 " + guestText;  // 메인 페이지의 숫자 갱신
            }
        });

        document.getElementById('decrease-guest').addEventListener('click', () => {
            if (guestCount > 1) {
                guestCount--;
                // 인원 표시용 변수 생성
                var guestText = guestCount + "명";  // 일반 변수로 텍스트 생성
                modalGuestDisplay.innerText = guestText;  // 모달의 숫자 갱신
                guestDisplay.innerText = "인원 " + guestText;  // 메인 페이지의 숫자 갱신
            }
        });

        // 완료 버튼 클릭 시 모달 닫기
        document.getElementById('complete-button').addEventListener('click', () => {
            guestModal.classList.remove('active');
        });

        // 검색 버튼 클릭 시 검색어 처리
        document.querySelector('.search-submit').addEventListener('click', (event) => {
            event.preventDefault();
            const searchTerm = document.querySelector('#search-term').value;
            if (searchTerm.trim() === "") {
                alert('검색어를 입력해주세요.');
            } else {
                console.log('검색어:', searchTerm);
                console.log('날짜:', dateInput.value);
                console.log('인원:', guestCount);
            }
        });
    </script>
</html>
