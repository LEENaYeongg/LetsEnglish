<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<!-- /WebContent/model2/board/updateForm.jsp -->
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>������ �亯 ����</title>
<link rel="stylesheet" href="../../css/main.css">
</head>
<body>
<form action="update.do" method="post" enctype="multipart/form-data"name="f">
	<input type="hidden" name="btype" value="${param.btype}">
	<input type="hidden" name="num" value="${b.num}"> 
	<input type="hidden" name="file2" value="${b.file1}">
		<table>
			<caption>
			<c:if test="${param.btype ==1}">������ �亯 �����Խ���</c:if>
			<c:if test="${param.btype ==2}">������ι� �����Խ���</c:if>
			</caption>
			<tr>
				<td width="100px">���̵�</td>
				<td><input type="text" name="name" value="${b.id}">
				<input type="hidden" name="id" value="${sessionScope.login}"></td>
				
			</tr>
			<tr>
				<td>��й�ȣ</td>
				<td><input type="password" name="pass"></td>
			</tr>
			<tr><td>����</td>
			<td>
			<input type="radio" name="bttype" value="1" checked/>���� &nbsp;
			<input type="radio" name="bttype" value="2" <c:if test="${b.bttype == 2}">checked</c:if> />���� &nbsp;
			<input type="radio" name="bttype" value="3" <c:if test="${b.bttype == 3}">checked</c:if> />�佺 &nbsp;
			<input type="radio" name="bttype" value="4" <c:if test="${b.bttype == 4}">checked</c:if> />���̿��� &nbsp;
			<input type="radio" name="bttype" value="5" <c:if test="${b.bttype == 5}">checked</c:if> />��Ÿ
			</td></tr>
			<tr>
				<td>����</td>
				<td><input type="text" name="title" value="${b.title}"></td>
			</tr>
			 <tr>
            <td>����</td>
            <td><textarea rows="15" name="content" id="content1"
                  class="w3-input w3-border">${b.content}</textarea></td>
         </tr>
         <script>
            CKEDITOR.replace("content1",{ filebrowserImageUploadUrl : "imgupload.do" })
         </script>

			<tr>
				<td>÷������</td>
				<td style="text-align: left"><c:if test="${!empty b.file1}">
						<div id="file_desc">${b.file1}
							<a href="javascript:file_delete()">[÷������ ����]</a>
						</div>
					</c:if> <input type="file" name="file1"></td>
			</tr>
			<tr>
				<td colspan="2"><a href="javascript:document.f.submit()">[�Խù�����]</a></td>
			</tr>
		</table>
	</form>
</body>
</html>