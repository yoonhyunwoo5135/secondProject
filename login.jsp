<%@page import="bean.MemberDTO"%>
<%@page import="javafx.scene.control.Alert"%>
<%@page import="bean.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
<link rel="stylesheet" type="text/css" href="stylelogin.css" />
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<body>
	<div id="top">
		<div id="title" style="margin-left: 0px">
			<a href="Main.jsp"><img src="images/Title.png"
				style="border-radius: 10px 10px 10px 10px"></a>
		</div>

	<div id="contain">
		<div id="di1">
			<img class="dimg" src="images/loginC.png">
		</div>
		<form action="login_check.jsp" method="post">
			<div id="di2">
			<center>
				<img id="profile-img" class="profile-img-card" src="//ssl.gstatic.com/accounts/ui/avatar_2x.png" />
				<p id="profile-name" class="profile-name-card"></p>
				<span id="reauth-email" class="reauth-email"></span> 
				<input type="text" name="id" id="inputId" class="form-control" placeholder="ID" required autofocus> 
				<input type="password" name="pw" id="inputPassword" class="form-control" placeholder="Password" required>
				<br>
				<input class="btn btn-lg btn-primary btn-block btn-signin" type="submit" value="Login">
		</form>
		<br>
		<form action="signin.jsp">
			<input class="btn btn-lg btn-primary btn-block btn-signin" type="submit" value="SignIn">
		</form>
			</center>
			</div>
	</div>
</body>
</head>
</html>