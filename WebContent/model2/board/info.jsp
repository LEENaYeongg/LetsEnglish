<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- /WebContent/model2/board/info.jsp -->
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Խù� �󼼺���</title>
<script type="text/javascript">
function inputcheck() {
	f = document.f;
	if(f.content.value==""){
		alert("������ �Է��ϼ���");
		f.name.focus();
		return;
	}
	
	f.submit();
}
</script>
<link rel = "stylesheet" href="../../css/main.css">
</head>
<body>
<input type="hidden" name="btype" value="${param.btype}">

<table>
<caption>
<c:if test="${param.btype ==1}">������ �亯 �Խ���</c:if>
<c:if test="${param.btype ==2}">������ι�</c:if>
</caption>

<tr><th width="20%">���̵�</th><td>${b.id}</td></tr>

<tr><th>����</th>
<td>
<c:if test="${b.bttype == 1}">����</c:if>
<c:if test="${b.bttype == 2}">����</c:if>
<c:if test="${b.bttype == 3}">�佺</c:if>
<c:if test="${b.bttype == 4}">���̿���</c:if>
<c:if test="${b.bttype == 5}">��Ÿ</c:if>
</td></tr>
<tr><th>����</th><td>${b.title}</td></tr>
<tr><th>����</th>
<td><table style="width:100%; height:250px;">
<tr><td style="border-width:0px; vertical-align:top; text-align:left">${b.content}</td></tr>
</table></td></tr>
<tr><th>÷������</th><td>
<c:if test="${empty b.file1}">&nbsp;</c:if>
<c:if test="${!empty b.file1}"><a href="file/${b.file1}">${b.file1}</a></c:if></td></tr>
<tr><td colspan="2">
<%--  <c:if test="${param.btype==3}"> --%>
<div align="center">
<table>
<c:forEach var="c" items="${comment}">
   <tr><td style ="text-align:left; width: 50px; border-right: hidden;">${c.id}</td>
   <td style="text-align:left; border-right: hidden;">${c.content}</td>
   <td style ="text-align:left; width: 100px;"><font size="1.5">
   <fmt:formatDate value="${c.rdate}" pattern="yyyy-MM-dd HH:mm"/></font>
   </td></tr>
   </c:forEach>
</table>

<form action="comment.do" method="post" name="f"> <%-- ��� �� --%>
<input type="hidden" name="id" value="${sessionScope.login}">
<input type="hidden" name="num" value="${param.num}">
<input type="hidden" name="btype" value="${param.btype}">
<table border="1" style="background-color:yellow;">
<tr><td colspan="0.5" width="80%">
<textarea rows="5" name ="content"
	id="content1" class="w3-input w3-border"></textarea></td>
	<td colspan="0.5" width="20%"><a href="javascript:inputcheck()">��۵��</a></td></tr>
</table>
</form>
</div>

	<h4><a href = "replyForm.do?num=${b.num}&btype=${param.btype}">�亯</a>
	<c:if test="${sessionScope.login==b.id}"> 
	<a href = "updateForm.do?num=${b.num}&btype=${param.btype}">����</a>
	<a href = "deleteForm.do?num=${b.num}&btype=${param.btype}">����</a>
	</c:if>
	<a href = "list.do?btype=${param.btype}">���</a></td></tr></h4>
</table>
</body>
</html>