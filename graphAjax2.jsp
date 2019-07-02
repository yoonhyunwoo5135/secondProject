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

	ArrayList temp = null;
	long[] playCount = new long[8];

	
	for (int i = 0; i < 8; i++) {
		temp = dao.genre(i); //장르별로 리스트를 만듦
		long n = 0;
		for (int j = 0; j < temp.size(); j++) {
	dto = (ChartDTO) temp.get(j); // 특정장르의 dto를 끌어옴
	long x = Long.parseLong(dto.getCount());
	n = n + x;
		}
		playCount[i] = n;
		String xx = Long.toString(n);
		out.write(xx+"★");
	} // 각 장르별 재생수 누적
%>
