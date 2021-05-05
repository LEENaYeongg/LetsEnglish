<%@page import="model.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>비밀번호 찾기</title>
<script type="text/javascript">
   function win_close(){
      self.close();
   }
</script>
</head>
<body>
<table>
   <tr><th>비밀번호</th>
   <td>**${fn:substring(pw,2,fn:length(pw))}</td></tr>
   <tr><td colspan="2">
      <input type="button" value="닫기"
      onclick='win_close()'></td></tr>
</table>
</body>
</html>