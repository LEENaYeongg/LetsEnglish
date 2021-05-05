<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>종목 별 시험 성적</title>
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
<p>${sessionScope.login}님 의 성적리스트</p>
<form action="list.do" method="post" name="sf">
<div style="display : flex; justify-content: center;">
<input type="hidden" name="id" value="${sessionScope.login}">
<input type="hidden" name="pageNum" value="1">
<select name="bttype">
<option value="">선택하세요</option>
<option value="1">토익</option>
<option value="2">토플</option>
<option value="3">토스</option>
<option value="4">아이엘츠</option>
</select>

<script>document.sf.column.value="${param.column}";</script>
<input type="submit" value="찾기"></div>
</form>

<table class="w3-table-all">
<c:if test="${scorecount ==0}">
   <tr><td colspan = "5">등록된 점수가 없습니다.</td></tr>
</c:if>
<c:if test="${scorecount >0}">
   <tr><th width = "8%">번호</th><th width="10%">구분</th>
      <th width="10%">점수</th><th width="17%">등록일</th></tr>
 
<c:forEach var="s" items="${list}">
   <tr><td>${scorenum}</td>
   <c:set var="scorenum" value="${scorenum-1}"/>
      <td style = "text-align:left">
      
      <%-- 구분 출력 --%>
      <td><c:if test="${s.ttype == 1}">토익</c:if>
		<c:if test="${s.ttype == 2}">토플</c:if>
		<c:if test="${s.ttype == 3}">토스</c:if>
		<c:if test="${s.ttype == 4}">아이엘츠</c:if>
		<c:if test="${s.ttype == 5}">기타</c:if></td>
      
      
     <%-- 등록된 시험 날짜 format대로 출력하기 --%>
    <td><fmt:formatDate value="${s.tdate}" pattern="yyyy-MM-dd" /></td>
    </c:forEach>
    
   <tr><td colspan = "6" style="text-align:center;"><%-- 페이지 처리하기 --%>
      <c:if test="${pageNum <= 1 }">[이전]</c:if>
      <c:if test="${pageNum > 1 }">
      <a href="javascript:listdo(${pageNum -1 })">[이전]</a></c:if>
      
      <c:forEach var="a" begin="${startpage}" end="${endpage}">
         <c:if test="${a==pageNum}">[ ${a} ]</c:if>
         <c:if test="${a!=pageNum}">
         <a href = "javascript:listdo(${a})">[ ${a} ]</a></c:if>
      </c:forEach>
      
      <c:if test="${pageNum >= maxpage }">[다음]</c:if>
      <c:if test="${pageNum < maxpage }">
      <a href="javascript:listdo(${pageNum +1 })">[다음]</a>
      </c:if>
      </td></tr>
   </c:if>
   <tr><td colspan = "4" style="text-align:right">
      <a href = "scorewriteForm.do">[추가]</a></td></tr>
</table>
<p>종목 별 시험 성적</p>
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