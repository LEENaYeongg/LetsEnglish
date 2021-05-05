<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>종목별 시험 성적</title>
<link rel = "stylesheet" href="../../css/main.css">
<script type="text/javascript">
function scorechartdo(page){
	f = document.sf;
	f.pageNum.value=page;
	f.submit();
}
</script>
</head>
<body>
<p>${sessionScope.login}님 의 성적리스트:${scorecount}</p>
<form action="scorechart.do" method="post" name="sf">
<div style="display : flex; justify-content: center;">
<input type="hidden" name="id" value="${sessionScope.login}">
<input type="hidden" name="pageNum" value="1">
<!-- <select name="bttype">
<option value="">선택하세요</option>
<option value="1">토익</option>
<option value="2">토플</option>
<option value="3">토스</option>
<option value="4">아이엘츠</option>
</select> -->
<!-- <input type="submit" value="찾기"> -->
</div>
</form>

<table class="w3-table-all">
<c:if test="${scorecount ==0}">
   <tr><td colspan = "4">등록된 점수가 없습니다.</td></tr>
</c:if>
<c:if test="${scorecount >0}">
   <tr><th width = "8%">번호</th><th width="10%">구분</th>
      <th width="10%">점수</th><th width="17%">등록일</th></tr>
 
<c:forEach var="s" items="${slist}">
<a href="scorechart.do?id=${sessionScope.login}"></a>

<%-- 번호 출력 --%>
<tr><td>${boardnum}</td>
   <c:set var="boardnum" value="${boardnum-1}"/>
      
<%-- 구분 출력 --%>
    <td><c:if test="${s.ttype == 1}">토익</c:if>
		<c:if test="${s.ttype == 2}">토플</c:if>
		<c:if test="${s.ttype == 3}">토스</c:if>
		<c:if test="${s.ttype == 4}">아이엘츠</c:if>
		<c:if test="${s.ttype == 5}">기타</c:if></td>
      
<%-- 점수 출력 --%>
      <td>${s.score}</td>
      
<%-- 등록된 시험 날짜 format대로 출력하기 --%>
    <td><fmt:formatDate value="${s.tdate}" pattern="yyyy-MM-dd" /></td>
</c:forEach>

   <tr><td colspan = "4" style="text-align:center;"><%-- 페이지 처리하기 --%>
      <c:if test="${pageNum <= 1 }">[이전]</c:if>
      <c:if test="${pageNum > 1 }">
      <a href="javascript:scorechartdo(${pageNum -1 })">[이전]</a></c:if>
      
      <c:forEach var="a" begin="${startpage}" end="${endpage}">
         <c:if test="${a==pageNum}">[ ${a} ]</c:if>
         <c:if test="${a!=pageNum}">
         <a href = "javascript:scorechartdo(${a})">[ ${a} ]</a></c:if>
      </c:forEach>
      
      <c:if test="${pageNum >= maxpage }">[다음]</c:if>
      <c:if test="${pageNum < maxpage }">
      <a href="javascript:scorechartdo(${pageNum +1 })">[다음]</a>
      </c:if>
      </td></tr>
   </c:if>
   <tr><td colspan = "4" style="text-align:right">
      <a href = "addForm.do?id=${sessionScope.login}">[추가]</a></td></tr>

</table>
<p>종목 별 시험 성적</p>
<script type="text/javascript"
src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>
<script>
var randomColorFactor = function(){
    return Math.round(Math.random() * 255);
}
var randomColor = function(opacity){ //opacity : 투명도
      return "rgba("+randomColorFactor()+"," //rgba(0 ~ 255 사이의 수)
            + randomColorFactor() +","
            + randomColorFactor() +","
            + (opacity || '.3')+")";
}
$(function(){ //문서가 완료되면
   bargraph();
})
function bargraph(){
   $.ajax("${path}/model2/ajax/graph2.do",{
      success : function(data){
         barGraphPrint(data);
      },
      error : function(e){
         alert("서버 오류:"+ e.status);
   }
})
}
function barGraphPrint(data){
	   var rows = JSON.parse(data); 
	   var regdates = [] //[2020-12-24,2020-12-23]
	   var datas = [] //[2,7]
	   var colors = []
	   $.each(rows,function(index,item){
	      regdates[index] = item.regdate;
	      datas[index] = item.cnt;
	      colors[index]= randomColor(0.7);
	   })
	   var chartData = {
	      labels : regdates,
	      datasets : [{
	         type : 'line',
	         borderWidth : 2,
	         borderColor:colors,
	         label:'건수',
	         fill : false,
	         data : datas,
	      },{
	         type : 'bar',
	         label : '건수',
	         backgroundColor : colors,
	         data : datas
	      }]
	   }
	   var config = {
	      type : 'bar',
	      data : chartData,
	      options :{
	         responsive : true,
	         title : {display:true,
	               text :'최근 7일 게시판 등록 건수',
	               position :'bottom'
	         },
	         legend :{display :false},
	         scales:{
	            xAxes:[{ display : true,  stacked : true }],
	            yAxes:[{ display : true,  stacked : true }]
	         }
	      }
	   }
	   var ctx = document.getElementById("canvas2").getContext("2d");
	   new Chart(ctx,config);
	}
</script>
<div class="w3-half">
<div class="w3-container w3-padding-16">
<div id="piecontainer"
style="width:80%; border:1px solid #ffffff">
<canvas id="canvas1" style="width:100%;"></canvas>
</div>
</div>   
  </div>
<div class="w3-half">
<div class="w3-container w3-padding-16">
<div id="barcontainer"
style="width:80%; border:1px solid #ffffff">
<canvas id="canvas2" style="width:100%;"></canvas>
</div>
</div>
</div>
</body>
</html>