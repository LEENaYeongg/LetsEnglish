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
   //데이터베이스를 연결하는 관련 변수를 선언한다
  Connection conn= null;
  PreparedStatement pstmt = null;
   //데이터베이스를 연결하는 관련 정보를 문자열로 선언한다.
  String jdbc_driver= "oracle.jdbc.driver.OracleDriver"; //JDBC 드라이버의 클래스 경로
  String jdbc_url= "jdbc:oracle:thin:@localhost:3307";  //접속하려는 데이터베이스의 정보
   //JDBC 드라이버 클래스를 로드한다.
  Class.forName("org.mariadb.jdbc.Driver");
   //데이터베이스 연결 정보를 이용해서 Connection 인스턴스를 확보한다.
  conn= DriverManager.getConnection("jdbc:mariadb://localhost:3307/lnydb","scott","1234");
  if (conn== null) {
   out.println("No connection is made!");
  }
  %>
<html>
<head>
<title>메인 화면</title>
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
var randomColorFactor = function() { //색깔 랜덤으로 
	return Math.round(Math.random() * 255); //0~255 임의의 값
}
var randomColor = function(opa) {
	return "rgba(" + randomColorFactor() + "," //첫번째 설정(R)하는 값
			+ randomColorFactor() + "," //두번째 설정(G)하는 값
			+ randomColorFactor() + "," //세번째 설정(B)하는 값
			+ (opa || '.3') + ")"; //투명도 결정
}
$(function() { //문서가 준비가 완료되면 호출되는 부분
	piegraph(); //문서 준비 완료되면 파일 그래프  호출
})
function piegraph() {
	$.ajax("${path}/model2/ajax/graph.do",{ //요청값이 들어감 (.do : 나를 호출해)
		success : function(data) {
			pieGraphPrint(data);
		},
		error : function(e) {
			alert("서버오류:" + e.status);
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
//			labels : ['토익', '토플', '토스', '아이엘츠']
		},
		options : {
			responsive : true,
			legend : {position: 'top'},
			title : {
				display : true,
				text : '시험 종목 별 건수',
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
<h3 style="text-align:center;">이번 달 시험 일정표</h3>
  <%
  java.util.Calendar cal=java.util.Calendar.getInstance(); //Calendar객체 cal생성
  int currentYear=cal.get(java.util.Calendar.YEAR); //현재 날짜 기억
  int currentMonth=cal.get(java.util.Calendar.MONTH);
  int currentDate=cal.get(java.util.Calendar.DATE);
  String Year=request.getParameter("year"); //나타내고자 하는 날짜
  String Month=request.getParameter("month");
  int year, month;
  if(Year == null && Month == null){ //처음 호출했을 때
  year=currentYear;
  month=currentMonth;
  }
  else { //나타내고자 하는 날짜를 숫자로 변환
   year=Integer.parseInt(Year);
   month=Integer.parseInt(Month);
   if(month<0) { month=11; year=year-1; } //1월부터 12월까지 범위 지정.
   if(month>11) { month=0; year=year+1; }
  }
  %>
  <center>
  <table border=0> <!-- 달력 상단 부분, 더 좋은 방법이 없을까? -->
   <tr>
    <td align=left width=100> <!-- 년 도-->
    <a href="cal.jsp?year=<%out.print(year-1);%>&month=<%out.print(month);%>"></a>
    <% out.print(year); %>년
    <a href="cal.jsp?year=<%out.print(year+1);%>&month=<%out.print(month);%>"></a>
    </td>
    <td align=center width=100> <!-- 월 -->
    <a href="cal.jsp?year=<%out.print(year);%>&month=<%out.print(month-1);%>"></a>
    <% out.print(month+1); %>월
    <a href="cal.jsp?year=<%out.print(year);%>&month=<%out.print(month+1);%>"></a>
    </td>
    <td align=right width=90><% out.print(currentYear + "-" + (currentMonth+1) + "-" + currentDate); %></td>
   </tr>
  </table>
  <table border=1 cellspacing=0> <!-- 달력 부분 -->
   <tr>
    <th width=140>일</th> <!-- 일=1 -->
    <th width=140>월</th> <!-- 월=2 -->
    <th width=140>화</th> <!-- 화=3 -->
    <th width=140>수</th> <!-- 수=4 -->
    <th width=140>목</th> <!-- 목=5 -->
    <th width=140>금</th> <!-- 금=6 -->
    <th width=140>토</th> <!-- 토=7 -->
   </tr>
   <tr height=30>
   <%
   cal.set(year, month, 1); //현재 날짜를 현재 월의 1일로 설정
   int startDay=cal.get(java.util.Calendar.DAY_OF_WEEK); //현재날짜(1일)의 요일
   int end=cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH); //이 달의 끝나는 날
   int br=0; //7일마다 줄 바꾸기
   for(int i=0; i<(startDay-1); i++) { //빈칸출력
    out.println("<td>&nbsp;</td>");
    br++;
    if((br%7)==0) {
     out.println("<br>");
    }
   }
   for(int i=1; i<=end; i++) { //날짜출력
    out.println("<td>" + i + "<br>");
      //메모(일정) 추가 부분
      int memoyear, memomonth, memoday;
      try{
        // select 문장을 문자열 형태로 구성한다.
       String sql= "SELECT calyear, calmonth, calday, calcontents FROM calendar";
       pstmt= conn.prepareStatement(sql);
        // select 를 수행하면 데이터 정보가 ResultSet 클래스의 인스턴스로 리턴
       ResultSet rs= pstmt.executeQuery();
       while (rs.next()) { // 마지막 데이터까지 반복함.
        //날짜가 같으면 데이터 출력
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
   while((br++)%7!=0) //말일 이후 빈칸출력
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
//사용한 자원을 반납한다.
   pstmt.close();
   conn.close();
%>