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
		<link rel="stylesheet" type="text/css" href= "style2.css">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
		integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
		crossorigin="anonymous">
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
		crossorigin="anonymous"></script>
	</head>
<body>

		<div id = "top">
				<div id="title" style="margin-left: 0px">
			<a href="Main.jsp"><img src="images/Title.png"
				style="border-radius: 10px 10px 10px 10px"></a>
		</div>
			
			<div id = "search">
				<form action="search.jsp">
					<input type="text" id = "searchbox" style = "width: 400px; height: 45px;" placeholder="검색어를 입력해주세요."name="search" >
					<button type="submit" class="btn btn-primary btn-lg" return false;>검색</button>
					
				</form>
			</div>
			
			<div id="login">
			<table>
				<tr>
					<td><img src="images/Camel.png"></td>
					<td width="150px">
						<%
							Object userId = session.getAttribute("InputId");
							if (userId != null) {
						%> <b><%=session.getAttribute("InputId")%></b>님<br>안녕하세요 :)

						<form action="logout.jsp">
							<button type="submit" id="logout" class="btn btn-dark">로그아웃</button>
						</form> <%
 	} else {
 %>
						<form action="login.jsp">
							<button type="submit" id="loginbutton" class="btn btn-info">로그인</button>
						</form> <%
 	}
 %>
					</td>
				</tr>
			</table>
		</div>
		</div>
			<div id="menu">
		<table>
			<ul>
				<li class="menuselect"><a href="rank.jsp">음원차트</a>
				<li class="menuselect"><a href="newmusic.jsp">최신음악</a>
				<li class="menuselect"><a href="MagazineSearch.jsp">뉴스토픽</a>
				<li class="menuselect"><a href="graph.jsp">시각화</a>
				<li class="menuselect"><a href="boardList.jsp">공지사항</a>
			</ul>
		</table>
	</div>
		<hr class = "hr">
		<div id = "middle">
			<div id = "album">
			
			
			<table border="4" style="width: 700px; height: 200px;"><!-- 검색 결과가 없을때 쓰는 jsp forwerd 사용했어요 -->
				<tr>
					<td style="text-align: center;">
						<span style=" font-size: 20px; color: blue;">"${param.search}"</span>
						<span style="font-size: 20px;">에 대한 검색 결과가 없습니다.</span>
					</td>
				</tr>
			</table>
		
			
			
			
			</div>
			
			<div id = "hotsearch">
				<h5>인기 검색어</h5>
				<br>
				<ol>
					<% 
						String rank = null;
						String url = "https://www.genie.co.kr/search/searchMain?query=";
						Document doc = null;
						try {
							doc = Jsoup.connect(url).get();
						} catch (IOException e) {
							e.printStackTrace();
						}
						Elements element = doc.select("div.aside_realtime");//인기 검색어
						
						for(Element el : element.select("li > a")){
							rank = el.text();
							
					%>
						<li><a href="지니.jsp?search=<%= rank %>"><%= rank %></a></li>
					<% 
						}
					%>
				</ol>
			</div>
		</div>
		<div id = "under">
			<a href = "">회사소개</a> | <a href ="">이용약관</a> | <a href="">개인정보처리방침</a> | <a href = "">청소년보호정책</a> | 이메일주소무단수집거부 | 서비스 이용문의
		<div id = "under2">
		</div>
		
</body>
</html>