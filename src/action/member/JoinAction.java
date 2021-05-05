package action.member;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import model.BoardDao;
import model.Member;
import model.MemberDao;
import model.Score;
import model.ScoreDao;
/* /WebContent/model1/member/join.jsp
1. �Ķ���� ������ Member ��ü�� ���� => useBean �׼��±�
2. Member ��ü   ������ db�� �߰�.
3. ���Լ���: loginForm.jsp ������ �̵�
	  ���Խ���: joinForm.jsp ������ �̵�
*/
public class JoinAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Member mem = new Member();
		mem.setId(request.getParameter("id"));
		mem.setPass(request.getParameter("pass"));
		mem.setName(request.getParameter("name"));
		mem.setEmail(request.getParameter("email"));
		mem.setTtype(Integer.parseInt(request.getParameter("ttype")));
		mem.setPicture(request.getParameter("picture"));
		
		ScoreDao dao = new ScoreDao();
		Score score = new Score();
		int no = dao.maxno();
		score.setNo(++no);
		score.setId(request.getParameter("id"));
		SimpleDateFormat tdate = new SimpleDateFormat("yyyy-MM-dd");
		Date day = tdate.parse(request.getParameter("tdate"));
		score.setTdate(day); 
		score.setScore(Integer.parseInt(request.getParameter("score")));
		score.setTtype(Integer.parseInt(request.getParameter("ttype")));
		
		String msg = "ȸ������ ����";
		String url = "joinForm.me";
//		System.out.println(mem);
		if(new MemberDao().insert(mem) > 0) {
			if(new ScoreDao().insert(score) > 0)
			msg = mem.getName() + "�� ȸ������ �Ϸ�";
			url = "loginForm.me";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false,"../alert.jsp");
	}

}
