<%@page import="bean.MusicDTO"%>
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
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<script type="text/javascript">
			$(function() {
				var check = false;
				$("#selectAll").change(function() {
					if(check == true){
						$("#song-list input").attr("checked", false);
						check = false;
					}else{
						$("#song-list input").attr("checked", true);
						check = true;
					}
				});
			});
			function playsong(data) { // 팝업창 띄우는 함수 
				var title = $(".song-list"+data+"> td.title").text();
				var url = "PlaySong.jsp?title="+title;
				window.open(url, "PlaySong", "width=500, height=600,");
			} 
			function save(title,songimg) {
				
			}
		</script>
	</head>
<body>
		<%
			String query = request.getParameter("search");
			String url = "https://www.genie.co.kr/search/searchSong?query="+query;
			Document doc = null;
			try {
				doc = Jsoup.connect(url).get();
			} catch (IOException e) {
				e.printStackTrace();
			}
		
		%>
		<div id = "top">
			<div id="title" style="margin-left: 0px">
			<a href="Main.jsp"><img src="images/Title.png"
				style="border-radius: 10px 10px 10px 10px"></a>
		</div>
			
			<div id = "search">
				<form action="search.jsp">
					<input type="text" id = "searchbox" style = "width: 400px; height: 45px;" placeholder="검색어를 입력해주세요." name="search">
					<button type="submit" class="btn btn-primary btn-lg">검색</button>
				</form>
			</div>
			
			<div id = "login">
				<table>
					<tr>
						<td>
							<img src = "images/Camel.png">
						</td>
						<td width="150px">
							<%
								Object userId = session.getAttribute("InputId");
								if(userId != null){
							%>
							<b><%=session.getAttribute("InputId") %></b>님<br>안녕하세요 :)
							
							<form action="logout.jsp">
								<button type="submit" id="logout" class="btn btn-dark">로그아웃</button>
							</form>
							
							<%}else{%>
							<form action="login.jsp">
								<button type="submit" id = "loginbutton" class="btn btn-info">로그인</button>
							</form>
							<%} %>
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
			<h2>검색 결과</h2>
				<div id="current">
					<ul>
						<li><a class="btn btn-primary" href="search.jsp?search=<%= query %>">통합검색</a></li>
						<li><a class="btn btn-primary" href="#">곡</a></li>
						<li><a class="btn btn-primary" href="AlbumSearch.jsp?search=<%= query %>">앨범</a></li>
						<li><a class="btn btn-primary" href="MagazineSearch.jsp?search=<%= query %>">매거진</a></li>
					</ul>
				</div>
			
			<hr class="hr">
			
			곡 전체선택<input type="checkbox" id="selectAll">
			<form action="" id="form">
			<button type="submit"><img src="images/save.PNG"></button>
			<table border="2" width="700">
				
				<% 
					String title = null;
					int cnt=0;
					ArrayList list = new ArrayList();
					Elements element = doc.select("div.search_song");
					// 원하는 내용이 있는 틀(?) 입력
					for(Element name : element.select("tr.list > td.info > a[title]")){ // 노래 이름
						list.add(name.text());
					}
					
					for(Element songimg : element.select("tr.list > td > a > img")){ // 노래 이미지
						
						title = (String)list.get(cnt);
						cnt++;
				%>
				<tr class="song-list<%= cnt %>" >
					<td width="60"><input type="checkbox"></td>
					<td class="number" style="text-align: center;"><%= cnt %></td>
					<td class="simg" style="width: 65px;"><%= songimg %></td>
					<td class="title" style="text-align: center;">
						<%= title %><br>
						<a href="#" return false;>
							<img src="images/listen.PNG" 
							style="width: 50px; height: 30px;"
							onclick="playsong('<%= cnt %>');">
						</a>
						<a href="" onclick="save(title,songimg);" return false;>
							<img src="images/save.PNG" style="width: 50px; height: 30px;">
						</a>
					
					</td>
				</tr>
				<% 
					}
				%>
			</table>
			</form>
				
			</div>
			
			<div id="chart">
			<table>
				<tr>인기검색어
				</tr>
				<!-- 인기검색어 가져오기 -->
				<hr>
				<%
					MusicDTO dto = new MusicDTO();
					String url1 = "https://www.genie.co.kr/chart/top200";
					doc = null;
					try {
						doc = Jsoup.connect(url1).get();
					} catch (IOException e) {
						e.printStackTrace();
					}
					element = doc.select("div.aside_realtime"); //검색어 틀
					// 원하는 내용이 있는 틀(?) 입력
					int n = 1;
					for (Element y : element.select("a")) { // 검색어
						String word = y.text();
				%>
				<tr>
					<td><%=n + "위 "%> <a href="search.jsp?search=<%=word%>"><%=word%></a></td>
				</tr>
				<%
					n++;
					}
				%>
			</table>
		</div>
		</div>
		
		<div id="bottom">
			
		</div>
		<!-- <div id = "under">
			<a href = "">회사소개</a> | <a href ="">이용약관</a> | <a href="">개인정보처리방침</a> | <a href = "">청소년보호정책</a> | 이메일주소무단수집거부 | 서비스 이용문의
		<div id = "under2">
		</div> -->
	</body>
</html>