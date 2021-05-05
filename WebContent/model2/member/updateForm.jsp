<%@page import="model.MemberDao"%>
<%@page import="model.Member"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--/WebContent/model2/member/updateForm.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>정보 수정</title>
<link rel ="stylesheet" href="../../css/main.css">
<script type="text/javascript">
function inputcheck(f){
   if(f.pass.value == ""){
      alert("비밀번호를 입력하세요");
      f.pass.focus();
      return false;
   }
}
function win_passchg(){
   var op = "width=500, height=250, left=50, top=150";
   open("passwordForm.me","",op);
}
function win_upload(){
   var op = "width=500, height=150, left=50, top=150";
   open("pictureForm.me","",op);
}
</script>
</head>
<body>
<form action="update.me" name="f" method="post"
onsubmit="return inputchectk(this)">
<input type ="hidden" name="picture" value="${mem.picture}">
<table><caption>정보 수정</caption>
<tr><td rowspan="5" valign="bottom">
<img src="picture/${mem.picture }"
 width="200" height="210" id="pic"><br>
<font size="3"><a href="javascript:win_upload()">사진수정</a></font>
</td><th colspan=2>아이디</th>
<td colspan=2><input type="text" name="id" readonly value="${mem.id}"></td></tr><%--readonly : 읽기만 가눙 --%>
<tr><th colspan=2>비밀번호</th>
<td colspan=2><input type="password" name="pass"></td></tr>
<tr><th colspan=2>이름</th>
<td colspan=2><input type="text" name="name" value="${mem.name}"></td></tr>
<tr><th colspan=2>이메일</th>
<td colspan="2"><input type="text" name="email" value="${mem.email}"></td></tr>
<tr><th>시험일자</th>
<td><input type="date" name="tdate" value='<fmt:formatDate value="${sco.tdate}" pattern="yyyy-MM-dd"/>'></td>
<th><select name="ttype">
		<option value="1" <c:if test="${mem.ttype == 1}">selected</c:if>>토익</option>
		<option value="2" <c:if test="${mem.ttype == 2}">selected</c:if>>토플</option>
		<option value="3" <c:if test="${mem.ttype == 3}">selected</c:if>>토스</option>
		<option value="4" <c:if test="${mem.ttype == 4}">selected</c:if>>아이엘츠</option>
</select></th>
<td><input type="text" name="score" value="${sco.score}"></td></tr>
			
<tr><td colspan="5"><input type="submit" value="회원수정">
<c:if test="${sessionScope.login !='admin' || param.id == 'admin'}">
<input type="button" value="비밀번호수정" onclick="win_passchg()">
</c:if></td></tr>
</table></form>
</body>
</html>