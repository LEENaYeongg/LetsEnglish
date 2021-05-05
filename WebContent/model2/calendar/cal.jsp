<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
String sYear = request.getParameter("year");
String sMonth = request.getParameter("month");

Calendar cal = Calendar.getInstance();

	int nowYear = cal.get(Calendar.YEAR); 
	int nowMonth = cal.get(Calendar.MONTH) + 1;
	int nowDay = cal.get(Calendar.DAY_OF_MONTH);

	int selectYear = nowYear;
	int selectMonth = nowMonth;

	if (sYear != null || sMonth != null){
		selectYear = Integer.parseInt(sYear);
		selectMonth = Integer.parseInt(sMonth);
	}

   String yOptions="";
   
   for(int year=(selectYear-10); year<=(selectYear+10); year++){ 
      if(sYear==null && year==nowYear) {
         yOptions += "<option value='"+year+"'selected='selected'>"+year+"</option>";
      }else if(sYear!=null && Integer.parseInt(sYear)==year){
         yOptions += "<option value='"+year+"'selected='selected'>"+year+"</option>";
      }else{
         yOptions += "<option value='"+year+"'>"+year+"</option>";   
      }
   }
   String mOptions = "";
   for(int month=1; month<=12; month++){
      if(sMonth==null && month==nowMonth){
         mOptions += "<option value='"+month+"'selected='selected'>"+month+"</option>";
      }else if(sMonth!=null &&Integer.parseInt(sMonth)==month) {
         mOptions += "<option value='"+month+"'selected='selected'>"+month+"</option>";
      } else{   
         mOptions += "<option value='"+month+"'>"+month+"</option>";
      }
   }
   int [] months = {31,28,31,30,31,30,31,31,30,31,30,31};
   if(selectYear%4==0 && selectYear%100!=0 || selectYear%400==0) {
      months[1]=29;
   }

   int nalsu;

   String[] weekName = {"일요일","월요일","화요일","수요일","목요일","금요일","토요일"};
   nalsu = (selectYear-1)*365 + (selectYear-1)/4 - (selectYear-1)/100 + (selectYear-1)/400;

   for(int i=0; i<selectMonth-1; i++){
      nalsu += months[i];
   }
   nalsu ++;
 
   int week = nalsu%7;   //-- 요일 변수
   int lastDay = months[selectMonth-1];
   
   String calStr = "";
   calStr += "<table border=1>";
   calStr += "<tr>";
   for(int i=0; i<weekName.length; i++){
      if(i==0){
         calStr += "<th style='color:red;'>" + weekName[i] + "</th>";
      } else if(i==6){
         calStr += "<th style='color:blue;'>" + weekName[i] + "</th>";
      }else {
         calStr += "<th>" + weekName[i] + "</th>";
      }
   }
   
   calStr +="</tr>";
   calStr += "<tr>";

   for(int i=1; i<=week; i++) {
      calStr += "<td></td>";
   }
   for(int i =1; i<=lastDay; i++){
      week++;

      if(selectYear ==nowYear && selectMonth==nowMonth && i ==nowDay&& week%7==0){
         calStr += "<td class='nowSat' >"+i+"</td>";
      }else if(selectYear ==nowYear && selectMonth==nowMonth && i ==nowDay&& week%7==1){
         calStr += "<td class='nowSun' >"+i+"</td>";
      }else if(selectYear ==nowYear && selectMonth==nowMonth && i ==nowDay){
         calStr += "<td class='now' >"+i+"</td>";
      }else if(week%7==0){
         calStr += "<td class='sat' >"+i+"</td>";
      }else if(week%7==1){
         calStr += "<td class='sun' >"+i+"</td>";
      }
    //오늘이 아닌 평일
      else {
         calStr += "<td>"+i+"</td>";
      }
      if(week%7 ==0)
         calStr += "</tr><tr>";
   }
   for(int i=1; i<=week; i++,week++){	
	   if(week%7==0){
		   break;
	   }
	   calStr+="<td></td>";   
   }
   
   calStr +="</tr>";
   calStr +="</table>";  
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시험 일정</title>
<link rel="stylesheet" type ="text/css" href="css/main.css">
<style type="text/css">
	td{text-align:right;}
	td.now{background-color:aqua; font-weight:bold;}
	td.nowSun{background-color:aqua; font-weight:bold; color:red;}
	td.nowSat{background-color:aqua; font-weight:bold; color:blue;}
	td.sun{color:red;}
	td.sat{color:blue;}
</style>

<script type="text/javascript">
function formCalendar(obj){      
      obj.submit();
}  
</script>
</head>
<body>
   <div>
   <h3>시험 일정 출력</h3>
   </div>
   <div>
   <form action="" method="post">
      <select id="year" name ="year" onchange="formCalendar(this.form)">
      <%=yOptions %>
      </select>년
      <select id="month" name="month" onchange="formCalendar(this.form)">
      <%=mOptions %>
      </select>월
   </form>
   </div>

<div>

<%=calStr %>
</div>
</body>
</html>