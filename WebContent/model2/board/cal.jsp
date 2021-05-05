<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.sql.*"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.Calendar"%>
<%
request.setCharacterEncoding("euc-kr");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

  <%
   //�����ͺ��̽��� �����ϴ� ���� ������ �����Ѵ�
  Connection conn= null;
  PreparedStatement pstmt = null;
   //�����ͺ��̽��� �����ϴ� ���� ������ ���ڿ��� �����Ѵ�.
  String jdbc_driver= "oracle.jdbc.driver.OracleDriver"; //JDBC ����̹��� Ŭ���� ���
  String jdbc_url= "jdbc:oracle:thin:@localhost:3307";  //�����Ϸ��� �����ͺ��̽��� ����
   //JDBC ����̹� Ŭ������ �ε��Ѵ�.
  Class.forName("org.mariadb.jdbc.Driver");
   //�����ͺ��̽� ���� ������ �̿��ؼ� Connection �ν��Ͻ��� Ȯ���Ѵ�.
  conn= DriverManager.getConnection("jdbc:mariadb://localhost:3307/lnydb","scott","1234");
  if (conn== null) {
   out.println("No connection is made!");
  }
  %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>��������</title>
<script type="text/javascript">
function inputcheck() {
	f = document.f;
	if(f.content.value==""){
		alert("������ �Է��ϼ���");
		f.name.focus();
		return;
	}
	
	f.submit();
}
</script>
<link rel = "stylesheet" href = "../css/main.css">
</head>

 <body>
<h3 style="text-align:center;">���� ����ǥ</h3>
<c:if test="${sessionScope.login=='admin'}"> 
<form action="calendar.do" method="post" name="f"> 
<table style="background-color:light-gray; margin-left: auto; margin-right: auto;">
<tr>
<td><input type="text" name="calyear" style="width:60px;">��</td>
<td><input type="text" name="calmonth" style="width:60px;">��</td>
<td><input type="text" name="calday" style="width:60px;">��</td>
<td><input type="text" name="calcontents">����</td>
<td><a href="javascript:inputcheck()">���� �߰�</a></td></tr>
</table>
</form>
</c:if>
<%
  java.util.Calendar cal=java.util.Calendar.getInstance(); //Calendar��ü cal����
  int currentYear=cal.get(java.util.Calendar.YEAR); //���� ��¥ ���
  int currentMonth=cal.get(java.util.Calendar.MONTH);
  int currentDate=cal.get(java.util.Calendar.DATE);
  String Year=request.getParameter("year"); //��Ÿ������ �ϴ� ��¥
  String Month=request.getParameter("month");
  int year, month;
  if(Year == null && Month == null){ //ó�� ȣ������ ��
  year=currentYear;
  month=currentMonth;
  }
  else { //��Ÿ������ �ϴ� ��¥�� ���ڷ� ��ȯ
   year=Integer.parseInt(Year);
   month=Integer.parseInt(Month);
   if(month<0) { month=11; year=year-1; } //1������ 12������ ���� ����.
   if(month>11) { month=0; year=year+1; }
  }
%>
  <center>
  <table border=0> <!-- �޷� ��� �κ�, �� ���� ����� ������? -->
   <tr>
    <td align=left width=200> <!-- �� ��-->
    <a href="cal.jsp?year=<%out.print(year-1);%>&month=<%out.print(month);%>">��</a>
    <% out.print(year); %>��
    <a href="cal.jsp?year=<%out.print(year+1);%>&month=<%out.print(month);%>">��</a>
    </td>
    <td align=center width=300> <!-- �� -->
    <a href="cal.jsp?year=<%out.print(year);%>&month=<%out.print(month-1);%>">��</a>
    <% out.print(month+1); %>��
    <a href="cal.jsp?year=<%out.print(year);%>&month=<%out.print(month+1);%>">��</a>
    </td>
    <td align=right width=200><% out.print(currentYear + "-" + (currentMonth+1) + "-" + currentDate); %></td>
   </tr>
  </table>
  <table border=1 cellspacing=0> <!-- �޷� �κ� -->
   <tr>
    <th width=100>��</th> <!-- ��=1 -->
    <th width=100>��</th> <!-- ��=2 -->
    <th width=100>ȭ</th> <!-- ȭ=3 -->
    <th width=100>��</th> <!-- ��=4 -->
    <th width=100>��</th> <!-- ��=5 -->
    <th width=100>��</th> <!-- ��=6 -->
    <th width=100>��</th> <!-- ��=7 -->
   </tr>
   <tr height=80>
   <%
   cal.set(year, month, 1); //���� ��¥�� ���� ���� 1�Ϸ� ����
   int startDay=cal.get(java.util.Calendar.DAY_OF_WEEK); //���糯¥(1��)�� ����
   int end=cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH); //�� ���� ������ ��
   int br=0; //7�ϸ��� �� �ٲٱ�
   for(int i=0; i<(startDay-1); i++) { //��ĭ���
    out.println("<td>&nbsp;</td>");
    br++;
    if((br%7)==0) {
     out.println("<br>");
    }
   }
   for(int i=1; i<=end; i++) { //��¥���
    out.println("<td>" + i + "<br>");
      //�޸�(����) �߰� �κ�
      int memoyear, memomonth, memoday;
      try{
        // select ������ ���ڿ� ���·� �����Ѵ�.
       String sql= "SELECT calyear, calmonth, calday, calcontents FROM calendar";
       pstmt= conn.prepareStatement(sql);
        // select �� �����ϸ� ������ ������ ResultSet Ŭ������ �ν��Ͻ��� ����
       ResultSet rs= pstmt.executeQuery();
       while (rs.next()) { // ������ �����ͱ��� �ݺ���.
        //��¥�� ������ ������ ���
        memoyear=rs.getInt("calyear");
        memomonth=rs.getInt("calmonth");
        memoday=rs.getInt("calday");
        if(year==memoyear && month+1==memomonth && i==memoday) {
         out.println("<b>"+rs.getString("calcontents")+"</b><br>"); 
        }
       }
       rs.close();
      }
      catch(Exception e) {
       System.out.println(e);
      };
    out.println("</td>");
    br++;
    if((br%7)==0 && i!=end) {
     out.println("</tr><tr height=80>");
    }
   }
   while((br++)%7!=0) //���� ���� ��ĭ���
    out.println("<td>&nbsp;</td>");
   %>
   </tr>
  </table>
  </center>       
 </body>
</html>
   <%
        //����� �ڿ��� �ݳ��Ѵ�.
       pstmt.close();
       conn.close();
   %>