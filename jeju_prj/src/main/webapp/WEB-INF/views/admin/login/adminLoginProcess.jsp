<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:choose>

	<c:when test="${loginFlag}">
		<script>
			alert(`${admin_id}님 안녕하세요!`);
			location.href = "/admin";
		</script>
	</c:when>
	<c:otherwise>

		<script>
			alert(`아이디 비번을 확인해주세요!`);
			location.href = "/admin/loginFrm";
		</script>

	</c:otherwise>


</c:choose>



<c:if test="">



</c:if>