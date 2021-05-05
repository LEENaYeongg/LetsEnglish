<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- /WebContent/model1/board/list.jsp--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시물 목록 보기</title>
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
<option value="">선택하세요</option>
<option value="title">제목</option>
<option value="id">아이디</option>
<option value="content">내용</option>
<option value="title,id">제목+아이디</option>
<option value="title,content">제목+내용</option>
<option value="id,content">아이디+내용</option>
<option value="title,id,content">제목+작성자+내용</option>
</select>
<select name="bttype">
				<option value="">구분</option>
				<option value="1">토익</option>
				<option value="2">토플</option>
				<option value="3">토스</option>
				<option value="4">아이엘츠</option>
				<option value="5">기타</option>
			</select>
<script>document.sf.column.value="${param.column}";</script>
<input type="text" name="find" value="${param.find}" style="width:50%;">
<input type="submit" value="검색"></div>
</form>

<table class="w3-table-all">
<caption style="background-color:#F2F2F2;">
<c:if test="${param.btype ==1}">질문과 답변 게시판</c:if>
<c:if test="${param.btype ==2}">영어공부법</c:if>
</caption>
<c:if test="${boardcount ==0}">
   <tr><td colspan = "5">등록된 게시글이 없습니다.</td></tr>
</c:if>
<c:if test="${boardcount >0}"> <%--게시글 갯수 --%>
   <tr><td colspan = "6" style = "text-align:right">글 개수:${boardcount}</td></tr>
   <tr><th width = "8%">번호</th><th width="40%">제목</th>
      <th width="14%">작성자</th><th width ="10%">구분</th><th width="17%">등록일</th>
      <th width="11%">조회수</th></tr>
<c:forEach var="b" items="${list}"> <%-- 해당 게시판 내역 출력 --%>
   <tr><td>${boardnum}</td> <%-- 게시판 넘버 --%>
   <c:set var="boardnum" value="${boardnum-1}"/>
      <td style = "text-align:left">
      
     <%--첨부파일 --%>
      <c:if test="${!empty b.file1}">
      <a href ="file/${b.file1 }"
      style="text-decoration:none;">@</a>
      </c:if>
      <c:if test="${empty b.file1}">&nbsp; &nbsp; &nbsp;</c:if>
      
     <c:if test="${b.grplevel >0 }">
        <c:forEach var="i" begin="1" end="${b.grplevel}">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </c:forEach>└</c:if>
        <%--제목 출력 --%>
         <a href="info.do?num=${b.num}&btype=${param.btype}">${b.title}</a></td>
         <%--작성자 id 출력 --%>
      <td>${b.id}</td>
      <%-- 구분 출력 --%>
      <td><c:if test="${b.bttype == 1}">토익</c:if>
		<c:if test="${b.bttype == 2}">토플</c:if>
		<c:if test="${b.bttype == 3}">토스</c:if>
		<c:if test="${b.bttype == 4}">아이엘츠</c:if>
		<c:if test="${b.bttype == 5}">기타</c:if></td>
      <%--오늘 등록된 게시물 날짜 format대로 출력하기 --%>
    <td><fmt:formatDate var="rdate" value="${b.regdate}" pattern="yyyy-MM-dd"/>
               <c:if test="${today == rdate }">
               <fmt:formatDate value="${b.regdate }" pattern="HH:mm:ss"/>
               </c:if>
               <c:if test="${today != rdate }">
               <fmt:formatDate value="${b.regdate}" pattern="yyyy-MM-dd HH:mm"/>
               </c:if></td>
      <td>${b.readcnt}</td></tr> 
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
   <tr><td colspan = "6" style="text-align:right">
      <a href = "writeForm.do?btype=${param.btype}">[글쓰기]</a></td></tr>
</table>
</body>
</html>  