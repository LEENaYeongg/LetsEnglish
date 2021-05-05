<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� �� ���� ����</title>
<link rel = "stylesheet" href="../../css/main.css">
<script type="text/javascript">
function listdo(page){
	f = document.sf;
	f.pageNum.value=page;
	f.submit();
}
</script>
</head>
<body>
<p>${sessionScope.login}�� �� ��������Ʈ</p>
<form action="list.do" method="post" name="sf">
<div style="display : flex; justify-content: center;">
<input type="hidden" name="id" value="${sessionScope.login}">
<input type="hidden" name="pageNum" value="1">
<select name="bttype">
<option value="">�����ϼ���</option>
<option value="1">����</option>
<option value="2">����</option>
<option value="3">�佺</option>
<option value="4">���̿���</option>
</select>

<script>document.sf.column.value="${param.column}";</script>
<input type="submit" value="ã��"></div>
</form>

<table class="w3-table-all">
<c:if test="${scorecount ==0}">
   <tr><td colspan = "5">��ϵ� ������ �����ϴ�.</td></tr>
</c:if>
<c:if test="${scorecount >0}">
   <tr><th width = "8%">��ȣ</th><th width="10%">����</th>
      <th width="10%">����</th><th width="17%">�����</th></tr>
 
<c:forEach var="s" items="${list}">
   <tr><td>${scorenum}</td>
   <c:set var="scorenum" value="${scorenum-1}"/>
      <td style = "text-align:left">
      
      <%-- ���� ��� --%>
      <td><c:if test="${s.ttype == 1}">����</c:if>
		<c:if test="${s.ttype == 2}">����</c:if>
		<c:if test="${s.ttype == 3}">�佺</c:if>
		<c:if test="${s.ttype == 4}">���̿���</c:if>
		<c:if test="${s.ttype == 5}">��Ÿ</c:if></td>
      
      
     <%-- ��ϵ� ���� ��¥ format��� ����ϱ� --%>
    <td><fmt:formatDate value="${s.tdate}" pattern="yyyy-MM-dd" /></td>
    </c:forEach>
    
   <tr><td colspan = "6" style="text-align:center;"><%-- ������ ó���ϱ� --%>
      <c:if test="${pageNum <= 1 }">[����]</c:if>
      <c:if test="${pageNum > 1 }">
      <a href="javascript:listdo(${pageNum -1 })">[����]</a></c:if>
      
      <c:forEach var="a" begin="${startpage}" end="${endpage}">
         <c:if test="${a==pageNum}">[ ${a} ]</c:if>
         <c:if test="${a!=pageNum}">
         <a href = "javascript:listdo(${a})">[ ${a} ]</a></c:if>
      </c:forEach>
      
      <c:if test="${pageNum >= maxpage }">[����]</c:if>
      <c:if test="${pageNum < maxpage }">
      <a href="javascript:listdo(${pageNum +1 })">[����]</a>
      </c:if>
      </td></tr>
   </c:if>
   <tr><td colspan = "4" style="text-align:right">
      <a href = "scorewriteForm.do">[�߰�]</a></td></tr>
</table>
<p>���� �� ���� ����</p>
<div style="float:left;">
<div id="piecontainer" style="width:100%; border:1px solid #ffffff">
<canvas id="canvas1" style="width:100%;"></canvas>
</div>
</div>

<div style="float:left;">
<div id="barcontainer" style="width:100%; border:1px solid #ffffff">
<canvas id="canvas2" style="width:100%;"></canvas>
</div>
</div> 
</body>
</html>