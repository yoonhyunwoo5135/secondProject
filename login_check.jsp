<%@page import="javax.swing.JOptionPane"%>
<%@page import="bean.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Login_Check</title>
	</head>
	<body>
		<%
			String InputId = request.getParameter("id");
			String InputPw = request.getParameter("pw");
			
			MemberDAO dao = MemberDAO.getInstance();
			boolean result = dao.LoginCheck(InputId, InputPw);
			
			if(result == true){
				session.setAttribute("InputId", InputId);
				response.sendRedirect("Main.jsp");
		%>
			
		<%
			} else if(result == false){
				out.write("<script>alert('회원정보를 확인해주세요!');</script>");
				out.write("<script>history.go(-1);</script>");
				
			}
			
		%>	
		 
	</body>
</html>