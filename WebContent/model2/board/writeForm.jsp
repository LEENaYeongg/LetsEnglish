<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Խ��� �۾���</title>
<link rel="stylesheet" href="../../css/main.css">
<script type="text/javascript">
function inputcheck() {
   f = document.f;
   if(f.pass.value=="") {
      alert("��й�ȣ�� �Է��ϼ���");
      f.pass.focus();
      return;
   }
   if(f.title.value=="") {
      alert("������ �Է��ϼ���");
      f.title.focus();
      return;
   }
   f.submit();
}

</script>
</head>
<body>
<form action="write.do" method="post" enctype="multipart/form-data" name="f">
<input type="hidden" name="btype" value="${param.btype}">
<table class="w3-table-all">
<caption>
<c:if test="${param.btype ==1}">������ �亯 �۾���</c:if>
<c:if test="${param.btype ==2}">������ι� �۾���</c:if>
</caption>
<tr><td width="100px">���̵�</td>
<td>${sessionScope.login}<input type="hidden" name="id" value="${sessionScope.login}"> </td></tr>
<tr><td>��й�ȣ</td>
<td><input type="password" name="pass" class="w3-input w3-border"></td></tr>
<tr><td>����</td><td>
			<input type="radio" name="bttype" value="1" />����
			<input type="radio" name="bttype" value="2" />����
			<input type="radio" name="bttype" value="3" />�佺
			<input type="radio" name="bttype" value="4" />���̿���
			<input type="radio" name="bttype" value="5" />��Ÿ
			</td></tr>
<tr><td>����</td><td><input type="text" name="title" class="w3-input w3-border"></td></tr>
<tr><td>����</td>
<td><textarea rows="15" name="content" id="content1" class="w3-input w3-border"></textarea></td></tr>
<script>CKEDITOR.replace("content1",{filebrowserImageUploadUrl : "imgupload.do"})
</script>
<tr><td>÷������</td><td><input type="file" name="file1"></td></tr>
<tr><td colspan="2"><a href="javascript:inputcheck()">[�Խù����]</a></td></tr>
</table>
</form>
</body>
</html>