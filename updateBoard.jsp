<%@page import="java.io.Console"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="bean.BoardDTO"%>
<%@page import="bean.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
		<jsp:useBean id="dto" class="bean.BoardDTO"></jsp:useBean>
		<jsp:setProperty property="*" name="dto"/>
		<%
			BoardDAO dao = new BoardDAO();
			// 날짜
			Calendar cal = Calendar.getInstance();
			int year = cal.get(cal.YEAR);
			int month = cal.get(cal.MONTH);
			int day = cal.get(cal.DATE);
			String date=null;
			
			if(month < 10 && day < 10){
	            date = Integer.toString(year) + "0"  + Integer.toString(month) + "0" + Integer.toString(day);
	         }else if(month >= 10 && day >= 10){
	            date = Integer.toString(year) + Integer.toString(month) + Integer.toString(day);
	         }
			// write.jsp에서 값 받아오기
		
			String id = (String)session.getAttribute("InputId");
			
			
			// dto에 넣을 값 세팅
			dto.setId(id);
			dto.setDate(date);
			
			dao.update(dto);
			/* out.write(dto.toString()); */
		%>
