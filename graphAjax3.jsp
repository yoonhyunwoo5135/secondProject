<%@page import="bean.ChartDTO"%><%@page import="bean.ChartDAO"%><%@page
	import="java.io.Console"%><%@page import="bean.MusicDTO"%><%@page
	import="java.util.ArrayList"%><%@page import="bean.MusicDAO"%><%@page
	import="org.jsoup.Jsoup"%><%@page import="org.jsoup.nodes.Document"%><%@page
	import="org.jsoup.nodes.Element"%><%@page
	import="org.jsoup.select.Elements"%><%@page
	import="java.io.IOException"%><%@ page language="java"
	contentType="text/html; charset=UTF8" pageEncoding="UTF8"%>
<%
	ChartDAO dao = new ChartDAO();
	ChartDTO dto = null;
	String[] time = new String[200];
	String[] count = new String[200];

	ArrayList<ChartDTO> list = dao.selectAll();
	for (int i = 0; i < list.size(); i++) {
		dto = list.get(i); // 200개 노래 DTO 각각 가져옴
		time[i] = dto.getArtist();
		count[i] = dto.getCount();
	}
	for (int i = 0; i < 200; i++) {
		out.write(time[i]+",");
	}
	out.write("★");
	for (int i = 0; i < 200; i++) {
		out.write(count[i]+",");
	}
%>
