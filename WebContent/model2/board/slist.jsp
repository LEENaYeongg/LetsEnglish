<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%-- /WebContent/model2/board/slist.jsp--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ���� ����</title>
<link rel = "stylesheet" href="../../css/main.css">
<script type="text/javascript">
function slistdo(page){
	f = document.sf;
	f.pageNum.value=page;
	f.submit();
}
</script>
</head>
<body>
<p>${sessionScope.login}�� �� ��������Ʈ:${scorecount}</p>
<form action="slist.do" method="post" name="sf">
<div style="display : flex; justify-content: center;">
<input type="hidden" name="id" value="${sessionScope.login}">
<input type="hidden" name="pageNum" value="1">
<script>document.sf.column.value="${param.column}";</script>
</div>
</form>

<table class="w3-table-all">
<c:if test="${scorecount ==0}">
   <tr><td colspan = "4">��ϵ� �Խñ��� �����ϴ�.</td></tr>
</c:if>
<c:if test="${scorecount >0}"> <%--�Խñ� ���� --%>
   <tr><th width = "8%">��ȣ</th><th width="10%">����</th>
      <th width="10%">����</th><th width="17%">�����</th></tr>
      
<c:forEach var="s" items="${slist}"> <%-- �ش� �Խ��� ���� ��� --%>
   <a href="slist.do?id=${sessionScope.login}"></a>
   
   <tr><td>${scorenum}</td> <%-- �Խ��� �ѹ� --%>
   <c:set var="scorenum" value="${scorenum-1}"/>
      
      <%-- ���� ��� --%>
      <td><c:if test="${s.ttype == 1}">����</c:if>
		<c:if test="${s.ttype == 2}">����</c:if>
		<c:if test="${s.ttype == 3}">�佺</c:if>
		<c:if test="${s.ttype == 4}">���̿���</c:if>
		<c:if test="${s.ttype == 5}">��Ÿ</c:if></td>
      
      <%-- ���� ��� --%>
      <td>${s.score}</td>
      
      <%--���� ��ϵ� �Խù� ��¥ format��� ����ϱ� --%>
   <td><fmt:formatDate value="${s.tdate}" pattern="yyyy-MM-dd" /></td>
   </c:forEach>
      
   <tr><td colspan = "4" style="text-align:center;"><%-- ������ ó���ϱ� --%>
      <c:if test="${pageNum <= 1 }">[����]</c:if>
      <c:if test="${pageNum > 1 }">
      <a href="javascript:slistdo(${pageNum -1 })">[����]</a></c:if>
      
      <c:forEach var="a" begin="${startpage}" end="${endpage}">
         <c:if test="${a==pageNum}">[ ${a} ]</c:if>
         <c:if test="${a!=pageNum}">
         <a href = "javascript:slistdo(${a})">[ ${a} ]</a></c:if>
      </c:forEach>
      
      <c:if test="${pageNum >= maxpage }">[����]</c:if>
      <c:if test="${pageNum < maxpage }">
      <a href="javascript:slistdo(${pageNum +1 })">[����]</a>
      </c:if>
      </td></tr>
   </c:if>
   <tr><td colspan = "4" style="text-align:right">
      <a href = "addForm.do?id=${sessionScope.login}">[�߰�]</a></td></tr>
</table>
<br>
<h4>���� �� ���� ����</h4>

</body>
</html>  