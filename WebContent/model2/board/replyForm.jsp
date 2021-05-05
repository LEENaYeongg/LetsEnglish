<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Խ��� ��� ����</title>
<link rel="stylesheet" href="../../css/main.css">
</head>
<body>
	<form action="reply.do" method="post" name="f">
		<input type="hidden" name="btype" value="${param.btype}">
		<input type="hidden" name="num" value="${b.num}">
		<input type="hidden" name="grp" value="${b.grp}">
		<input type="hidden" name="grplevel" value="${b.grplevel}">
		<input type="hidden" name="grpstep" value="${b.grpstep}">
		<input type="hidden" name="bttype" value="${b.bttype}">
		<table>
			<caption>
				<c:if test="${param.btype ==1}">������ �亯 �亯 �Խ��� </c:if>
				<c:if test="${param.btype ==2}">������ι� �亯 �Խ���</c:if>
			</caption>
			<tr>
				<th width="100px">���̵�</th>
				<td>${sessionScope.login}<input type="hidden" name="id" value="${sessionScope.login}"> </td>
			</tr>
			<tr>
				<th>��й�ȣ</th>
				<td><input type="password" name="pass"></td>
			</tr>
			<tr><th>����</th>
			<td>
			<c:if test="${b.bttype == 1}">����</c:if>
			<c:if test="${b.bttype == 2}">����</c:if>
			<c:if test="${b.bttype == 3}">�佺</c:if>
			<c:if test="${b.bttype == 4}">���̿���</c:if>
			<c:if test="${b.bttype == 5}">��Ÿ</c:if>
			</td></tr>
			<tr>
				<th>����</th>
				<td><input type="text" name="title" value="RE:${b.title}"></td>
			</tr>
			<tr>
				<th>����</th>
				<td><textarea name="content" rows="15" id="content1" class="w3-input w3-border">
</textarea><script>CKEDITOR.replace("content1",{filebrowserImageUploadUrl : "imgupload.do"})
</script></td>
			</tr>
			<tr>
				<td colspan="2"><a href="javascript:document.f.submit()">[�亯�۵��]</a></td>
			</tr>
		</table>
	</form>
</body>
</html>