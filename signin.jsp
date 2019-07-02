<%@page import="bean.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>SignIn</title>
		<link rel="stylesheet" type="text/css" href="stylelogin.css" />
		<link rel="stylesheet"
			href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
			integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
			crossorigin="anonymous">
		<script
			src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
			integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
			crossorigin="anonymous"></script>
		<script
			src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<script type="text/javascript">
			$(function() { // 입력된 값들을 모두 넘김
				$("#insert").click(function() {
					var d = jQuery("#check").serialize();
					if($("#id").val() == ""){
						alert("아이디를 입력해주세요");
						$("#id").focus();
						return false;
					}
					else if($("#pw1").val() == ""){
						alert("비밀번호를 입력해주세요");
						$("#pw1").focus();
						return false;
					}
					else if($("#pw2").val() == ""){
						alert("비밀번호를 확인해주세요");
						$("#pw2").focus();
						return false;
					}
					else if($("#name").val() == ""){
						alert("이름을 입력해주세요");
						$("#name").focus();
						return false;
					}
					else if($("#eId").val() == ""){
						alert("이메일을 입력해주세요");
						$("#eId").focus();
						return false;
					}
					else if($("#eAdd").val() == ""){
						alert("이메일 형식을 확인해주세요");
						$("#eAdd").focus();
						return false;
					}
					$.ajax({
						url : "insertMember.jsp",
						data : d,
						dataType : "text",
						success : function(result) {
							alert("가입완료");
						}
					});
					return false;
				});
			});
		
			$(function() {
				$("#idchk").click(function() {
					var d = jQuery("#check").serialize();
					$.ajax({
						url : "id_check.jsp",
						data : d,
						dataType : "text",
						success : function(result) {
							if ($.trim(result) == "YES") {
								alert("사용 가능한 ID입니다.");
							} else {
								alert("중복된 ID입니다.");
							}
						}
					});
					return false;
				});
			});
		
			$(function() {
				$("#alert-check").hide();
				$("#alert-success").hide();
				$("#alert-danger").hide();
				$("input").keyup(function() {
					var pw1 = $("#pw1").val();
					var pw2 = $("#pw2").val();
					if (pw1 != "" || pw2 != "") {
						if (pw1.length < 6 || pw1 == "") {
							$("#alert-check").show();
							$("#alert-success").hide();
							$("#alert-danger").show();
							$("#submit").attr("disabled", "disabled");
						} else {
							if(pw1 != pw2){
							$("#alert-check").hide();
							$("#alert-success").hide();
							$("#alert-danger").show();
							$("#submit").attr("disabled", "disabled");
						} else if (pw1 == pw2) {
							$("#alert-check").hide();
							$("#alert-success").show();
							$("#alert-danger").hide();
							$("#submit").removeAttr("disabled");
					}
						}
				}
			});
		});
		</script>
	
		<style>
		.container {
			margin-top: 125px;
			margin-left: 270px;
		}
		
		input.ng-invalid {
			border: 5px solid red;
		}
		</style>
		<script type="text/javascript" src="libs/angular/angular.js"></script>
		<script>
			angular.module('form-demo-app', []).controller('mainCtrl',[ '$scope', function($scope) {} ]);
		</script>
	</head>
	
	<body ng-controller="mainCtrl">
		<div id="top">
			<div id="title" style="margin-left: 0px">
			<a href="Main.jsp"><img src="images/Title.png"
				style="border-radius: 10px 10px 10px 10px"></a>
		</div>
		</div>
		<div id="contain">
			<div class="container" id="wrap">
				<div class="row">
					<div class="col-md-6 col-md-offset-3">
						<form id="check" name="check" method="POST">
							<center>
								<legend><h2>회원가입</h2></legend>
							</center>
							<h5>회원정보 입력</h5>
							<div class="row">
								<div class="col-xs-6 col-md-6">
									<input type="text" id = "id" name="id" class="form-control input-lg" placeholder="아이디" />
								</div>
								<div class="col-xs-6 col-md-6">
									<button type="button" id="idchk" class="btn btn-outline-info">중복확인</button>
								</div>
							</div>
							<br>
							<input type="password" id="pw1" name="pw1"
								class="form-control input-lg" placeholder="패스워드 (6자 이상)" /> <br>
							<input type="password" id="pw2" class="form-control input-lg"
								placeholder="패스워드 재입력" onblur="" /> <br>
							<div class="alert alert-warning" id="alert-check">비밀번호를 6자이상 써주세요.</div>
							<div class="alert alert-success" id="alert-success">비밀번호가 일치합니다.</div>
							<div class="alert alert-danger" id="alert-danger">비밀번호가 일치하지 않습니다.</div>
							<br>
							<input type="text" id = "name" name="name" class="form-control input-lg" placeholder="이름" 
							ng-required="true" ng-maxlength="6" /> <br> 
							<label style="font-size: 20px"><b>성별 : </b></label>
							<input type="radio"	name="gender" value="female" checked>여자
							<input type="radio" name="gender" value="male">남자 <br> 
									
							<label style="font-size: 18px"><b>생년월일 : </b></label><br>
								<span style="float: left; margin-right:20px;">
									<select name="birthY">
										<%for(int i = 2019; i > 1900; i--){%>
										<option value="<%= i %>"><%=i%></option>
										<%}	%>
									</select> 년 &nbsp;
									<select name="birthM">
										<%for(int i = 1; i <= 12; i++){%>
										<option value="<%= i %>"><%= i %></option>
										<%}%>
									</select> 월 &nbsp;
									<select name="birthD">
										<%for(int i = 1; i <= 31; i++){%>
										<option value="<%= i %>"><%= i %></option>
										<%}%>
									</select> 일
								</span>
								<br>
								<br>
								<div class="row">
									<div class="col-xs-6 col-md-6">
										<input type="text" id = "eId" name="eId" class="form-control input-lg"
											placeholder="Email">
									</div>
									<div class="col-xs-6 col-md-6">
										<select id = "eAdd" name="eAdd" class="form-control input-lg">
											<option selected value = "">이메일 선택</option>
											<option>@naver.com</option>
											<option>@daum.net</option>
											<option>@gmail.com</option>
											<option>@hotmail.com</option>
											<option>@yahoo.com</option>
										</select>
									</div>
								</div>
								<br>
								<button id="insert"	class="btn btn-lg btn-primary btn-block signup-btn"	type="submit">회원가입</button>
	
							</form>
	
						</div>
					</div>
				</div>
			</div>
	</body>

</html>