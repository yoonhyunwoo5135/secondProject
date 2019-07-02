<%@page import="java.io.Console"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="bean.BoardDTO"%>
<%@page import="bean.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insertBoard</title>
	</head>
	<body>
		<jsp:useBean id="dto" class="bean.BoardDTO"></jsp:useBean>
		<jsp:setProperty property="*" name="dto"/>
		<%
			BoardDAO dao = new BoardDAO();
			dto = new BoardDTO();
			// 날짜
			Calendar cal = Calendar.getInstance();
			int year = cal.get(cal.YEAR);
			int month = cal.get(cal.MONTH) + 1;
			int day = cal.get(cal.DATE);
			String date=null;
			
			if(month < 10 && day < 10){
	            date = Integer.toString(year) + "0"  + Integer.toString(month) + "0" + Integer.toString(day);
	         }else if(month >= 10 && day >= 10){
	            date = Integer.toString(year) + Integer.toString(month) + Integer.toString(day);
	         }
			// write.jsp에서 값 받아오기
		
			String title = request.getParameter("title");
			String id = (String)session.getAttribute("InputId");
			String content = request.getParameter("content");
			
			System.out.println("제목 : " + title);
			System.out.println("세션아디 : " + id);
			System.out.println("내용 : "+content);
			
			// dto에 넣을 값 세팅
			dto.setTitle(title);
			dto.setId(id);
			dto.setContent(content);
			dto.setDate(date);
			
			dao.insert(dto);
		%>
	</body>
</html>