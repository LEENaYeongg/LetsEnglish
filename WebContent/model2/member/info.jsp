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
<title>�� ���� ��ȸ</title>
<link rel = "stylesheet" href="../../css/main.css">
</head>
<body>
<table><caption>ȸ����������</caption>
<tr><td rowspan = "6" width="30%">
<img src="picture/${mem.picture}" width="200" height="210">
<th colspan=2>���̵�</th><td colspan=2>${mem.id}</td></tr>
<tr><th colspan=2>�̸�</th><td colspan=2>${mem.name}</td></tr>
<tr><th colspan=2>�̸���</th><td colspan=2>${mem.email}</td></tr>
<tr><th width="15%">��������</th><td><fmt:formatDate value="${sco.tdate}" pattern="yyyy-MM-dd"/> </td>
<th width="20%">
<c:if test="${mem.ttype == 1}">����</c:if>
<c:if test="${mem.ttype == 2}">����</c:if>
<c:if test="${mem.ttype == 3}">�佺</c:if>
<c:if test="${mem.ttype == 4}">���̿���</c:if>
</th>
<td>${sco.score}</td></tr>
<tr><td colspan="5">
<a href="updateForm.me?id=${mem.id}">[����]</a>
<c:if test="${param.id != 'admin' && sessionScope.login != 'admin'}">
<a href="deleteForm.me?id=${mem.id}">[Ż��]</a>
</c:if>
</td><tr>
</table>
</body>
</html>
