<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.sql.*"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@page import="java.util.Calendar"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
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
<title>���� ȭ��</title>
<link rel = "stylesheet" href = "../css/main.css">
<style>
b{
    font-size: 10px;
}
</style>
</head>
<body>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>
<script>
var randomColorFactor = function() { //���� �������� 
	return Math.round(Math.random() * 255); //0~255 ������ ��
}
var randomColor = function(opa) {
	return "rgba(" + randomColorFactor() + "," //ù��° ����(R)�ϴ� ��
			+ randomColorFactor() + "," //�ι�° ����(G)�ϴ� ��
			+ randomColorFactor() + "," //����° ����(B)�ϴ� ��
			+ (opa || '.3') + ")"; //���� ����
}
$(function() { //������ �غ� �Ϸ�Ǹ� ȣ��Ǵ� �κ�
	piegraph(); //���� �غ� �Ϸ�Ǹ� ���� �׷���  ȣ��
})
function piegraph() {
	$.ajax("${path}/model2/ajax/graph.do",{ //��û���� �� (.do : ���� ȣ����)
		success : function(data) {
			pieGraphPrint(data);
		},
		error : function(e) {
			alert("��������:" + e.status);
		}
	})
}
function pieGraphPrint(data) {
	var rows = JSON.parse(data);
	var ttypes = []
	var datas = []
	var colors = []
	$.each(rows,function(index,item){
		ttypes[index] = item.ttype;
		datas[index] = item.cnt;
		colors[index] = randomColor(0.7);
	})
	var config = {
		type : 'pie',
		data : {
			datasets : [{
				data : datas,
				backgroundColor:colors
			}],
			labels : ttypes
//			labels : ['����', '����', '�佺', '���̿���']
		},
		options : {
			responsive : true,
			legend : {position: 'top'},
			title : {
				display : true,
				text : '���� ���� �� �Ǽ�',
				position : 'bottom'
			}
		}
	}
	var ctx = document.getElementById("canvas1").getContext("2d");
	new Chart(ctx,config);
}
</script> 
<script type="text/javascript">
function formCalendar(obj){      
      obj.submit();
   }
</script>
<div class="w3-half">
<div class="w3-container w3-padding-16">
<div id="piecontainer" style="width:400px; border:1px solid #ffffff; margin-top:85px;">
<canvas id="canvas1"></canvas>
</div>
</div>
</div>
<div class="w3-half">
<div class="w3-container w3-padding-16">
<form id ="canvas2" action="" method="post">
<h3 style="text-align:center;">�̹� �� ���� ����ǥ</h3>
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
    <td align=left width=100> <!-- �� ��-->
    <a href="cal.jsp?year=<%out.print(year-1);%>&month=<%out.print(month);%>"></a>
    <% out.print(year); %>��
    <a href="cal.jsp?year=<%out.print(year+1);%>&month=<%out.print(month);%>"></a>
    </td>
    <td align=center width=100> <!-- �� -->
    <a href="cal.jsp?year=<%out.print(year);%>&month=<%out.print(month-1);%>"></a>
    <% out.print(month+1); %>��
    <a href="cal.jsp?year=<%out.print(year);%>&month=<%out.print(month+1);%>"></a>
    </td>
    <td align=right width=90><% out.print(currentYear + "-" + (currentMonth+1) + "-" + currentDate); %></td>
   </tr>
  </table>
  <table border=1 cellspacing=0> <!-- �޷� �κ� -->
   <tr>
    <th width=140>��</th> <!-- ��=1 -->
    <th width=140>��</th> <!-- ��=2 -->
    <th width=140>ȭ</th> <!-- ȭ=3 -->
    <th width=140>��</th> <!-- ��=4 -->
    <th width=140>��</th> <!-- ��=5 -->
    <th width=140>��</th> <!-- ��=6 -->
    <th width=140>��</th> <!-- ��=7 -->
   </tr>
   <tr height=30>
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
     out.println("</tr><tr height=60>");
    }
   }
   while((br++)%7!=0) //���� ���� ��ĭ���
    out.println("<td>&nbsp;</td>");
   %>
   </tr>
  </table>
  </center>       
   </form>

</div>
</div>

</body>
</html>
<%
//����� �ڿ��� �ݳ��Ѵ�.
   pstmt.close();
   conn.close();
%>