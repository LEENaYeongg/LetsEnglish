<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시판 글쓰기</title>
<link rel="stylesheet" href="../../css/main.css">
<script type="text/javascript">
function inputcheck() {
   f = document.f;
   if(f.pass.value=="") {
      alert("비밀번호를 입력하세요");
      f.pass.focus();
      return;
   }
   if(f.title.value=="") {
      alert("제목을 입력하세요");
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
<c:if test="${param.btype ==1}">질문과 답변 글쓰기</c:if>
<c:if test="${param.btype ==2}">영어공부법 글쓰기</c:if>
</caption>
<tr><td width="100px">아이디</td>
<td>${sessionScope.login}<input type="hidden" name="id" value="${sessionScope.login}"> </td></tr>
<tr><td>비밀번호</td>
<td><input type="password" name="pass" class="w3-input w3-border"></td></tr>
<tr><td>구분</td><td>
			<input type="radio" name="bttype" value="1" />토익
			<input type="radio" name="bttype" value="2" />토플
			<input type="radio" name="bttype" value="3" />토스
			<input type="radio" name="bttype" value="4" />아이엘츠
			<input type="radio" name="bttype" value="5" />기타
			</td></tr>
<tr><td>제목</td><td><input type="text" name="title" class="w3-input w3-border"></td></tr>
<tr><td>내용</td>
<td><textarea rows="15" name="content" id="content1" class="w3-input w3-border"></textarea></td></tr>
<script>CKEDITOR.replace("content1",{filebrowserImageUploadUrl : "imgupload.do"})
</script>
<tr><td>첨부파일</td><td><input type="file" name="file1"></td></tr>
<tr><td colspan="2"><a href="javascript:inputcheck()">[게시물등록]</a></td></tr>
</table>
</form>
</body>
</html>