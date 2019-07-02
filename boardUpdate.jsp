<%@page import="bean.BoardUpdateDTO"%>
<%@page import="bean.BoardDTO"%>
<%@page import="bean.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
    String ctx = request.getContextPath();    //콘텍스트명 얻어오기.
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>게시판 글쓰기</title>
		<link rel="stylesheet" type="text/css" href="style.css">
		<link rel="stylesheet"
			href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
			integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
			crossorigin="anonymous">
		<script
			src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
			integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
			crossorigin="anonymous"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<script type="text/javascript">
			
		
			$(function() { // 입력된 값들을 모두 넘김
				$("#submit").click(function() {
					var elClickedObj = $("#form");
			        oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
					var content = $("#content").val();
					var title = $("#temp").val();
					
					$.ajax({
						type:"get",
						url : "updateBoard.jsp",
						data : {
							"content":content,
							"title":title
						},
						success : function(result) {
							alert("게시글 수정 완료");
							location.href = 'boardList.jsp';
						}
					});
				});
			});
		</script>
		
		<script type="text/javascript" src="<%=ctx %>/SE2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<!-- jQuery를 사용하기위해 jQuery라이브러리 추가 -->
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.0.min.js"></script>

<script type="text/javascript">
var oEditors = [];
$(function(){
      nhn.husky.EZCreator.createInIFrame({
          oAppRef: oEditors,
          elPlaceHolder: "content", //textarea에서 지정한 id와 일치해야 합니다. 
          //SmartEditor2Skin.html 파일이 존재하는 경로
          sSkinURI: "/project1/SE2/SmartEditor2Skin.html",  
          htParams : {
              // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseToolbar : true,
              // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseVerticalResizer : true,     
              // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
              bUseModeChanger : true,         
              fOnBeforeUnload : function(){
              }
          }, 
          fOnAppLoad : function(){
              //기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
              oEditors.getById["content"].exec("PASTE_HTML", [""]);
          },
          fCreator: "createSEditor2"
      });

});
 
</script>
		</head>
<body>
<%
String num1 = request.getParameter("num"); // 숫자만 String 값으로 가져옴
String num2 = num1.replaceAll(" ", "");
out.write(num2); // 44 까지 출력 됨

int num=Integer.parseInt(num2);
String upnum2 = request.getParameter("upnum");
BoardUpdateDTO dto2 = new BoardUpdateDTO();
dto2.setNum1(upnum2);

BoardDAO dao = new BoardDAO();
BoardDTO dto = new BoardDTO();

dto = dao.select2(num);
%>
	<div id = "top">
			<div id="title" style="margin-left: 0px">
			<a href="Main.jsp"><img src="images/Title.png"
				style="border-radius: 10px 10px 10px 10px"></a>
		</div>
			
			<div id = "search">
				<form action="">
					<input type="text" id = "searchbox" style = "width: 400px; height: 45px;" placeholder="검색어를 입력해주세요.">
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
							<input type="hidden" value=<%=session.getAttribute("InputId")%> name="InputId">
							
							<form action="logout.jsp">
								<button type="submit" id="logout" class="btn btn-dark">로그아웃</button>r
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
	<hr class="hr">
<!------------------------------------------------------------------------------------------------------------------------------------------------------------->
	<div id="board" style="position: absolute; left: 475px; width: 900px; height: 800px;">
			<form id="form" name="form" method="POST">
				<table width="800px" height="30px" cellpadding="0" cellspacing="0" border="0">
					<tr style="background: url('img/table_mid.gif')"repeat-x; text-align:center;>
						<td width="5"><img src="img/table_left.gif" width="5"
							height="30"></td>
						<td align="center">글쓰기</td>
						<td width="5"><img src="img/table_right.gif" width="5"
							height="30"></td>
					</tr>
				</table>

				<table width="100%">
        <tr>
            <td>제목</td>
           <td><input type="text" id="temp" style="left:92px; height:27px; width:650px; margin-top: -5px;" value=<%=dto.getTitle()%>></td>
        </tr>
        <tr>
            <td>내용</td>
            <td>
               <textarea rows="10" cols="30" id="content" name="content" style="width:650px; height:350px; margin-top: 50px;"><%=dto.getContent() %></textarea>
            </td>
        </tr>
</table>
			<button type="button" id="submit" class="btn btn-warning" style="margin-left:330px;">게시글 등록</button>
			<button type="button" class="btn btn-danger" OnClick="javascript:history.back(-1)">취소</button>
		</form>

	</div>
<!------------------------------------------------------------------------------------------------------------------------------------------------------------->
</body>
</html>