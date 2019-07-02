<%@page import="bean.ChartDTO"%>
<%@page import="bean.ChartDAO"%>
<%@page import="java.io.Console"%>
<%@page import="bean.MusicDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.MusicDAO"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="java.io.IOException"%>

<%@ page language="java" contentType="text/html; charset=UTF8"
	pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>음악을 태우다 낙타</title>
<link rel="stylesheet" type="text/css" href="style.css">
<link rel="stylesheet" type="text/css" href="jung.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<style> /* 로딩 CSS */
#loading {
	height: 100%;
	left: 0px;
	position: fixed;
	_position: absolute;
	top: 0px;
	width: 100%;
	filter: alpha(opacity = 50);
	-moz-opacity: 0.5;
	opacity: 0.5;
}

.loading {
	background-color: white;
	z-index: 199;
}

#loading_img {
	position: absolute;
	top: 50%;
	left: 50%;
	margin-top: -75px; //
	이미지크기 margin-left: -75px; //
	이미지크기 z-index: 200;
}
</style>

<script type="text/javascript"> // 장르별 갯수, 장르별 재생횟수, 길이별 재생횟수 3개AJAX + 로딩
	$(document)
			.ready(
					function() {
						var loading = $(
								'<img id="loading_img" alt="loading" src="images/loading3.gif" max-width: 100%; height: auto;>')
								.appendTo(document.body).hide();
						$(window).ajaxStart(function() {
							loading.show();
						}).ajaxStop(function() {
							loading.hide();
						});
					});

	$(function() { // 입력된 값들을 모두 넘김
		$.ajax({ // 장르별 갯수
			url : "graphAjax1.jsp",
			dataType : "text",
			success : function(result) {
				var x = $.trim(result); // ajax로 넘어온 값을 문자열로 저장
				var s = []; // 배열선언
				var popCount = [];
				var genreCount = [];
				s = x.split(","); // ,로 구분하여 배열로 만듦
				for (i = 0; i < 2; i++) { // 앞 2개 값들을 가요/POP 배열로 넣음
					popCount[i] = parseInt(s[i]);
				}
				for (i = 2; i < 10; i++) { // 그 다음 값들을 장르별 배열로 넣음
					genreCount[i] = parseInt(s[i]);
				}
				$("#word01").val(popCount[0]);
				$("#word02").val(popCount[1]);
				$("#word03").val(genreCount[0]);
				$("#word04").val(genreCount[1]);
				$("#word05").val(genreCount[2]);
				$("#word06").val(genreCount[3]);
				$("#word07").val(genreCount[4]);
				$("#word08").val(genreCount[5]);
				$("#word09").val(genreCount[6]);
				$("#word10").val(genreCount[7]);
				$.ajax({ // 장르별 재생수
					url : "graphAjax2.jsp",
					success : function(result) {
						var x = $.trim(result);
						var s = [];
						s = x.split("★"); 
						$("#playCount01").val(s[0]);
						$("#playCount02").val(s[1]);
						$("#playCount03").val(s[2]);
						$("#playCount04").val(s[3]);
						$("#playCount05").val(s[4]);
						$("#playCount06").val(s[5]);
						$("#playCount07").val(s[6]);
						$("#playCount08").val(s[7]);
						$.ajax({ // 노래길이별 재생횟수
							url : "graphAjax3.jsp",
							success : function(result) {
								var x = $.trim(result);
								var s = []; // 2개로 나뉘는 배열
								s = x.split("★"); 
								$("#timeCount01").val(s[0]);
								$("#timeCount02").val(s[1]);
								
								alert("ajax 완료 / 버튼을 눌러 그래프를 확인하세요"); /* 나중에 지울 것 ------------------*/
							}
						});
					}
				});
			}
		});

	});
</script>

<script type="text/javascript">//장르별 점유율 원그래프 실행 스크립트
	
	google.charts.load('current', {
		'packages' : [ 'corechart' ]
	});
	google.charts.setOnLoadCallback(drawChart);

	function drawChart() { //장르별 점유율 그래프 그리기 시작
		$("#genreBtn").click(
				function() {
			    	$("#chart_div").hide();
			    	$("#top_x_div").hide();
					$("#piechart").show();
					var data = google.visualization.arrayToDataTable([
							[ 'Task', 'Hours per Day' ],
							[ '발라드', parseInt.$("#word03").val() ],
							[ '힙합', parseInt.$("#word04").val() ],
							[ 'OST', parseInt($("#word05").val()) ],
							[ '댄스', parseInt($("#word06").val()) ],
							[ '블루스 ', parseInt($("#word07").val()) ],
							[ '일렉트로닉 ', parseInt($("#word08").val()) ],
							[ '인디 ', parseInt($("#word09").val()) ],
							[ '락 ', parseInt($("#word10").val()) ] 
							]);

					var options = {
						title : '장르별 점유율'
					};

					var chart = new google.visualization.PieChart(document
							.getElementById('piechart'));

					chart.draw(data, options);
				});

	}
</script>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['bar']});
      google.charts.setOnLoadCallback(drawStuff);
      function drawStuff() {
    		$("#countBtn").click(
      function () {
    	  $("#piechart").hide();
    	  $("#chart_div").hide();
    	  $("#top_x_div").show();
    		   var data = new google.visualization.arrayToDataTable([
    			[ '발라드', $("#playCount01").val()],
   				[ '힙합', $("#playCount02").val()],
   				[ 'OST', $("#playCount03").val()],
   				[ '댄스', $("#playCount04").val()],
   				[ '블루스 ', $("#playCount05").val()],
   				[ '일렉트로닉 ', $("#playCount06").val()],
   				[ '인디 ', $("#playCount07").val()],
   				[ '락 ', $("#playCount08").val()],
    		        ]);

    		        var options = {
    		          title: '장르별 재생횟수',
    		          width: 900,
    		          legend: { position: 'none' },
    		          chart: { title: '',
    		                   subtitle: '' },
    		          bars: 'horizontal', // Required for Material Bar Charts.
    		          axes: {
    		            x: {
    		              0: { side: 'top', label: '재생횟수'} // Top x-axis.
    		            }
    		          },
    		          bar: { groupWidth: "90%" }
    		        };

    		        var chart = new google.charts.Bar(document.getElementById('top_x_div'));
    		        chart.draw(data, options);	   
       }
    				)
    	}
    </script>
    
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
    	  $("#timeBtn").click(
    			  function () {
  			    	$("#top_x_div").hide();
  					$("#piechart").hide();
    				  $("#chart_div").show();
    		    	  var x1 = $("#timeCount01").val();
    		    	  var time = x1.split(","); // ,를 기준으로 잘라서 배열만듦
    		    	  var x2 = $("#timeCount02").val();
    		    	  var count = x2.split(","); // ,를 기준으로 잘라서 배열만듦
    			        var data = google.visualization.arrayToDataTable([
    			          ['노래길이', '재생횟수'],
    			          [ parseInt(time[0]), parseInt(count[0])],
    			          [ parseInt(time[1]), parseInt(count[1])],
    			          [ parseInt(time[2]), parseInt(count[2])],
    			          [ parseInt(time[3]), parseInt(count[3])],
    			          [ parseInt(time[4]), parseInt(count[4])],
    			          [ parseInt(time[5]), parseInt(count[5])],
    			          [ parseInt(time[6]), parseInt(count[6])],
    			          [ parseInt(time[7]), parseInt(count[7])],
    			          [ parseInt(time[8]), parseInt(count[8])],
    			          [ parseInt(time[9]), parseInt(count[9])],
    			          [ parseInt(time[10]), parseInt(count[10])],
    			          [ parseInt(time[11]), parseInt(count[11])],
    			          [ parseInt(time[12]), parseInt(count[12])],
    			          [ parseInt(time[13]), parseInt(count[13])],
    			          [ parseInt(time[14]), parseInt(count[14])],
    			          [ parseInt(time[15]), parseInt(count[15])],
    			          [ parseInt(time[16]), parseInt(count[16])],
    			          [ parseInt(time[17]), parseInt(count[17])],
    			          [ parseInt(time[18]), parseInt(count[18])],
    			          [ parseInt(time[19]), parseInt(count[19])],
    			          [ parseInt(time[20]), parseInt(count[20])],
    			          [ parseInt(time[21]), parseInt(count[21])],
    			          [ parseInt(time[22]), parseInt(count[22])],
    			          [ parseInt(time[23]), parseInt(count[23])],
    			          [ parseInt(time[24]), parseInt(count[24])],
    			          [ parseInt(time[25]), parseInt(count[25])],
    			          [ parseInt(time[26]), parseInt(count[26])],
    			          [ parseInt(time[27]), parseInt(count[27])],
    			          [ parseInt(time[28]), parseInt(count[28])],
    			          [ parseInt(time[29]), parseInt(count[29])],
    			          [ parseInt(time[30]), parseInt(count[30])],
    			          [ parseInt(time[31]), parseInt(count[31])],
    			          [ parseInt(time[32]), parseInt(count[32])],
    			          [ parseInt(time[33]), parseInt(count[33])],
    			          [ parseInt(time[34]), parseInt(count[34])],
    			          [ parseInt(time[35]), parseInt(count[35])],
    			          [ parseInt(time[36]), parseInt(count[36])],
    			          [ parseInt(time[37]), parseInt(count[37])],
    			          [ parseInt(time[38]), parseInt(count[38])],
    			          [ parseInt(time[39]), parseInt(count[39])],
    			          [ parseInt(time[40]), parseInt(count[40])],
    			          [ parseInt(time[41]), parseInt(count[41])],
    			          [ parseInt(time[42]), parseInt(count[42])],
    			          [ parseInt(time[43]), parseInt(count[43])],
    			          [ parseInt(time[44]), parseInt(count[44])],
    			          [ parseInt(time[45]), parseInt(count[45])],
    			          [ parseInt(time[46]), parseInt(count[46])],
    			          [ parseInt(time[47]), parseInt(count[47])],
    			          [ parseInt(time[48]), parseInt(count[48])],
    			          [ parseInt(time[49]), parseInt(count[49])],
    			          [ parseInt(time[50]), parseInt(count[50])],
    			          [ parseInt(time[51]), parseInt(count[51])],
    			          [ parseInt(time[52]), parseInt(count[52])],
    			          [ parseInt(time[53]), parseInt(count[53])],
    			          [ parseInt(time[54]), parseInt(count[54])],
    			          [ parseInt(time[55]), parseInt(count[55])],
    			          [ parseInt(time[56]), parseInt(count[56])],
    			          [ parseInt(time[57]), parseInt(count[57])],
    			          [ parseInt(time[58]), parseInt(count[58])],
    			          [ parseInt(time[59]), parseInt(count[59])],
    			          [ parseInt(time[60]), parseInt(count[60])],
    			          [ parseInt(time[61]), parseInt(count[61])],
    			          [ parseInt(time[62]), parseInt(count[62])],
    			          [ parseInt(time[63]), parseInt(count[63])],
    			          [ parseInt(time[64]), parseInt(count[64])],
    			          [ parseInt(time[65]), parseInt(count[65])],
    			          [ parseInt(time[66]), parseInt(count[66])],
    			          [ parseInt(time[67]), parseInt(count[67])],
    			          [ parseInt(time[68]), parseInt(count[68])],
    			          [ parseInt(time[69]), parseInt(count[69])],
    			          [ parseInt(time[70]), parseInt(count[70])],
    			          [ parseInt(time[71]), parseInt(count[71])],
    			          [ parseInt(time[72]), parseInt(count[72])],
    			          [ parseInt(time[73]), parseInt(count[73])],
    			          [ parseInt(time[74]), parseInt(count[74])],
    			          [ parseInt(time[75]), parseInt(count[75])],
    			          [ parseInt(time[76]), parseInt(count[76])],
    			          [ parseInt(time[77]), parseInt(count[77])],
    			          [ parseInt(time[78]), parseInt(count[78])],
    			          [ parseInt(time[79]), parseInt(count[79])],
    			          [ parseInt(time[80]), parseInt(count[80])],
    			          [ parseInt(time[81]), parseInt(count[81])],
    			          [ parseInt(time[82]), parseInt(count[82])],
    			          [ parseInt(time[83]), parseInt(count[83])],
    			          [ parseInt(time[84]), parseInt(count[84])],
    			          [ parseInt(time[85]), parseInt(count[85])],
    			          [ parseInt(time[86]), parseInt(count[86])],
    			          [ parseInt(time[87]), parseInt(count[87])],
    			          [ parseInt(time[88]), parseInt(count[88])],
    			          [ parseInt(time[89]), parseInt(count[89])],
    			          [ parseInt(time[90]), parseInt(count[90])],
    			          [ parseInt(time[91]), parseInt(count[91])],
    			          [ parseInt(time[92]), parseInt(count[92])],
    			          [ parseInt(time[93]), parseInt(count[93])],
    			          [ parseInt(time[94]), parseInt(count[94])],
    			          [ parseInt(time[95]), parseInt(count[95])],
    			          [ parseInt(time[96]), parseInt(count[96])],
    			          [ parseInt(time[97]), parseInt(count[97])],
    			          [ parseInt(time[98]), parseInt(count[98])],
    			          [ parseInt(time[99]), parseInt(count[99])],
    			          [ parseInt(time[100]), parseInt(count[100])],
    			          [ parseInt(time[101]), parseInt(count[101])],
    			          [ parseInt(time[102]), parseInt(count[102])],
    			          [ parseInt(time[103]), parseInt(count[103])],
    			          [ parseInt(time[104]), parseInt(count[104])],
    			          [ parseInt(time[105]), parseInt(count[105])],
    			          [ parseInt(time[106]), parseInt(count[106])],
    			          [ parseInt(time[107]), parseInt(count[107])],
    			          [ parseInt(time[108]), parseInt(count[108])],
    			          [ parseInt(time[109]), parseInt(count[109])],
    			          [ parseInt(time[110]), parseInt(count[110])],
    			          [ parseInt(time[111]), parseInt(count[111])],
    			          [ parseInt(time[112]), parseInt(count[112])],
    			          [ parseInt(time[113]), parseInt(count[113])],
    			          [ parseInt(time[114]), parseInt(count[114])],
    			          [ parseInt(time[115]), parseInt(count[115])],
    			          [ parseInt(time[116]), parseInt(count[116])],
    			          [ parseInt(time[117]), parseInt(count[117])],
    			          [ parseInt(time[118]), parseInt(count[118])],
    			          [ parseInt(time[119]), parseInt(count[119])],
    			          [ parseInt(time[120]), parseInt(count[120])],
    			          [ parseInt(time[121]), parseInt(count[121])],
    			          [ parseInt(time[122]), parseInt(count[122])],
    			          [ parseInt(time[123]), parseInt(count[123])],
    			          [ parseInt(time[124]), parseInt(count[124])],
    			          [ parseInt(time[125]), parseInt(count[125])],
    			          [ parseInt(time[126]), parseInt(count[126])],
    			          [ parseInt(time[127]), parseInt(count[127])],
    			          [ parseInt(time[128]), parseInt(count[128])],
    			          [ parseInt(time[129]), parseInt(count[129])],
    			          [ parseInt(time[130]), parseInt(count[130])],
    			          [ parseInt(time[131]), parseInt(count[131])],
    			          [ parseInt(time[132]), parseInt(count[132])],
    			          [ parseInt(time[133]), parseInt(count[133])],
    			          [ parseInt(time[134]), parseInt(count[134])],
    			          [ parseInt(time[135]), parseInt(count[135])],
    			          [ parseInt(time[136]), parseInt(count[136])],
    			          [ parseInt(time[137]), parseInt(count[137])],
    			          [ parseInt(time[138]), parseInt(count[138])],
    			          [ parseInt(time[139]), parseInt(count[139])],
    			          [ parseInt(time[140]), parseInt(count[140])],
    			          [ parseInt(time[141]), parseInt(count[141])],
    			          [ parseInt(time[142]), parseInt(count[142])],
    			          [ parseInt(time[143]), parseInt(count[143])],
    			          [ parseInt(time[144]), parseInt(count[144])],
    			          [ parseInt(time[145]), parseInt(count[145])],
    			          [ parseInt(time[146]), parseInt(count[146])],
    			          [ parseInt(time[147]), parseInt(count[147])],
    			          [ parseInt(time[148]), parseInt(count[148])],
    			          [ parseInt(time[149]), parseInt(count[149])],
    			          [ parseInt(time[150]), parseInt(count[150])],
    			          [ parseInt(time[151]), parseInt(count[151])],
    			          [ parseInt(time[152]), parseInt(count[152])],
    			          [ parseInt(time[153]), parseInt(count[153])],
    			          [ parseInt(time[154]), parseInt(count[154])],
    			          [ parseInt(time[155]), parseInt(count[155])],
    			          [ parseInt(time[156]), parseInt(count[156])],
    			          [ parseInt(time[157]), parseInt(count[157])],
    			          [ parseInt(time[158]), parseInt(count[158])],
    			          [ parseInt(time[159]), parseInt(count[159])],
    			          [ parseInt(time[160]), parseInt(count[160])],
    			          [ parseInt(time[161]), parseInt(count[161])],
    			          [ parseInt(time[162]), parseInt(count[162])],
    			          [ parseInt(time[163]), parseInt(count[163])],
    			          [ parseInt(time[164]), parseInt(count[164])],
    			          [ parseInt(time[165]), parseInt(count[165])],
    			          [ parseInt(time[166]), parseInt(count[166])],
    			          [ parseInt(time[167]), parseInt(count[167])],
    			          [ parseInt(time[168]), parseInt(count[168])],
    			          [ parseInt(time[169]), parseInt(count[169])],
    			          [ parseInt(time[170]), parseInt(count[170])],
    			          [ parseInt(time[171]), parseInt(count[171])],
    			          [ parseInt(time[172]), parseInt(count[172])],
    			          [ parseInt(time[173]), parseInt(count[173])],
    			          [ parseInt(time[174]), parseInt(count[174])],
    			          [ parseInt(time[175]), parseInt(count[175])],
    			          [ parseInt(time[176]), parseInt(count[176])],
    			          [ parseInt(time[177]), parseInt(count[177])],
    			          [ parseInt(time[178]), parseInt(count[178])],
    			          [ parseInt(time[179]), parseInt(count[179])],
    			          [ parseInt(time[180]), parseInt(count[180])],
    			          [ parseInt(time[181]), parseInt(count[181])],
    			          [ parseInt(time[182]), parseInt(count[182])],
    			          [ parseInt(time[183]), parseInt(count[183])],
    			          [ parseInt(time[184]), parseInt(count[184])],
    			          [ parseInt(time[185]), parseInt(count[185])],
    			          [ parseInt(time[186]), parseInt(count[186])],
    			          [ parseInt(time[187]), parseInt(count[187])],
    			          [ parseInt(time[188]), parseInt(count[188])],
    			          [ parseInt(time[189]), parseInt(count[189])],
    			          [ parseInt(time[190]), parseInt(count[190])],
    			          [ parseInt(time[191]), parseInt(count[191])],
    			          [ parseInt(time[192]), parseInt(count[192])],
    			          [ parseInt(time[193]), parseInt(count[193])],
    			          [ parseInt(time[194]), parseInt(count[194])],
    			          [ parseInt(time[195]), parseInt(count[195])],
    			          [ parseInt(time[196]), parseInt(count[196])],
    			          [ parseInt(time[197]), parseInt(count[197])],
    			          [ parseInt(time[198]), parseInt(count[198])],
    			          [ parseInt(time[199]), parseInt(count[199])]
    			        ]);

    			        var options = {
    			          title: '',
    			          hAxis: {title: '노래길이', minValue: 0, maxValue: 15},
    			          vAxis: {title: '재생횟수', minValue: 0, maxValue: 15},
    			          legend: 'none'
    			        };

    			        var chart = new google.visualization.ScatterChart(document.getElementById('chart_div'));

    			        chart.draw(data, options);
    			      }		  
    	  );
	}
      
    </script>
</head>
<body>
	<!---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
	<div class="wrap-loading display-none"></div>
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
	<hr class="hr">
	
<!---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
<div style="position: absolute; width: 700px; left: 400px;">
	<button id="genreBtn" class="btn btn-primary">Top200 장르별 점유율</button>   
	<button id="countBtn" class="btn btn-primary">Top200 장르별 재생수</button>   
	<button id="timeBtn" class="btn btn-primary">Top200 노래길이별 재생수</button>   
</div>
	
	<input type="hidden" id="word01" value="기본값">
	<input type="hidden" id="word02" value="기본값">
	<input type="hidden" id="word03" value="기본값">
	<input type="hidden" id="word04" value="기본값">
	<input type="hidden" id="word05" value="기본값">
	<input type="hidden" id="word06" value="기본값">
	<input type="hidden" id="word07" value="기본값">
	<input type="hidden" id="word08" value="기본값">
	<input type="hidden" id="word09" value="기본값">
	<input type="hidden" id="word10" value="기본값">
	
	<input type="hidden" id="playCount01" value="기본값"><br>
	<input type="hidden" id="playCount02" value="기본값"><br>
	<input type="hidden" id="playCount03" value="기본값"><br>
	<input type="hidden" id="playCount04" value="기본값"><br>
	<input type="hidden" id="playCount05" value="기본값"><br>
	<input type="hidden" id="playCount06" value="기본값"><br>
	<input type="hidden" id="playCount07" value="기본값"><br>
	<input type="hidden" id="playCount08" value="기본값"><br>
	
	<input type="hidden" id="timeCount01" value="기본값"><br>
	<input type="hidden" id="timeCount02" value="기본값"><br>
	
<div style="position: absolute; float:inherit; left: 400px; top: 280px;">
	<div id="piechart" style="width: 900px; height: 500px;"></div>
	<div id="top_x_div" style="width: 900px; height: 500px;"></div>
	<div id="chart_div" style="width: 900px; height: 500px;"></div>
</div>
	<!---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
	<div id="under">
		회사소개 | 이용약관 | 개인정보처리방침 | 청소년보호정책 | 이메일주소무단수집거부 | 서비스 이용문의
		<div id="under2"></div>
	</div>
</body>
</html>