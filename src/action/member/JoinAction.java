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
1. 파라미터 정보를 Member 객체에 저쟝 => useBean 액션태그
2. Member 객체   정보를 db에 추가.
3. 가입성공: loginForm.jsp 페이지 이동
	  가입실패: joinForm.jsp 페이지 이동
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
		
		String msg = "회원가입 실패";
		String url = "joinForm.me";
//		System.out.println(mem);
		if(new MemberDao().insert(mem) > 0) {
			if(new ScoreDao().insert(score) > 0)
			msg = mem.getName() + "님 회원가입 완료";
			url = "loginForm.me";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false,"../alert.jsp");
	}

}
