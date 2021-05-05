<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%-- /WebContent/model2/member/pwForm.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>비밀번호 찾기</title>
<link rel="stylesheet" href="../../css/main.css">
</head>
<body>
<h3>비밀번호찾기</h3>
<form action="pw.me" method="post">
<table>
<tr><td>아이디</td><td><input type="text" name="id"></td></tr>
<tr><td>이메일</td><td><input type="text" name="email"></td></tr>
<tr><td colspan="2"><input type="submit" value="비밀번호찾기"></td></tr>
</table>
</form>
</body>
</html>