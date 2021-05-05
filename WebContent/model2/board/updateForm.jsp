<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<!-- /WebContent/model2/board/updateForm.jsp -->
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>질문과 답변 수정</title>
<link rel="stylesheet" href="../../css/main.css">
</head>
<body>
<form action="update.do" method="post" enctype="multipart/form-data"name="f">
	<input type="hidden" name="btype" value="${param.btype}">
	<input type="hidden" name="num" value="${b.num}"> 
	<input type="hidden" name="file2" value="${b.file1}">
		<table>
			<caption>
			<c:if test="${param.btype ==1}">질문과 답변 수정게시판</c:if>
			<c:if test="${param.btype ==2}">영어공부법 수정게시판</c:if>
			</caption>
			<tr>
				<td width="100px">아이디</td>
				<td><input type="text" name="name" value="${b.id}">
				<input type="hidden" name="id" value="${sessionScope.login}"></td>
				
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="pass"></td>
			</tr>
			<tr><td>구분</td>
			<td>
			<input type="radio" name="bttype" value="1" checked/>토익 &nbsp;
			<input type="radio" name="bttype" value="2" <c:if test="${b.bttype == 2}">checked</c:if> />토플 &nbsp;
			<input type="radio" name="bttype" value="3" <c:if test="${b.bttype == 3}">checked</c:if> />토스 &nbsp;
			<input type="radio" name="bttype" value="4" <c:if test="${b.bttype == 4}">checked</c:if> />아이엘츠 &nbsp;
			<input type="radio" name="bttype" value="5" <c:if test="${b.bttype == 5}">checked</c:if> />기타
			</td></tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="title" value="${b.title}"></td>
			</tr>
			 <tr>
            <td>내용</td>
            <td><textarea rows="15" name="content" id="content1"
                  class="w3-input w3-border">${b.content}</textarea></td>
         </tr>
         <script>
            CKEDITOR.replace("content1",{ filebrowserImageUploadUrl : "imgupload.do" })
         </script>

			<tr>
				<td>첨부파일</td>
				<td style="text-align: left"><c:if test="${!empty b.file1}">
						<div id="file_desc">${b.file1}
							<a href="javascript:file_delete()">[첨부파일 삭제]</a>
						</div>
					</c:if> <input type="file" name="file1"></td>
			</tr>
			<tr>
				<td colspan="2"><a href="javascript:document.f.submit()">[게시물수정]</a></td>
			</tr>
		</table>
	</form>
</body>
</html>