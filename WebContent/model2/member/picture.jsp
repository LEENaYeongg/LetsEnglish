<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%-- /WebContent/model2/member/picture.jsp
3. opener 화면에 결과 전달 =>javascript
4. 현재 화면 close() =>javascript
 --%>
<script type="text/javascript">
	img = opener.document.getElementById("pic"); //내가 선택한 이미지의 이름이 출력
	img.src = "picture/${fname}";
	//db 저장을위한 파라미터 설정
	opener.document.f.picture.value = "${fname}";
	self.close();
</script>
