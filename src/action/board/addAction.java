package action.board;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.ActionForward;
import model.Score;
import model.ScoreDao;

public class addAction {
	public ActionForward add(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Score score = new Score();
		score.setId(request.getParameter("id"));
		SimpleDateFormat tdate = new SimpleDateFormat("yyyy-MM-dd");
		Date day = tdate.parse(request.getParameter("tdate"));
		score.setTdate(day);
		score.setScore(Integer.parseInt(request.getParameter("score")));
		score.setTtype(Integer.parseInt(request.getParameter("ttype")));
		ScoreDao sdao = new ScoreDao();
		int no = sdao.maxno();
		score.setNo(++no);
		if (sdao.insert(score) > 0) {
			return new ActionForward(true, "slist.do?id=" + request.getParameter("id"));
		}
		request.setAttribute("msg", "게시물 등록 실패");
		request.setAttribute("url", "addForm.jsp");
		return new ActionForward(false, "../alert.jsp");
	}
}
