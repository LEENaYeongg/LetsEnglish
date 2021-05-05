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
<title>종목별 시험 성적</title>
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
<p>${sessionScope.login}님 의 성적리스트:${scorecount}</p>
<form action="slist.do" method="post" name="sf">
<div style="display : flex; justify-content: center;">
<input type="hidden" name="id" value="${sessionScope.login}">
<input type="hidden" name="pageNum" value="1">
<script>document.sf.column.value="${param.column}";</script>
</div>
</form>

<table class="w3-table-all">
<c:if test="${scorecount ==0}">
   <tr><td colspan = "4">등록된 게시글이 없습니다.</td></tr>
</c:if>
<c:if test="${scorecount >0}"> <%--게시글 갯수 --%>
   <tr><th width = "8%">번호</th><th width="10%">구분</th>
      <th width="10%">점수</th><th width="17%">등록일</th></tr>
      
<c:forEach var="s" items="${slist}"> <%-- 해당 게시판 내역 출력 --%>
   <a href="slist.do?id=${sessionScope.login}"></a>
   
   <tr><td>${scorenum}</td> <%-- 게시판 넘버 --%>
   <c:set var="scorenum" value="${scorenum-1}"/>
      
      <%-- 구분 출력 --%>
      <td><c:if test="${s.ttype == 1}">토익</c:if>
		<c:if test="${s.ttype == 2}">토플</c:if>
		<c:if test="${s.ttype == 3}">토스</c:if>
		<c:if test="${s.ttype == 4}">아이엘츠</c:if>
		<c:if test="${s.ttype == 5}">기타</c:if></td>
      
      <%-- 점수 출력 --%>
      <td>${s.score}</td>
      
      <%--오늘 등록된 게시물 날짜 format대로 출력하기 --%>
   <td><fmt:formatDate value="${s.tdate}" pattern="yyyy-MM-dd" /></td>
   </c:forEach>
      
   <tr><td colspan = "4" style="text-align:center;"><%-- 페이지 처리하기 --%>
      <c:if test="${pageNum <= 1 }">[이전]</c:if>
      <c:if test="${pageNum > 1 }">
      <a href="javascript:slistdo(${pageNum -1 })">[이전]</a></c:if>
      
      <c:forEach var="a" begin="${startpage}" end="${endpage}">
         <c:if test="${a==pageNum}">[ ${a} ]</c:if>
         <c:if test="${a!=pageNum}">
         <a href = "javascript:slistdo(${a})">[ ${a} ]</a></c:if>
      </c:forEach>
      
      <c:if test="${pageNum >= maxpage }">[다음]</c:if>
      <c:if test="${pageNum < maxpage }">
      <a href="javascript:slistdo(${pageNum +1 })">[다음]</a>
      </c:if>
      </td></tr>
   </c:if>
   <tr><td colspan = "4" style="text-align:right">
      <a href = "addForm.do?id=${sessionScope.login}">[추가]</a></td></tr>
</table>
<br>
<h4>종목 별 시험 성적</h4>

</body>
</html>  