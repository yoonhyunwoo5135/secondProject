<%@page import="java.io.Console"%>
<%@page import="bean.MusicDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.MusicDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF8"
	pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>음악을 태우다 낙타</title>
<link rel="stylesheet" type="text/css" href="style.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
</head>
<body>
	<div id="top">
		<div>
			<a href="Main.jsp"><img src="images/Title.png"
				style="border-radius: 10px 10px 10px 10px"></a>
		</div>
		<br>
		<!---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->

		<br>
		<div style="border: 10px;">
			<table>
				<tr>
					<td>
						<%
							// rank.jsp에서 넘어온 숫자(노래번호)로 크롤링 된 내용 중 맞는 사진을 찾음
							int num = Integer.parseInt(request.getParameter("mnum"));
							String title = request.getParameter("title");
							String artist = request.getParameter("artist");
							// 받아온 번호(문자)를 숫자(num)로 변환 (1~50)

							MusicDAO dao = new MusicDAO();
							String[] cover1 = dao.image(); /* 앨범사진 URL을 배열로 만듦 */
						%> <img alt="이미지 없음" src="<%=cover1[num]%>">
					</td>
					<td align="left" style="border: 10px;"><a href=""><%=title%></a><br>
						<a href=""><%=artist%></a><br> <br> <audio controls
							id="player">
							<source src="audio/<%=num%>.mp3" type="audio/mpeg">
						</audio> <!-- rank.jsp 에서 넘어온 숫자(노래순번)으로 50곡중 노래재생 --></td>
				</tr>
			</table>
		</div>

		<div id="recent">
			<!-- 세션(음악번호: numList / 제목: titleList -->
			최근 재생한 음악 :
			<%
				ArrayList<Integer> numList = (ArrayList<Integer>) session.getAttribute("mnum");
				ArrayList<String> titleList = (ArrayList<String>) session.getAttribute("title");
				ArrayList<String> artistList = (ArrayList<String>) session.getAttribute("artist");

				if (numList == null) {

				} else if (numList.size() == 1) { //세션에 저장된 내용이 한 개 이하일 때
			%><br>
			<table width="500">
				<tbody>

					<td><a class="btn btn-primary"
						href="player.jsp?mnum=<%=numList.get(0)%>&title=<%=titleList.get(0)%>&artist=<%=artistList.get(0)%>" target="_blank"><%=artistList.get(0)%> / <%=titleList.get(0)%></a></td>

					<%
						} else { // 두 개 이상일 때
							for (int i = 1; i < numList.size(); i++) {
					%>
					<br>
					<td><a class="btn btn-primary"
						href="player.jsp?mnum=<%=numList.get(numList.size() - i)%> &title=<%=titleList.get(titleList.size() - i)%> &artist=<%=artistList.get(artistList.size() - i)%>" target="_blank"><%=artistList.get(artistList.size() - i)%> / <%=titleList.get(titleList.size() - i)%></a>
					</td>
					<%
						}
						}
					%>
				</tbody>
			</table>
		</div>
		<%
			// 최근 들은 음악의 번호를 Arraylist 에 추가
			numList = (ArrayList<Integer>) session.getAttribute("mnum"); // 세션에 저장된 최근 음악번호 가져옴

			if (numList == null) { // 목록이 있으면 추가, 없으면 새로 만들어서 추가
				numList = new ArrayList<>();
				numList.add(num);
				session.setAttribute("mnum", numList); //넘어온 노래의 순번을 세션에 추가
			} else {
				numList.add(num);
				session.setAttribute("mnum", numList); //넘어온 노래의 순번을 세션에 추가
			}
		%>

		<%
			titleList = (ArrayList<String>) session.getAttribute("title"); // 세션에 저장된 최근 음악제목 가져옴
			ArrayList mlist = dao.selectAll(); // 저장된 50곡 정보가져옴
			MusicDTO dto1 = (MusicDTO) mlist.get(num); // 해당하는 번호의 노래정보 DTO

			if (titleList == null) { // 목록이 있으면 추가, 없으면 새로 만들어서 추가
				titleList = new ArrayList<>();
				titleList.add(dto1.getTitle());
				session.setAttribute("title", titleList);
			} else {
				titleList.add(dto1.getTitle());
				session.setAttribute("title", titleList);
			}
		%>

		<%
			artistList = (ArrayList<String>) session.getAttribute("artist"); // 세션에 저장된 최근 음악제목 가져옴
			ArrayList alist = dao.selectAll(); // 저장된 50곡 정보가져옴
			MusicDTO dto2 = (MusicDTO) alist.get(num); // 해당하는 번호의 노래정보 DTO

			if (artistList == null) { // 목록이 있으면 추가, 없으면 새로 만들어서 추가
				artistList = new ArrayList<>();
				artistList.add(dto2.getArtist());
				session.setAttribute("artist", artistList);
			} else {
				artistList.add(dto2.getArtist());
				session.setAttribute("artist", artistList);
			}
		%>

		<!---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->