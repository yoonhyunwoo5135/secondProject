<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board</title>
<link rel="stylesheet" type="text/css" href="boardstyle.css">
<link rel="stylesheet" type="text/css" href="style.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		//목록 버튼 이벤트
		$("#btnList").click(function() {
			location.href = 'boardList.jsp';
		});
	});
	function board_del(data){
        var result = confirm("삭제하시겠습니까?");
        if(result){
           location.href = 'boardDelete.jsp?num='+ data;
        }
     }
	
</script>

</head>

<body>
	<jsp:useBean id="dto" class="bean.BoardDTO"></jsp:useBean>
	<jsp:useBean id="dao" class="bean.BoardDAO"></jsp:useBean>
	<%
		String getNum = request.getParameter("num");
		int num = Integer.parseInt(getNum);
		
		String upnum = request.getParameter("listN");
		dto = dao.readCnt(num);
	%>

<body>
	<div id="top">
		<div id="title">
			<a href="Main.jsp"><img src="images/Title.png"
				style="border-radius: 10px 10px 10px 10px"></a>
		</div>
		<div id="search">
			<form action="search.jsp">
				<input type="text" id="searchbox"
					style="width: 400px; height: 45px;" placeholder="검색어를 입력해주세요."
					name="search">
				<button type="submit" class="btn btn-primary btn-lg">검색</button>
			</form>
		</div>


		<div id="login">
			<table>
				<tr>
					<td><img src="images/Camel.png"></td>
					<td width="150px">
						<%
							String userId = (String) session.getAttribute("InputId");
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
	<hr class="hr">
	<center>
		<article>
			<div class="table-responsive">
				<div class="container" style="position:absolute; left: 500px;">
					<table class="table table-striped table-sm">

						<legend>
							<h4>
								<b>공지사항</b>
							</h4>
						</legend>
						</div>
						<form id="form">
						
						<table class="table table-striped table-sm">
							<colgroup>
								<col style="width: 10%;" />
								<col style="width: auto;" />
							</colgroup>
							<thead>
								<tr>
									<th class="sub1">NO.<%=dto.getNum()%>
									</th>
									<input type="hidden" value=<%=dto.getNum()%> id="boardNum">
									<th class="sub2" id="title2"><%=dto.getTitle()%></th>
								</tr>
								<tr>
									<th class="sub1">작성일</th>
									<th class="sub2"><%=dto.getDate()%></th>
								</tr>
								<tr>
									<th class="sub1">작성자</th>
									<th class="sub2"><%=dto.getId()%></th>
								</tr>
								<tr>
									<th class="sub1">조회수</th>
									<th align="left" style="color: red"><%=dto.getCount()%></th>
								</tr>
								<tr>
									<th class="sub1">글 내용</th>
									<th></th>
								</tr>
								<table align="left">
									<tr>
										<th id="content"><%=dto.getContent()%></th>
									</tr>
								</table>
							</thead>
						</table>
						</form>
						</article>
						</center>
						<br>
						<br>
						<div id="btn1">
							<input type="hidden" value="기본값" id="aaaa">
							<%
								if (userId != null) {
									if (userId.equals("admin")) {
							%>
							<div style="margin-top: 400px; float: left; width: 200px;">
								<button type="button" id="btnUp" class="btn btn-primary btn-sm"
									onclick="location.href = 'boardUpdate.jsp?num=<%=dto.getNum()%>'">수정</button>
								<button type="button" id="btnDel" class="btn btn-primary btn-sm"  onClick="board_del('<%= num %>')">삭제</button>
								<button type="button" id="btnList"
									class="btn btn-primary btn-sm">목록</button>
							</div>
							<%
								} else {
							%>
							<div>
								<button type="button" id="btnList"
									class="btn btn-primary btn-sm">목록</button>
							</div>
							<%
								}
								} else {
							%>
							<div>
								<button type="button" id="btnList"
									class="btn btn-primary btn-sm">목록</button>
							</div>
							<%
								}
							%>
						</div>
</body>

</html>


