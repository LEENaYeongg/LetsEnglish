<%@page import="model.Member"%>
<%@page import="model.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%--/WebContent/model2/member/info.jsp --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>내 정보 조회</title>
<link rel = "stylesheet" href="../../css/main.css">
</head>
<body>
<table><caption>회원정보보기</caption>
<tr><td rowspan = "6" width="30%">
<img src="picture/${mem.picture}" width="200" height="210">
<th colspan=2>아이디</th><td colspan=2>${mem.id}</td></tr>
<tr><th colspan=2>이름</th><td colspan=2>${mem.name}</td></tr>
<tr><th colspan=2>이메일</th><td colspan=2>${mem.email}</td></tr>
<tr><th width="15%">시험일자</th><td><fmt:formatDate value="${sco.tdate}" pattern="yyyy-MM-dd"/> </td>
<th width="20%">
<c:if test="${mem.ttype == 1}">토익</c:if>
<c:if test="${mem.ttype == 2}">토플</c:if>
<c:if test="${mem.ttype == 3}">토스</c:if>
<c:if test="${mem.ttype == 4}">아이엘츠</c:if>
</th>
<td>${sco.score}</td></tr>
<tr><td colspan="5">
<a href="updateForm.me?id=${mem.id}">[수정]</a>
<c:if test="${param.id != 'admin' && sessionScope.login != 'admin'}">
<a href="deleteForm.me?id=${mem.id}">[탈퇴]</a>
</c:if>
</td><tr>
</table>
</body>
</html>
