<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%--/WebContent/medel1/member/password.jsp
1.로그아웃 상태인 경우. 로그인하세요. 메세지 추력
 다른 사용자의 비밀번호 변경 불가-> 로그인된 id값으로만 변경 가능.본인만 변경 가능
 opener페이지를 loginForm.jsp페이지 이동
  현재페이지 닫기
2.pass, chgpass 파라미터 값 저장
3.pass 비밀번호가db에 저장된 비밀번호와 틀리면
   비밀번호 오류 메세지 출력. passwordForm.jsp 페이지 이동
4.pass 비밀번호가 db에 저장된 비밀번호와 같으면
  MemverDao.updatePass(login,chgpass) ->새로운 비밀번호로 수정
  비밀번호 수정 성공
        메세지 출력후 opener 페이지를 info.jsp페이지 이동. 현재페이지 닫기
   비밀번호 수정 실패
       메세지 출력후 opener 페이지를 updateForm.jsp 페이지 이동
  현재페이지 닫기 --%>
<script>
alert("${msg}");
<c:if test="${opener}">
   opener.location.href="${url}";
</c:if>
<c:if test="${!opener}">
   location.href="${url}";
</c:if>
<c:if test="${closer}">
   self.close();
</c:if>
</script>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
