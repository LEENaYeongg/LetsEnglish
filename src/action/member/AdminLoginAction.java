package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;

/*
 * 1. 로그아웃 상태: 로그인이 필요합니다 메시지 출력, loginForm.me 페이지 이동
 * 2. 로그인 상태: 일반 사용자 - 관리자만 가능한 거래입니다 메시지 출력, main.me 페이지 이동
 * 3. 관리자 로그인 상태: doExecute() 메소드 호출
 */

public abstract class AdminLoginAction implements Action {
	protected String login;

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		login = (String) request.getSession().getAttribute("login");
		if (login == null) {
			request.setAttribute("msg", "로그인이 필요합니다.");
			request.setAttribute("url", "loginForm.me");
			return new ActionForward(false, "../alert.jsp");
		} else if (!login.contentEquals("admin")) {
			request.setAttribute("msg", "관리자만 가능한 거래입니다.");
			request.setAttribute("url", "main.me");
			return new ActionForward(false, "../alert.jsp");
		} else // 관리자로 로그인
			return doExecute(request, response);
	}
	protected abstract ActionForward doExecute(HttpServletRequest request, HttpServletResponse response);
}