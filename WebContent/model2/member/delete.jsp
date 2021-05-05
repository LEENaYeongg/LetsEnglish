<%@page import="model.MemberDao"%>
<%@page import="model.Member"%>
<%@page import="model.ScoreDao" %>
<%@page import="model.Score"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%-- delete.jsp 완성하기
      1. 로그아웃 상태 : "로그인하세요" 출력. loginForm.jsp 페이지 이동
      2. 일반사용자
             - id 파라미터 정보와, login 정보가 다른경우
               "본인만 탈퇴 가능합니다.". main.jsp 페이지 이동
      3. id가 관리자인 경우 탈퇴 불가. list.jsp 페이지 이동.
      4. 비밀번호 검증. 
           	  관리자가 강제 탈퇴인 경우 : 관리자 비밀번호로 검증.
                             일반사용자의 탈퇴인 경우 : 본인 비밀번호로 검증 
           	   비밀번호 불일치 : "비밀번호가 틀림" 출력. deleteForm.jsp 페이지 이동.
      5. db에서 delete 실행
             int MemberDao.delete(id) 메서드 호출
           	  탈퇴 성공 : member db에서 delete 처리 완료
                 - 일반사용자 : 로그아웃 실행. 삭제 성공 메세지 출력.   loginForm.jsp 페이지 이동.
                 - 관리자 : 삭제 성공 메세지 출력. list.jsp 페이지 이동. 
                            탈퇴 실패 : member db에서 delete 처리시 오류발생
                 - 일반사용자 : 탈퇴 실패 메세지 출력. info.jsp 페이지 이동.
                 - 관리자 : 삭제 살패 메세지 출력. list.jsp 페이지 이동.  
  --%>
<%
	String login = (String) session.getAttribute("login");
	//탈퇴 아이디 정보. id, pass 파라미터

	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	String msg = null;
	String url = null;

	if (login == null) {
		msg = "로그인이 필요합니다.";
		url = "loginForm.jsp";
	} else if (!login.equals(id) && !login.equals("admin")) {
		msg = "본인만 탈퇴가 가능합니다.";
		url = "main.jsp";
	} else if (id.equals("admin")) {//탈퇴 대상이 되는 회원은 관리자 안됨.
		msg = "관리자는 탈퇴할 수 없습니다.";
		url = "list.jsp";
	} else {//탈퇴거래 가능.
		Member dbmem = null;
		Score dbsco = null;
		MemberDao dao = new MemberDao();

		if (login.equals("admin")) {//관리자 로그인. 관리자의 비밀번호
			dbmem = dao.selectOne(login); //관리자 정보
			url = "list.jsp";
		} else {
			dbmem = dao.selectOne(id);//일반사용자 로그인
			url = "loginForm.jsp";
		}
		//pass : 입력 비밀번호
		//dbmem.getPass() : db에 저장된 비밀번호
		if (pass.equals(dbmem.getPass())) { //비밀번호 일치
			if (dao.delete(id) > 0) {//탈퇴 성공
				if(dao.delete(id) >0) {
				if (login.equals("admin")) {
					msg = id + "사용자를 강제 탈퇴 성공";
				} else {
					msg = id + "님의 회원 탈퇴가 완료되었습니다.";
					session.invalidate(); //session의 로그인 정보 제거
				}
				
			} else { //탈퇴 실패
				msg = id + "님의 탈퇴시 오류 발생.";
				if (!login.equals("admin")) {
					url = "info.jsp?id=" + id;
					}
				}
			}
		} else { //비밀번호 불일치
			msg = id + "님의 비밀번호가 틀립니다.";
			url = "deleteForm.jsp?id=" + id;
		}
	}
%>
<script>
alert("<%=msg%>")
location.href="<%=url%>";
</script>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원 삭제</title>
</head>
<body>
</body>
</html>