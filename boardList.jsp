<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>게시판</title>
		<link rel="stylesheet" type="text/css" href="style.css">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" 
			integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<script type="text/javascript">
					$(function() {
						$("#logout").submit(function() {
							$.ajax({
								url : "logout.jsp",
								success : function() {
								}
							});
							return false;
						});
						
						$("#write").click(function(){
							location.href= 'write.jsp';
						});
						
						
					});
		</script>
	</head>
	
	<body>
		<div id="top">
			<div id="title">
				<a href="Main.jsp"><img src="images/Title.png"
					style="border-radius: 10px 10px 10px 10px"></a>
			</div>
	
			<div id="search">
				<form action="">
					<input type="text" id="searchbox"
						style="width: 400px; height: 45px;" placeholder="검색어를 입력해주세요.">
					<button type="submit" class="btn btn-primary btn-lg">검색</button>
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
							%> 
							<b><%=session.getAttribute("InputId")%></b>님<br>안녕하세요 :)
	
							<form action="logout.jsp">
								<button type="submit" id="logout" class="btn btn-dark">로그아웃</button>
							</form>
							<%	} else { %>
	
							<form action="login.jsp">
								<button type="submit" id="loginbutton" class="btn btn-outline-info">로그인</button>
							</form> 
							<% } %>
	
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
		<hr class="hr">
	
		<center>
			<article>
				<div class="table-responsive">
				<div class="container">
				<table class="table table-striped table-sm">

				<legend>
					<h4>
						<b>공지사항</b>
					</h4>
				</legend>
			</div>
			<table class="table table-striped table-sm">
				<colgroup>
					<col style="width:5%;" />
					<col style="width:auto;" />
					<col style="width:15%;" />
					<col style="width:20%;" />
					<col style="width:10%;" />
				</colgroup>
				<thead>
					<tr align="center">
						<th>NO</th>
						<th>글제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
			
				<sql:setDataSource 
				   url="jdbc:mysql://127.0.0.1:3306/music"
				   driver="com.mysql.jdbc.Driver"
				   user="root"
				   password="1234"
				   scope="application"
				   var ="db"
				/>
				<sql:query var="list" dataSource="${db}">
					select*from board
				</sql:query>
					<c:forEach var="listM" items="${list.rows}">
						<table class="table table-striped table-sm">
							<colgroup>
								<col style="width:5%;" />
								<col style="width:auto;" />
								<col style="width:15%;" />
								<col style="width:20%;" />
								<col style="width:10%;" />
							</colgroup>
				   			<tr align="center">
				   				<td>${listM.num}</td>
				   				<td id="listT"><a href="boardView.jsp?num=${listM.num}">${listM.title}</a></td>
				   				<td>${listM.id}</td>
				   				<td>${listM.date}</td>
				   				<td>${listM.count}</td>
				   				<input type = "hidden" name = "listN" value = "${listM.num}">
				   			</tr>
				   		</c:forEach>
				   	</table>
				</tbody>
		</table>
		<br>
		</center>
			<% if(userId!=null){ 
			if(userId.equals("admin")){
			%>
			<button style="margin-left: 1400px" type="submit" id="write" class="btn btn-outline-primary">글쓰기</button>
			<% }else{
			}} %>
	
	</body>

</html>