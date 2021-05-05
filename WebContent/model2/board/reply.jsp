<%@page import="model.BoardDao"%>
<%@page import="model.Board"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%-- /WebContent/model1/board/reply.jsp : 답글 등록
    1. 파라미터 값을 Board 객체에 저장하기 => useBean 태그 사용.
    	원글정보 : num, grp, grplevel, grpstep
    	답글정보 : name, pass, subject, content => 등록 정보
    2. 같은 grp 값을 사용하는 게시물들의 grpstep 값을 1 증가하기.
    	void BoardDao.grpStepAdd(grp,grpstep)
    3. Board 객체를 db에 insert 하기.
    	num : maxnum +1
    	grp : 원글과 동일.
    	grplevel : 원글 +1
    	grpstep : 원글 +1
    4. 등록 성공시: "답변 등록 완료" 메시지 출력 후, list.jsp 페이지로 이동
                등록 실패시 : "답변 등록시 오류발생" 메시지 출력 후, replyForm.jsp 페이지로 이동
--%>
<!DOCTYPE html>
<%
	request.setCharacterEncoding("euc-kr");
%>
<jsp:useBean id="b" class="model.Board" />
<jsp:setProperty name="b" property="*" />
<%-- 
	b객체 파라미터 정보
		num : 원글의 num 정보
		grp : 원글의 grp 정보
		grplevel : 원글의 grplevel 정보 
		grpstep : 원글의 grpstep 정보
		
		name : 글쓴이 정보
		pass : 입력된 비밀번호 정보
		subject : 입력된 제목 정보
		content : 입력된 내용 정보
--%>
<%
	BoardDao dao = new BoardDao();
	//현재 등록된 답글이 원글 바로 아래 출력되도록 기존의 grpstep을 +1씩 증가.
	dao.grpStepAdd(b.getGrp(), b.getGrpstep());
	int grplevel = b.getGrplevel();
	int grpstep = b.getGrpstep();
	int num = dao.maxnum(); //최대 num값 조회
	String msg = "답변등록시 오류 발생";
	String url = "replyForm.jsp?num=" + b.getNum() + "&btype="+b.getBtype();
	b.setNum(++num); //답변글의 num 값. grp 값은 원글과 동일
	b.setGrplevel(grplevel + 1); //원글+1
	b.setGrpstep(grpstep + 1); //원글 +1
	if (dao.insert(b)) {
		msg = "답변등록 완료";
		url = "list.jsp?btype="+b.getBtype();
	}
%>
<script>
alert("<%=msg%>");
location.href="<%=url%>";
</script>
<html>
<head>
<meta charset="EUC-KR">
<title>답글 등록</title>
</head>
<body>

</body>
</html>