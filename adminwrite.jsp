<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<%
			String userId = (String)session.getAttribute("InputId");
			
			if(userId.equals("admin")){
				response.sendRedirect("write.jsp");
			}else{
				out.write("<script>alert('사용권한이 없습니다.')</script>");
				out.write("<script>history.go(-1)</script>");
			};
			
		%>
	</body>
</html>