<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ���� ����</title>
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
<p>${sessionScope.login}�� �� ��������Ʈ:${scorecount}</p>
<form action="scorechart.do" method="post" name="sf">
<div style="display : flex; justify-content: center;">
<input type="hidden" name="id" value="${sessionScope.login}">
<input type="hidden" name="pageNum" value="1">
<!-- <select name="bttype">
<option value="">�����ϼ���</option>
<option value="1">����</option>
<option value="2">����</option>
<option value="3">�佺</option>
<option value="4">���̿���</option>
</select> -->
<!-- <input type="submit" value="ã��"> -->
</div>
</form>

<table class="w3-table-all">
<c:if test="${scorecount ==0}">
   <tr><td colspan = "4">��ϵ� ������ �����ϴ�.</td></tr>
</c:if>
<c:if test="${scorecount >0}">
   <tr><th width = "8%">��ȣ</th><th width="10%">����</th>
      <th width="10%">����</th><th width="17%">�����</th></tr>
 
<c:forEach var="s" items="${slist}">
<a href="scorechart.do?id=${sessionScope.login}"></a>

<%-- ��ȣ ��� --%>
<tr><td>${boardnum}</td>
   <c:set var="boardnum" value="${boardnum-1}"/>
      
<%-- ���� ��� --%>
    <td><c:if test="${s.ttype == 1}">����</c:if>
		<c:if test="${s.ttype == 2}">����</c:if>
		<c:if test="${s.ttype == 3}">�佺</c:if>
		<c:if test="${s.ttype == 4}">���̿���</c:if>
		<c:if test="${s.ttype == 5}">��Ÿ</c:if></td>
      
<%-- ���� ��� --%>
      <td>${s.score}</td>
      
<%-- ��ϵ� ���� ��¥ format��� ����ϱ� --%>
    <td><fmt:formatDate value="${s.tdate}" pattern="yyyy-MM-dd" /></td>
</c:forEach>

   <tr><td colspan = "4" style="text-align:center;"><%-- ������ ó���ϱ� --%>
      <c:if test="${pageNum <= 1 }">[����]</c:if>
      <c:if test="${pageNum > 1 }">
      <a href="javascript:scorechartdo(${pageNum -1 })">[����]</a></c:if>
      
      <c:forEach var="a" begin="${startpage}" end="${endpage}">
         <c:if test="${a==pageNum}">[ ${a} ]</c:if>
         <c:if test="${a!=pageNum}">
         <a href = "javascript:scorechartdo(${a})">[ ${a} ]</a></c:if>
      </c:forEach>
      
      <c:if test="${pageNum >= maxpage }">[����]</c:if>
      <c:if test="${pageNum < maxpage }">
      <a href="javascript:scorechartdo(${pageNum +1 })">[����]</a>
      </c:if>
      </td></tr>
   </c:if>
   <tr><td colspan = "4" style="text-align:right">
      <a href = "addForm.do?id=${sessionScope.login}">[�߰�]</a></td></tr>

</table>
<p>���� �� ���� ����</p>
<script type="text/javascript"
src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>
<script>
var randomColorFactor = function(){
    return Math.round(Math.random() * 255);
}
var randomColor = function(opacity){ //opacity : ����
      return "rgba("+randomColorFactor()+"," //rgba(0 ~ 255 ������ ��)
            + randomColorFactor() +","
            + randomColorFactor() +","
            + (opacity || '.3')+")";
}
$(function(){ //������ �Ϸ�Ǹ�
   bargraph();
})
function bargraph(){
   $.ajax("${path}/model2/ajax/graph2.do",{
      success : function(data){
         barGraphPrint(data);
      },
      error : function(e){
         alert("���� ����:"+ e.status);
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
	         label:'�Ǽ�',
	         fill : false,
	         data : datas,
	      },{
	         type : 'bar',
	         label : '�Ǽ�',
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
	               text :'�ֱ� 7�� �Խ��� ��� �Ǽ�',
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