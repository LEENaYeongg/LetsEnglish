package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.ActionForward;
import model.Member;
import model.MemberDao;
import model.Score;
import model.ScoreDao;

public class InfoAction extends UserLoginAction {
	@Override
	public ActionForward doExecute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Member mem = new MemberDao().selectOne(id);
		Score sco = new ScoreDao().selectOne(id);
		request.setAttribute("mem", mem);
		request.setAttribute("sco", sco);
		return new ActionForward();
	}
}
