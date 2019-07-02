<%@page import="java.util.ArrayList"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
		<title>음악을 태우다 낙타</title>
		<link rel="stylesheet" type="text/css" href="PlaySong.css">
		
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<script type="text/javascript">
			
		
		</script>
</head>
<body bgcolor="lime">

	<%
		String title = request.getParameter("title");
		String query = null;		
		if(title.contains("TITLE") == true){
			query = title.substring(6);
		}else{
			query = title;
		}
		
		String url = "https://www.genie.co.kr/search/searchMain?query="+query;
		Document doc = null;
		try {
			doc = Jsoup.connect(url).get();
		} catch (IOException e) {
			e.printStackTrace();
		}
		Elements element = doc.select("div.search_song");
	
		for(Element songimg : element.select("tr.list > td > a > img")){ // 노래 이미지	
	%>
	<span class="pimg">
		<%= songimg %>
	</span>
	<div class="ptitle"><%= query %></div>
	
	<audio controls class="mp3">
		<source src="시간의신전.mp3">
	</audio>
	<%
		break;
		}
	%>
	
</body>
</html>