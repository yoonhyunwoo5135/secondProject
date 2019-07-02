<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>logout</title>
	</head>
	<body>
		<%
			// 세션 id 삭제
			session.invalidate();
			// 메인페이지로 돌아가기
			response.sendRedirect("Main.jsp");
		%>
	</body>
</html>