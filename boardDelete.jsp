<%@page import="bean.BoardDAO"%>
<%@page import="bean.BoardDTO"%>
<%@page import="com.sun.xml.internal.bind.v2.runtime.Location"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>boardDelete</title>
   </head>
   <body>

      <%
      BoardDTO dto = new BoardDTO();
      BoardDAO dao = new BoardDAO();
      
         String getNum = request.getParameter("num");
         int num = Integer.parseInt(getNum);
         
         
         dao.delete(num);
         response.sendRedirect("boardList.jsp");
      %>
      
   </body>
</html>