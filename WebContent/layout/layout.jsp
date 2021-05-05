<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- /WebContent/layout/layout.jsp -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title><decorator:title /></title>
<decorator:head />
<link rel="stylesheet" href="${path}/css/main.css">
</head>
<body>
<table><tr><td colspan="3" align="right">
<span style="float:right;">
<c:if test="${empty sessionScope.login}">
<a href="${path}/model2/member/loginForm.me">로그인</a>
<a href="${path}/model2/member/joinForm.me">회원가입</a></c:if>
<c:if test="${!empty sessionScope.login }">
${sessionScope.login}님이 로그인 하셨습니다.&nbsp;&nbsp;
<a href="${path}/model2/member/logout.me">로그아웃</a>
</c:if></span></td></tr>
<tr><td width="15%" style="vertical-align:top">
<a href="${path}/model2/member/main.me">정보수정</a><br>
<a href="${path}/model2/board/list.do?btype=1">질문과 답변</a><br>
<a href="${path}/model2/board/list.do?btype=2">영어공부법</a><br>
<a href="${path}/model2/result/scorechart.do">시험성적</a><br>
<a href="${path}/model2/calendar/cal.do">시험일정</a><br>
</td><td colspan="2" style="text-align: lest; vertical-align:top;">
<decorator:body /><!-- <body> 태그의 내용이 추가됨. --></td></tr>
<tr><td colspan="3">기획 제작 이나영</td></tr>
</table>
</body>
</html>