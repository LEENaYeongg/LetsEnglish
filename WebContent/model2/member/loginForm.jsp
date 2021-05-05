<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%-- /WebContent/model2/member/loginForm.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>로그인 화면</title>
<link rel="stylesheet" href="../../css/main.css">
<script type="text/javascript">
function inputcheck(f){
	if(f.id.value == ''){
		alert("아이디를 입력하세요");
	    f.id.focus();
	    return false;
}
	if(f.id.value.length < 4) {
		alert("비밀번호를 입력하세요");
		f.pass.focus();
		return false;
	}
	return true;
	}
	function win_open(page){
		var op = "width=500, height=350, left=50, top=150";
		open(page+".me","",op);
	}
</script>
</head>
<body>
<form action="login.me" method="post" name="f" onsubmit="return inputcheck(this)">
<table><caption style="background-color:#F2F2F2;">로그인</caption>
<tr><th>아이디</th><td><input type="text" name="id"></td></tr>
<tr><th>비밀번호</th><td><input type="password" name="pass"></td></tr>
<tr><td colspan="2">
<input type="submit" value="로그인">
<input type="button" value="회원가입" onclick="location.href='joinForm.me'">
<input type="button" value="아이디찾기" onclick="win_open('idForm')">
<input type="button" value="비밀번호찾기" onclick="win_open('pwForm')">
</td></tr>
</table>
</form>
</body>
</html>