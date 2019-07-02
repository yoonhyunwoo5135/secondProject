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
		<link rel="stylesheet" type="text/css" href= "style.css">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
		integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
		crossorigin="anonymous">
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
		crossorigin="anonymous"></script>
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<script type="text/javascript">
			$(function(){
				$("#logout").submit(function(){
					$.ajax({
						url:"logout.jsp",
						success:function(){
							alert("로그아웃 되었습니다.");
						}
					});
					return false;
				});
				
			});
			
			function playsong(data) { // 팝업창 띄우는 함수 
				
				var title = $(".title"+data+"> span.title").text();
				var url = "PlaySong.jsp?title="+title;
				window.open(url, "PlaySongnew", "width=500, height=600,");
				
			}
			
			
		</script>
	</head>
	<body>
		
		<%
			String url = "https://www.genie.co.kr/newest/song";
			Document doc = null;
			try {
				doc = Jsoup.connect(url).get();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		%>
		
		<div id = "top">
			<div id="title">
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
		<div id="middle">
			<div id="album">
				
			<table border="10" width="1000" style="font-size: 20px;">
				<tbody border="10">
				<tr id="list">
					<td align="center">IMAGE</td>
					<td align="center" width=300 style="word-break:break-all">TITLE</td>
					
					<td align="center">IMAGE</td>
					<td align="center" width=300 style="word-break:break-all">TITLE</td>
				
				</tr>
				
				<tr class="song-list">
				<%
					Elements element = doc.select("div.newest-list");
					
					String title = null;
					String artist = null;
					int cnt=0;
					ArrayList list = new ArrayList();
					ArrayList list2 = new ArrayList();
					element = doc.select("table.list-wrap");
					// 원하는 내용이 있는 틀(?) 입력
					for(Element name : element.select("tr.list > td.info > a[title]")){ // 노래 이름
						list.add(name.text());
					}
					for(Element name : element.select("tr.list > td.info > a.artist.ellipsis")){ // 가수 이름
						list2.add(name.text());
					}
					
					for(Element songimg : element.select("tr.list > td > a > img")){ // 노래 이미지
						title = (String)list.get(cnt);
						artist = (String)list2.get(cnt);
						cnt++;
				%>
						<td class="newsong"><%= songimg %></td>
						<td class="title<%= cnt %>" style="text-align: center; font-size: 12px; width: 450px;">
							<span style="font-size: 15px;"><%= artist %></span><br>
							<span class="title" style="font-size: 15px;"><%= title %></span>
							<br>
							<br>
							<button type="button" onclick="playsong('<%= cnt %>')" class="btn btn-primary btn-lg">Play▶</button>
						</td>
				<% 
					if(cnt%2 == 0){
				%>
						</tr>
						<tr class="song-list" style="width: 500px;">
				<%
					}
			
					}
				%>
				</tr>
				</tbody>
			<table>
			</div>
		</div>
		<div id = "under" style="position: absolute; top: 2700px; left: 0px;">
				회사소개 | 이용약관 | 개인정보처리방침 | 청소년보호정책 | 이메일주소무단수집거부 | 서비스 이용문의
			<div id = "under2">
			</div>
		</div>
	</body>
</html>