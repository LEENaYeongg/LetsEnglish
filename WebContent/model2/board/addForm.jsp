<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
     <%-- /WebContent/model2/member/idForm.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ��� �߰��ϱ�</title>
<link rel="stylesheet" href="../../css/main.css">
</head>
<body>
<form action="add.do" method="post" name="f">
<input type="hidden" name="id" value="${param.id}">
<h3>���� ��� �߰�</h3>
<table class="w3-table-all">
<tr><th>���̵�</th><td>${sessionScope.login}<input type="hidden" name="id" value="${sessionScope.login}"> </td></tr>
<tr><th>��������</th><td><input type="date" name="tdate"></td>
<tr><th>����
		<select name="ttype">
				<option value="1">����</option>
				<option value="2">����</option>
				<option value="3">�佺</option>
				<option value="4">���̿���</option>
			</select>
		</th>
<td><input type="text" name="score"></td></tr>
<tr><td colspan="2" ><a href="javascript:document.f.submit()">[�߰�]</a></td></tr>
</table>
</form>
</body>
</html>