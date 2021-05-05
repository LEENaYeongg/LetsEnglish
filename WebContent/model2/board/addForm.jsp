<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
     <%-- /WebContent/model2/member/idForm.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>시험 결과 추가하기</title>
<link rel="stylesheet" href="../../css/main.css">
</head>
<body>
<form action="add.do" method="post" name="f">
<input type="hidden" name="id" value="${param.id}">
<h3>시험 결과 추가</h3>
<table class="w3-table-all">
<tr><th>아이디</th><td>${sessionScope.login}<input type="hidden" name="id" value="${sessionScope.login}"> </td></tr>
<tr><th>시험일자</th><td><input type="date" name="tdate"></td>
<tr><th>성적
		<select name="ttype">
				<option value="1">토익</option>
				<option value="2">토플</option>
				<option value="3">토스</option>
				<option value="4">아이엘츠</option>
			</select>
		</th>
<td><input type="text" name="score"></td></tr>
<tr><td colspan="2" ><a href="javascript:document.f.submit()">[추가]</a></td></tr>
</table>
</form>
</body>
</html>