<%@page import="model.MemberDao"%>
<%@page import="model.Member"%>
<%@page import="model.ScoreDao"%>
<%@page import="model.Score"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%-- WebContent/model1/member/update.jsp
		1. ��� �Ķ���� ������ Member ��ü�� ���� => useBeam �±�
		2. �Էµ� ��й�ȣ��, db�� ����� ��й�ȣ ��
			- �������� ��� ������ ��й�ȣ�� ���ϱ�.
			- ���� ���� ��� : "��й�ȣ ����" �޽��� ��� updateForm.jsp ������ �̵�
		3. �Ķ���͸� �����ϰ� �ִ� Member ��ü�� �̿��Ͽ� db ���� ����.
			int MemberDao.update(Member)
			����� 0 ���ϸ� �������� �޽��� �����, updateForm.jsp ������ �̵�
			    1 �̻��̸� ���� ���� info.jsp ������ �̵�    
--%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<jsp:useBean id="mem" class="model.Member" />
<jsp:setProperty property="*" name="mem" />
<jsp:useBean id="sco" class="model.Score" />
<jsp:setProperty property="*" name="sco" />
<%
	MemberDao dao = new MemberDao();
	String login = (String) session.getAttribute("login");
	//��й�ȣ ������ ���� db ���� ��ȸ
	Member dbmem = null;
	if (login.equals("admin"))//������ �α���
		dbmem = dao.selectOne(login);
	else //�Ϲݻ���� �α���
		dbmem = dao.selectOne(mem.getId());
	
	String msg = "��й�ȣ�� Ʋ�Ƚ��ϴ�.";
	String url = "updateForm.jsp?id=" + mem.getId();
	if (login.equals("admin") || //������ �α���.
			mem.getPass().equals(dbmem.getPass())) {//��й�ȣ�� ���� ���. �α��� ����
		int result = dao.update(mem); //�Էµ� ������ db�� ����.
		if (result > 0) {
			msg = "��������";
			url = "info.jsp?id=" + mem.getId();
		} else {
			msg = "��������";
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
<title>ȸ�� ����</title>
</head>
<body>


</body>
</html>
