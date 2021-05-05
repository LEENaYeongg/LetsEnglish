<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%-- /WebContent/model2/member/joinForm.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원가입</title>
<link rel="stylesheet" href="../../css/main.css">
<script type="text/javascript">
function win_upload() {
	var op = "width=500, height=150, left=50, top=150";
	open("pictureForm.me","",op);
}
</script>
</head>
<body>
<form action="join.me" name="f" method="post">
<input type="hidden" name="picture" value=""> <!-- hidden 변수에 fname 파일 값을 출력 -->
<table><tr><td rowspan="6" valign="bottom">
<img src="" width="200" height="210" id="pic"><br>
<font size="3"><a href="javascript:win_upload()">사진등록</a></font>
</td><th colspan=2>아이디</th><td colspan=2><input type="text" name="id"></td></tr>
<tr><th colspan=2>비밀번호</th><td colspan=2><input type="password" name="pass"></td></tr>
<tr><th colspan=2>이름</th><td colspan=2><input type="text" name="name"></td></tr>
<tr><th colspan=2>이메일</th><td colspan=2><input type="text" name="email"></td></tr>
<tr><th>시험일자</th><td><input type="date" name="tdate"></td>
<th>성적
		<select name="ttype">
				<option value="1">토익</option>
				<option value="2">토플</option>
				<option value="3">토스</option>
				<option value="4">아이엘츠</option>
			</select>
		</th>
		<td><input type="text" name="score"></td></tr>

	<tr><td colspan="5"><input type="submit" value="회원가입"></td></tr>
</table>
</form>
</body>
</html>