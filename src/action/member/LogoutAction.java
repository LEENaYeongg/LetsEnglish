package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
/*
 * 1. session 로그인 정보 제거.
   2. 로그아웃하셨습니다. 메시지 출력 후 loginForm.jsp 페이지 이동
 * */
public class LogoutAction implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.getSession().invalidate();
		request.setAttribute("msg", "로그아웃하셨습니다.");
		request.setAttribute("url", "loginForm.me");
		return new ActionForward(false,"../alert.jsp");
	}

}
