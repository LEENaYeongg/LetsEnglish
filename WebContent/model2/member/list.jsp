<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- WebContent/model2/member/list.jsp--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원 목록</title>
<link rel="stylesheet" href="../../css/main.css">
<script type="text/javascript">
function allchkbox(chk) {
	var allchk = chk.checked //전체 선택 값, true, flase
	//getElementsByName(name) : name 속성의 값이 "mailchk"인 태그들. 배열
	//<input name="mailchk" ...>
	document.getElementsByName("mailchk").forEach
	(function(item,index){
		//item : name="mailchk"인 태그 한개
		if(allchk) //전체 선택 true
			item.setAttribute("checked",true);
		else //전체선택 false
			item.removeAttribute("checked");
	})
}
//jquery를 이용하여 allchkbox 함수 수정하기
function allchkbox2(chk) {
	$("input[name=mailchk]").prop("checked",chk.checked)
}
</script>
</head>
<body>
<form action="mailform.me" method="post">
	<table class="w3-table-all w3-border">
		<caption>회원 목록</caption>
		<tr class="w3-blue">
			<th>아이디</th>
			<th>사진</th>
			<th>이름</th>
			<th>이메일</th><th>&nbsp;</th>
			<th><input type="checkbox" name="allchk" onchange="allchkbox2(this)"></th>
		</tr>
		<c:forEach var="m" items="${list}">
			<tr>
				<td><a href="info.me?id=${m.id}">${m.id}</a></td>
				<td><img src="picture/sm_${m.picture}" width="20" height="30"></td>
				<td>${m.name}</td>
				<td>${m.email}</td>
				<td><a href="updateForm.me?id=${m.id}">[수정]</a> 
				<c:if test="${m.id != 'admin'}">
				<a href="deleteForm.jsp?id=${m.id}">[강제탈퇴]</a></c:if></td>
				<td><input type="checkbox" name="mailchk" value="${m.email}"></td>
				</tr></c:forEach><tr>
				<td colspan="6" align="center">
				<input type="submit" value="메일전송"></td></tr>
	</table>
	</form>
</body>
</html>