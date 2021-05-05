<%@page import="model.MemberDao"%>
<%@page import="model.Member"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>id 찾기</title>
<link rel="stylesheet" href="../../css/main.css">
<script type="text/javascript">
   function idsend(id){
      opener.document.f.id.value=id;
      self.close();
   }
</script>
</head>
<body>
<table>
   <tr><th>아이디</th>
   <td>${fn:substring(id,0,fn:length(id)-2)}**</td></tr>
   <tr><td colspan="2">
      <input type="button" value="아이디전송"
      onclick="idsend('${fn:substring(id,0,fn:length(id)-2)}')"></td></tr>
</table>
</body>
</html>