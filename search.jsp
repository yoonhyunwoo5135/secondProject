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
						$(".scheck input").prop("checked", false);
						check = false;
					}else{
						$(".scheck input").prop("checked", true);
						check = true;
					}
				});
			});
			function playsong(data) { // 팝업창 띄우는 함수 
				var title = $(".song-list"+data+"> td.title").text();
				var url = "PlaySong.jsp?title="+title;
				window.open(url, "PlaySong", "width=500, height=600,");
			} 
			function save(number) {
				var num = $('[name='+number+']').is(':checked');
				if(num == true){
					$(".song-list"+data+">")
				}
				
			}
			function saveAll() {
				for (var i = 1; i < 16; i++) {
					
				}
			}
		</script>
	</head>
<body>
		<div class="text"></div>
		<%
			String query = request.getParameter("search");
			String url = "https://www.genie.co.kr/search/searchMain?query="+query;
			Document doc = null;
			try {
				doc = Jsoup.connect(url).get();
			} catch (IOException e) {
				e.printStackTrace();
			}
			Elements element = doc.select("div.search_keyword");
			String check = element.select("p").text();
			
			if(0 < check.length()){//검색값이 이상할경우 보내지는곳
		%>
			<jsp:forward page="null.jsp"></jsp:forward>
		<% 		
			} 
			
			element = doc.select("span.cover-img");
		
			Elements img = element.select("img");//아티스트 이미지
			
		
		%>
		
		
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
						<li><a class="btn btn-primary" href="#">통합검색</a></li>
						<li><a class="btn btn-primary" href="SongSearch.jsp?search=<%= query %>">곡</a></li>
						<li><a class="btn btn-primary" href="AlbumSearch.jsp?search=<%= query %>">앨범</a></li>
						<li><a class="btn btn-primary" href="MagazineSearch.jsp?search=<%= query %>">매거진</a></li>
					</ul>
				</div>
			
			<hr class="hr">
			<%
				if(img.isEmpty() == false && query.equals("알라딘") == false){//이미지가 없으면 프로필 출력x
			%>	
			<div id="profile">
				<%= img.toString() %>
				<span style="position: absolute;">
					<ul type="none">
						<li style="font-size: 20px;">${param.search}</li>
					<% 
						element = doc.select("div.info-zone");// 프로필
						
						for(Element el : element.select("li")){
							String profile = el.toString();
					%>
						<li><%= profile %></li>
					<% 
						}
					%>
					</ul>
				</span>
			</div>
			<hr class="hr" color="blue">
			
			<%
				}
			%>
			<!---------------------------------------------------------------------------------------------------------->
			
			곡 전체선택<input type="checkbox" id="selectAll">
			<a href="#" onclick="saveAll();" return false;>
				<img src="images/save.PNG" style="width: 50px; height: 30px;">
			</a>
			<table border="2" width="700">
				
				<% 
					String title = null;
					int cnt=0;
					ArrayList list = new ArrayList();
					element = doc.select("div.search_song");
					// 원하는 내용이 있는 틀(?) 입력
					for(Element name : element.select("tr.list > td.info > a[title]")){ // 노래 이름
						list.add(name.text());
					}
					
					for(Element songimg : element.select("tr.list > td > a > img")){ // 노래 이미지
						
						title = (String)list.get(cnt);
						cnt++;
				%>
				<tr class="song-list<%= cnt %>">
					<td class="scheck" width="60"><input type="checkbox" name="<%= cnt %>"></td>
					<td class="number" style="text-align: center;"><%= cnt %></td>
					<td class="simg" style="width: 65px;"><%= songimg %></td>
					<td class="title" style="text-align: center;">
						<%= title %><br>
						<a href="#" return false;>
							<img src="images/listen.PNG" 
							style="width: 50px; height: 30px;"
							onclick="playsong('<%= cnt %>');">
						</a>
						<a href="#" onclick="save('<%= cnt %>');" return false;>
							<img src="images/save.PNG" style="width: 50px; height: 30px;">
						</a>
					
					</td>
				</tr>
				<% 
					}
				%>
			</table>
			</form>
			
			<hr class="hr" color="blue">
			<h2>앨범</h2>
			<table border="2" style="width: 700px; height: 500px; position: absolute;">
				<tr id="album-list">
				<% 
					String url2 = "https://www.genie.co.kr/search/searchAlbum?query="+query;
					doc = null;
					try {
						doc = Jsoup.connect(url2).get();
					} catch (IOException e) {
						e.printStackTrace();
					}
					
					String[] Atitle = {null,null,null};
					int count=0;
					ArrayList list1 = new ArrayList();
					ArrayList list2 = new ArrayList();
					ArrayList list3 = new ArrayList();
					element = doc.select("div.search_album");
					
					for(Element t1 : element.select("dl.album-info > dt.ellipsis > a")){ // 제목
						list1.add(t1.text());
					}
					for(Element t1 : element.select("dl.album-info > dd.ellipsis > a")){ // 제목
						list2.add(t1.text());
					}
					for(Element t1 : element.select("dl.album-info > dd.desc")){ // 제목
						list3.add(t1.text());
					}
					
					for(Element albumimg : element.select("li.list-album > a > img")){ // 앨범 이미지
						
						Atitle[0] = (String)list1.get(count);
						Atitle[1] = (String)list2.get(count);
						Atitle[2] = (String)list3.get(count);
						count++;
						if(count < 7){
				%>
				
					<td class="albumpage"><%= albumimg %></td>
					<td style="text-align: center; font-size: 12px; width: 210px;">
						<span><%= Atitle[0] %></span><br>
						<span><%= Atitle[1] %></span><br>
						<span><%= Atitle[2] %></span>
					</td>
				
				<% 
							if(count%2 == 0){
				%>
						</tr>
						<tr id="album-list">
				<%
							}
						}
					}
				%>
				</tr>
			</table>
			
			
			<!---------------------------------------------------------------------------------------------------------->
			
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
		
		<!-- <div id = "under">
			<a href = "">회사소개</a> | <a href ="">이용약관</a> | <a href="">개인정보처리방침</a> | <a href = "">청소년보호정책</a> | 이메일주소무단수집거부 | 서비스 이용문의
		<div id = "under2">
		</div> -->
		
</body>
</html>