<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- /WebContent/model2/board/deleteForm.jsp -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>게시글 삭제 화면</title>
<link rel="stylesheet" href="../../css/main.css">
<script type="text/javascript">
   function inputcheck(f){
      if(f.pass.value==""){
         alert("게시글 비밀번호를 입력하세요")
         f.pass.focus();
         return false;
      }
      return true;
   }
</script>
</head>
<body>
<form action="delete.do" method="post" onsubmit="return inputcheck(this)">
<input type="hidden" name="num" value="${param.num}">
<input type="hidden" name="btype" value="${param.btype}">
<table>
   <caption>게시글 삭제 화면</caption>
      <tr><td>게시글 비밀번호</td>
         <td><input type="password" name="pass"></td></tr>
      <tr><td colspan="2">
      <input type="submit" value="게시글 삭제"></td></tr>
</table>
</form>
</body>
</html>