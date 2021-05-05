<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<title><decorator:title /></title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
html, body, h1, h2, h3, h4, h5 {font-family: "Raleway", sans-serif}
</style>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<decorator:head /> 

</head>
<body class="w3-light-grey">

	<!-- Top container -->
	<div class="w3-bar w3-top w3-light-gray w3-right" style="height: 70px; ">
		<button
			class="w3-bar-item w3-button w3-hide-large w3-hover-none w3-hover-text-light-grey"
			onclick="w3_open();">
			<i class="fa fa-bars"></i>Menu
		</button>
		<span class="w3-bar-item w3-collapse w3-light-gray w3-right" 
		style="font-family: Fantasy; font-size:40px;"> 
		<a href = "${path}/model2/member/main.me">Lets English</a>
		</span>
	</div>

	<!-- Sidebar/menu -->
	<nav class="w3-sidebar w3-collapse w3-light-gray w3-animate-left"
		style="z-index: 3; width: 300px; top: 70px;" id="mySidebar">
		<br>
		<div class="w3-container w3-row">
			<div class="w3-col s4">
				<img src="${path}/model2/member/picture/${sessionScope.picture}"  
					style="width: 110px; border-radius: 30px;">
			</div>
			<div class="w3-col s8 w3-bar" style="padding-left: 35px;">
				<c:if test="${empty sessionScope.login }">
					<span><strong>로그인하세요</strong></span>
					<br>
				</c:if>
				<c:if test="${!empty sessionScope.login }">
					<span>반갑습니다.<strong> ${sessionScope.login}님 </strong></span>
					<br>
				</c:if>
				<div style ="float:left">
				<c:if test="${empty sessionScope.login }"> 
				<button onclick="location.href='${path}/model2/member/joinForm.me'">회원가입</button>&nbsp;</c:if>
				<c:if test="${!empty sessionScope.login }"> 
				<button onclick="location.href='${path}/model2/member/info.me?id=${sessionScope.login }'">내정보</button>&nbsp;</c:if>
				</div>
				<div style ="float:left">
				<c:if test="${empty sessionScope.login }"> 
				<button onclick="location.href='${path}/model2/member/loginForm.me'">로그인</button></c:if>
				<c:if test="${!empty sessionScope.login }"> 
				<button onclick="location.href='${path}/model2/member/logout.me'">로그아웃</button></c:if>
				</div><br>
				<c:if test = "${sessionScope.login == 'admin'}">
  						 <button onclick="location.href='${path}/model2/member/list.me'"
  						 style ="margin-top: 5px; width: 141px;">회원목록 보기</button>
						</c:if>
			</div>
		</div>
		<hr>
		<div class="w3-container w3-center">
			<h2>목록</h2>
		</div>
		<div class="w3-bar-block" style="text-align: cecnter;">
			<a href="#" class="w3-bar-item w3-button w3-padding-16 w3-hide-large w3-dark-grey w3-hover-black"
				onclick="w3_close()" title="close menu">
				<i class="fa fa-remove fa-fw"></i>Close Menu</a> 
				<a href="${path}/model2/board/list.do?btype=1"
				class="w3-bar-item w3-button w3-padding w3-light-gray w3-center">
				<i class="fa fa-circle-o-notch"></i>&nbsp;&nbsp;질문과 답변</a> 
				<a href="${path}/model2/board/list.do?btype=2"
				class="w3-bar-item w3-button w3-padding w3-light-gray w3-center">
				<i class="fa fa-circle-o-notch"></i>&nbsp;&nbsp;영어공부법</a>
				<a href="${path}/model2/board/slist.do"
				class="w3-bar-item w3-button w3-padding w3-light-gray w3-center">
				<i class="fa fa-circle-o-notch"></i>&nbsp;&nbsp;나만의 성적</a> 
				<a href="${path}/model2/board/cal.do"
				class="w3-bar-item w3-button w3-padding w3-light-gray w3-center">
				<i class="fa fa-circle-o-notch"></i>&nbsp;&nbsp;시험 일정표</a> 
		</div>
	</nav>

	<!-- Overlay effect when opening sidebar on small screens -->
	<div class="w3-overlay w3-hide-large w3-animate-opacity"
		onclick="w3_close()" style="cursor: pointer" title="close side menu"
		id="myOverlay"></div>

	<!-- !PAGE CONTENT! -->
	<div class="w3-main" style="margin-left:300px; margin-top: 60px;">

		<!-- Header 밑에 본문 -->
		<header class="w3-container w3-center w3-padding-32" style="padding-top: 50px">
			<decorator:body />
		</header>
		<div class="w3-row-padding w3-margin-bottom"></div>
		<div class="w3-panel"></div>

		</div>
		<!-- End page content -->

	<script>
		// Get the Sidebar
		var mySidebar = document.getElementById("mySidebar");

		// Get the DIV with overlay effect
		var overlayBg = document.getElementById("myOverlay");

		// Toggle between showing and hiding the sidebar, and add overlay effect
		function w3_open() {
			if (mySidebar.style.display === 'block') {
				mySidebar.style.display = 'none';
				overlayBg.style.display = "none";
			} else {
				mySidebar.style.display = 'block';
				overlayBg.style.display = "block";
			}
		}

		// Close the sidebar with the close button
		function w3_close() {
			mySidebar.style.display = "none";
			overlayBg.style.display = "none";
		}
	</script>
</body>
</html>
