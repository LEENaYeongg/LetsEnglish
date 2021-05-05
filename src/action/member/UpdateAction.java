package action.member;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.ActionForward;
import model.Member;
import model.MemberDao;
import model.Score;
import model.ScoreDao;

public class UpdateAction extends UserLoginAction{

	@Override
	public ActionForward doExecute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Member mem = new Member();
		mem.setId(request.getParameter("id"));
		mem.setPass(request.getParameter("pass"));
		mem.setName(request.getParameter("name"));
		mem.setEmail(request.getParameter("email"));
		mem.setTtype(Integer.parseInt(request.getParameter("ttype")));
		mem.setPicture(request.getParameter("picture"));
		
		Score s = new Score();
		s.setId(request.getParameter("id"));
		SimpleDateFormat tdate = new SimpleDateFormat("yyyy-MM-dd");
		Date day = tdate.parse(request.getParameter("tdate"));
		s.setTdate(day); 
		s.setScore(Integer.parseInt(request.getParameter("score")));
		s.setTtype(Integer.parseInt(request.getParameter("ttype")));
		
		
		String msg = "비밀번호가 틀렸습니다.";
		String url = "updateForm.me?id="+mem.getId();
		ScoreDao sdao = new ScoreDao();
		MemberDao dao = new MemberDao();
		Member dbmem = dao.selectOne(login);
		if(mem.getPass().equals(dbmem.getPass())) {
			int result = dao.update(mem);
			int sresult = sdao.update(s);
			if(result > 0) {
				if(sresult > 0) {
				return new ActionForward(true,"info.me?id="+mem.getId());
			} else {
				msg = "수정실패";
			}
			}
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false,"../alert.jsp");
	}
}
