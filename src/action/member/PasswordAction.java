package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.ActionForward;
import model.Member;
import model.MemberDao;
/*	2. pass, chgpass 파라미터 값 저장
	3. pass 비밀번호가 db에 저장된 비밀번호와 틀리면 비밀번호 오류 메시지 출력. passwordForm.jsp 페이지 이동
	4. pass 비밀번호가 db에 저장된 비밀번호와 같으면
		MemberDao.updatePass(login, chgpass) => 새로운 비밀번호로 수정
			비밀번호 수정 성공.
		메세지 출력 후 opener 페이지를 info.jsp 페이지 이동. 현재 페이지 닫기
			비밀번호 수정 실패.
		메시지 출력 후 opener 페이지를 updateForm.jsp 페이지 이동.
			현재 페이지 닫기
*/
public class PasswordAction extends UserLoginAction{

   @Override
   public ActionForward doExecute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      boolean opener = true;
      boolean closer = true;
      String msg = null;
      String url = null;
      String pass = request.getParameter("pass");
      String chgpass = request.getParameter("chgpass");
      MemberDao dao = new MemberDao();
      Member mem = dao.selectOne(login);
      if(pass.equals(mem.getPass())) {
         if(dao.updatePass(login, chgpass) > 0) {
            msg = "비밀번호가 변경되었습니다.";
            url = "info.me?id=" + login;
         } else {
            msg = "비밀번호 변경 시 오류가 발생 했습니다.";
            url = "updateForm.me?id=" + login;
         }
      } else { //비밀번호 오류
         opener = false;
         closer = false;
         msg = "비밀번호 오류입니다. 확인하세요.";
         url = "passwordForm.me";
      }
      request.setAttribute("msg", msg);
      request.setAttribute("url", url);
      request.setAttribute("opener", opener);
      request.setAttribute("closer", closer);
         
      return new ActionForward();
   }

}