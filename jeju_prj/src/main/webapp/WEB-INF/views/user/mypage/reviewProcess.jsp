<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- controller에서 넘어오는 msg 출력 -->
<!-- 값이 안전하게 자바스크립트에서 처리되도록 반드시 이스케이프 처리-->
<c:if test="${not empty msg}">
	<script>
		const resultMsg = "<c:out value='${msg}' escapeXml='true' />";
		alert(resultMsg);
		location.href = "/mypage/rerListFrm";
	</script>
</c:if>