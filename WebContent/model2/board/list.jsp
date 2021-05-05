<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- /WebContent/model1/board/list.jsp--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Խù� ��� ����</title>
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
<form action="list.do" method="post" name="sf">
<div style="display : flex; justify-content: center;">
<input type="hidden" name="btype" value="${param.btype}">
<input type="hidden" name="pageNum" value="1">
<select name="column">
<option value="">�����ϼ���</option>
<option value="title">����</option>
<option value="id">���̵�</option>
<option value="content">����</option>
<option value="title,id">����+���̵�</option>
<option value="title,content">����+����</option>
<option value="id,content">���̵�+����</option>
<option value="title,id,content">����+�ۼ���+����</option>
</select>
<select name="bttype">
				<option value="">����</option>
				<option value="1">����</option>
				<option value="2">����</option>
				<option value="3">�佺</option>
				<option value="4">���̿���</option>
				<option value="5">��Ÿ</option>
			</select>
<script>document.sf.column.value="${param.column}";</script>
<input type="text" name="find" value="${param.find}" style="width:50%;">
<input type="submit" value="�˻�"></div>
</form>

<table class="w3-table-all">
<caption style="background-color:#F2F2F2;">
<c:if test="${param.btype ==1}">������ �亯 �Խ���</c:if>
<c:if test="${param.btype ==2}">������ι�</c:if>
</caption>
<c:if test="${boardcount ==0}">
   <tr><td colspan = "5">��ϵ� �Խñ��� �����ϴ�.</td></tr>
</c:if>
<c:if test="${boardcount >0}"> <%--�Խñ� ���� --%>
   <tr><td colspan = "6" style = "text-align:right">�� ����:${boardcount}</td></tr>
   <tr><th width = "8%">��ȣ</th><th width="40%">����</th>
      <th width="14%">�ۼ���</th><th width ="10%">����</th><th width="17%">�����</th>
      <th width="11%">��ȸ��</th></tr>
<c:forEach var="b" items="${list}"> <%-- �ش� �Խ��� ���� ��� --%>
   <tr><td>${boardnum}</td> <%-- �Խ��� �ѹ� --%>
   <c:set var="boardnum" value="${boardnum-1}"/>
      <td style = "text-align:left">
      
     <%--÷������ --%>
      <c:if test="${!empty b.file1}">
      <a href ="file/${b.file1 }"
      style="text-decoration:none;">@</a>
      </c:if>
      <c:if test="${empty b.file1}">&nbsp; &nbsp; &nbsp;</c:if>
      
     <c:if test="${b.grplevel >0 }">
        <c:forEach var="i" begin="1" end="${b.grplevel}">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </c:forEach>��</c:if>
        <%--���� ��� --%>
         <a href="info.do?num=${b.num}&btype=${param.btype}">${b.title}</a></td>
         <%--�ۼ��� id ��� --%>
      <td>${b.id}</td>
      <%-- ���� ��� --%>
      <td><c:if test="${b.bttype == 1}">����</c:if>
		<c:if test="${b.bttype == 2}">����</c:if>
		<c:if test="${b.bttype == 3}">�佺</c:if>
		<c:if test="${b.bttype == 4}">���̿���</c:if>
		<c:if test="${b.bttype == 5}">��Ÿ</c:if></td>
      <%--���� ��ϵ� �Խù� ��¥ format��� ����ϱ� --%>
    <td><fmt:formatDate var="rdate" value="${b.regdate}" pattern="yyyy-MM-dd"/>
               <c:if test="${today == rdate }">
               <fmt:formatDate value="${b.regdate }" pattern="HH:mm:ss"/>
               </c:if>
               <c:if test="${today != rdate }">
               <fmt:formatDate value="${b.regdate}" pattern="yyyy-MM-dd HH:mm"/>
               </c:if></td>
      <td>${b.readcnt}</td></tr> 
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
   <tr><td colspan = "6" style="text-align:right">
      <a href = "writeForm.do?btype=${param.btype}">[�۾���]</a></td></tr>
</table>
</body>
</html>  