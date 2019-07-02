<%@page import="bean.MemberDTO"%>
<%@page import="bean.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>회원정보</title>
</head>

<body>
	<jsp:useBean id="dto" class="bean.MemberDTO"></jsp:useBean>
	<jsp:setProperty property="*" name="dto" />

	<%
		MemberDAO dao = new MemberDAO();
		dto = new MemberDTO();

		String id = request.getParameter("id");
		String pw = request.getParameter("pw1");
		String name = request.getParameter("name");
		String gender = request.getParameter("gender");
		String eId = request.getParameter("eId");
		String eAdd = request.getParameter("eAdd");
		String email = eId+eAdd;
		
		
		String y = request.getParameter("birthY");
		String m = request.getParameter("birthM");
		String d = request.getParameter("birthD");
		String birth = y+m+d; 
		
		dto.setId(id);
		dto.setPw(pw);
		dto.setName(name);
		dto.setGender(gender);
		dto.setBirth(birth);
		dto.setEmail(email);
		
		dao.insert(dto);
   %>
	<%=dto.getId()%>

</body>

</html>