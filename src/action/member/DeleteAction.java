package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.ActionForward;
import model.Member;
import model.MemberDao;
import model.Score;
import model.ScoreDao;

/*
 *  3. id가 관리자인 경우 탈퇴 불가. list.me 페이지 이동.
      4. 비밀번호 검증. 
                관리자가 강제 탈퇴인 경우 : 관리자 비밀번호로 검증.
                             일반사용자의 탈퇴인 경우 : 본인 비밀번호로 검증 
                 비밀번호 불일치 : "비밀번호가 틀림" 출력. deleteForm.me 페이지 이동.
      5. db에서 delete 실행
             int MemberDao.delete(id) 메서드 호출
                탈퇴 성공 : member db에서 delete 처리 완료
                 - 일반사용자 : 로그아웃 실행. 삭제 성공 메세지 출력.   loginForm.me 페이지 이동.
                 - 관리자 : 삭제 성공 메세지 출력. list.me 페이지 이동. 
                            탈퇴 실패 : member db에서 delete 처리시 오류발생
                 - 일반사용자 : 탈퇴 실패 메세지 출력. info.me 페이지 이동.
                 - 관리자 : 삭제 살패 메세지 출력. list.me 페이지 이동.  
 */
public class DeleteAction extends UserLoginAction{

   @Override
   public ActionForward doExecute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      if(id.equals("admin")) {
         request.setAttribute("msg", "관리자는 탈퇴할 수 없습니다.");
         request.setAttribute("url", "main.me");
         return new ActionForward(false,"../alert.jsp");
      }
      String pass = request.getParameter("pass");
      String msg = null;
      String url = null;
      if(login.equals("admin")) { //관리자 로그인. 관리자의 비밀번호
         url ="list.me";
      }else { //일반 사용자 로그인
         url="loginForm.me";
      }
      Score dbscore = null;
      Member dbmem = null;
      MemberDao dao = new MemberDao();
      ScoreDao sdao =new ScoreDao();
      dbmem = dao.selectOne(login);
      if(pass.equals(dbmem.getPass())) { //비밀번호 일치
         if(dao.delete(id) > 0) {
        	 if(sdao.delete(id) > 0) {
            if(login.equals("admin")) {
               msg =id + "사용자를 강제 탈퇴 성공";
            }else {
               msg =id + "님의 회원 탈퇴가 완료되었습니다.";
               request.getSession().invalidate(); //로그아웃
            }
        	 }
         }else { //탈퇴실패
            msg = id + "님의 탈퇴시 오류 발생";
            if(!login.equals("admin")) {
               url ="info.me?id=" + id;
            }
         }
      }else {
         msg = login + "님의 비밀번호가 틀립니다.";
         url ="deleteForm.me?id=" + id;
      }
      request.setAttribute("msg", msg);
      request.setAttribute("url", url);
      return new ActionForward(false,"../alert.jsp");
   }

}