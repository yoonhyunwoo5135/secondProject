<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="bean.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	MemberDAO dao = new MemberDAO();
	String InputId = request.getParameter("id");
	String id = null;
	id = dao.idCheck(InputId);
	String str = null;

	if (id != null) {
		str = "NO";
		out.write(str);
	} else {
		str = "YES";
		out.write(str);
	}
%>