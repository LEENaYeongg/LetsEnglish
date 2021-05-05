package action.board;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import action.ActionForward;
import model.Board;
import model.BoardDao;
import model.Comment;
import model.CommentDao;
import model.Score;
import model.ScoreDao;

public class BoardAction {
	BoardDao dao = new BoardDao();
	ScoreDao sdao = new ScoreDao();
	CommentDao cdao = new CommentDao();

	public ActionForward hello(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("hello", "Hello World");
		return new ActionForward();
	}
	/*
	 * 1. 파라미터 값을 model.Board 객체 저장. MultipartRequest 객체 사용. 
	 * 2. 게시물 번호 num 현재 등록된 num의 최대값을 조회. 최대값+1 등록된 게시물의 번호. 
	 * 	  db에서 maxnum 을 구해서 +1 값으로 num 설정하기 
	 * 3. board 내용을 db에 페이지 이동 등록성공 : list.do 페이지 이동 
	 * 							등록실패 : 메세지 출력. writeForm.do 페이지 이동
	 */

	public ActionForward write(HttpServletRequest request, HttpServletResponse response) {
		String path = request.getServletContext().getRealPath("/") + "model2/board/file/";
		File f = new File(path);
		if (!f.exists())
			f.mkdirs();
		MultipartRequest multi; //파일 업로드 할 때 request로 못받아서 multi로 받음.
		try {
			multi = new MultipartRequest(request, path, 10 * 1024 * 1024, "euc-kr");
			Board board = new Board();
			board.setId(multi.getParameter("id"));
			board.setPass(multi.getParameter("pass"));
			board.setBttype(Integer.parseInt(multi.getParameter("bttype")));
			board.setTitle(multi.getParameter("title"));
			board.setBtype(Integer.parseInt(multi.getParameter("btype")));
			board.setContent(multi.getParameter("content"));
			board.setFile1(multi.getFilesystemName("file1"));
			BoardDao dao = new BoardDao();
			// board table에서 num 컬럼의 최대값 리턴. 최대값이 없는 경우 0으로 리턴
			int num = dao.maxnum();
			board.setNum(++num);
			board.setGrp(num);
			if (dao.insert(board)) {
				return new ActionForward(true, "list.do?btype=" + multi.getParameter("btype"));
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		request.setAttribute("msg", "게시물 등록 실패");
		request.setAttribute("url", "writeForm.jsp");
		return new ActionForward(false, "../alert.jsp");
	}

	/*
	 * 1.한 페이지 당 10건의 게시물을 출력하기. pageNum 파라미터값을 저장 => 없는 경우는 1로 설정하기. 
	 * 2.최근 등록된 게시물이 가장 위에서 배치함. 
	 * 3.db에서 해당 페이지에 출력될 내용을 조회하여 화면에 출력. 
	 *   게시물을 출력부분. 페이지 구분 출력 부분
	 * 
	 * 20201123 문제  1. 첨부파일이 있는 경우 @표시하기 
	 * 			   2. 오늘 등록된 게시물은 시 :분:초로 출력하고 오늘 등록된 게시물이 아닌글은 년-월-일 시:분 으로 출력
	 *  		   3. 답글인 경우 들여쓰기. ㅂ한자-6 
	 *			   4. 페이지별 조회번호가 출력되도록 수정하기
	 */
	public ActionForward list(HttpServletRequest request, HttpServletResponse response) {
		int pageNum = 1;
		try {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		} catch (NumberFormatException e) {
		}
		String column = request.getParameter("column");
		String find = request.getParameter("find");
		if (column == null || column.trim().equals("")) {
			column = null;
			find = null;
		}
		if (find == null || find.trim().equals("")) {
			column = null;
			find = null;
		}
		int limit = 10;
		int btype = Integer.parseInt(request.getParameter("btype"));
		int boardcount = dao.boardCount(column, find, btype);
		List<Board> list = dao.list(pageNum, limit, column, find, btype);
		int maxpage = (int) ((double) boardcount / limit + 0.95);
		int startpage = ((int) (pageNum / 10.0 + 0.9) - 1) * 10 + 1;
		int endpage = startpage + 9;
		if (endpage > maxpage)
			endpage = maxpage;
		int boardnum = boardcount - (pageNum - 1) * limit;
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sf.format(new Date());
		request.setAttribute("boardcount", boardcount);
		request.setAttribute("list", list);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("maxpage", maxpage);
		request.setAttribute("startpage", startpage);
		request.setAttribute("endpage", endpage);
		request.setAttribute("boardnum", boardnum);
		request.setAttribute("today", today);
		return new ActionForward();
	}

	/*
	 * 1. num 파라미터 저장
	 * 2. num값의 게시물을 db에서 조회. Board BoardDao.selectOne(num) 
	 * 3. num값의 게시물의 조회수 증가시키기 void BoardDao.readcntAdd(num) 
	 * 4. 조회된 게시물 화면에 출력.
	 */
	public ActionForward info(HttpServletRequest request, HttpServletResponse response) {
		int num = Integer.parseInt(request.getParameter("num"));
		int btype = Integer.parseInt(request.getParameter("btype"));
		List<Comment> comment = cdao.comment(num,btype); //공지사항 목록
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sf.format(new Date());
		request.setAttribute("comment", comment);
		request.setAttribute("today", today);
		Board b = dao.selectOne(num);
		dao.readcntAdd(num); // 조회수 증가
		request.setAttribute("b", b);
		return new ActionForward();
	}

	/*
	 * 1. 원글의 num을 파라미터로 받는다. 
	 * 2. db에서 num의 게시물 조회하여 원글의 num,grp,grplevel,grpstep 정보를 저장 
	 * 3. 입력 화면 표시
	 */
	public ActionForward replyForm(HttpServletRequest request, HttpServletResponse response) {
		int num = Integer.parseInt(request.getParameter("num"));
		Board b = dao.selectOne(num);
		request.setAttribute("b", b);
		return new ActionForward();
	}

	/*
	 * 1. 파라미터 값을 Board 객체에 저장하기 => useBean 태그 사용. 원글정보 : num, grp, grplevel,grpstep
	 * 답글정보 : name, pass, title, content => 등록 정보 
	 * 2. 같은 grp 값을 사용하는 게시물들의 grpstep 값을 1 증가하기. void BoardDao.grpStepAdd(grp,grpstep) 
	 * 3. Board 객체를 db에 insert 하기. 
	 * 	  num : maxnum +1 grp : 원글과 동일. grplevel : 원글 +1 grpstep : 원글 +1 
	 * 4. 등록 성공시: "답변 등록 완료" 메시지 출력 후, list.jsp 페이지로 이동 
	 * 				        등록 실패시 : "답변 등록시 오류발생" 메시지 출력후, replyForm.jsp 페이지로 이동
	 */
	public ActionForward reply(HttpServletRequest request, HttpServletResponse response) {
		Board b = new Board();
		b.setNum(Integer.parseInt(request.getParameter("num")));
		b.setId(request.getParameter("id"));
		b.setPass(request.getParameter("pass"));
		b.setTitle(request.getParameter("title"));
		b.setContent(request.getParameter("content"));
		b.setBtype(Integer.parseInt(request.getParameter("btype")));
		b.setBttype(Integer.parseInt(request.getParameter("bttype")));
		b.setGrp(Integer.parseInt(request.getParameter("grp")));
		b.setGrplevel(Integer.parseInt(request.getParameter("grplevel")));
		b.setGrpstep(Integer.parseInt(request.getParameter("grpstep")));
		dao.grpStepAdd(b.getGrp(), b.getGrplevel());

		int grplevel = b.getGrplevel();
		int grpstep = b.getGrpstep();
		int num = dao.maxnum();// 최대 num값 조회
		String msg = "답변등록시 오류발생";
		String url = "replyForm.do?num=" + b.getNum() + "&btype=" + b.getBtype();
		b.setNum(++num);
		b.setGrplevel(grplevel + 1);
		b.setGrpstep(grplevel + 1);
		if (dao.insert(b)) {
			msg = "답변등록 완료";
			url = "list.do?btype=" + b.getBtype();
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}

	/*
	 * 1. num값에 해당하는 게시물을 조회 
	 * 2. 조회된 게시물을 화면에 출력
	 */
	public ActionForward updateForm(HttpServletRequest request, HttpServletResponse response) {
		int num = Integer.parseInt(request.getParameter("num"));
		Board b = dao.selectOne(num);
		request.setAttribute("b", b);
		return new ActionForward();
	}

	public ActionForward update(HttpServletRequest request, HttpServletResponse response) {
		Board board = new Board();
		String path = request.getServletContext().getRealPath("/") + "model2/board/file/";
		String msg = null;
		String url = null;
		try {
			MultipartRequest multi = new MultipartRequest(request, path, 10 * 1024 * 1024, "euc-kr");
			board.setNum(Integer.parseInt(multi.getParameter("num")));
			board.setId(multi.getParameter("id"));
			board.setPass(multi.getParameter("pass"));
			board.setBttype(Integer.parseInt(multi.getParameter("bttype")));
			board.setBtype(Integer.parseInt(multi.getParameter("btype")));
			board.setTitle(multi.getParameter("title"));
			board.setContent(multi.getParameter("content"));
			board.setFile1(multi.getFilesystemName("file1"));

			if (board.getFile1() == null || board.getFile1().equals("")) {
				board.setFile1(multi.getParameter("file2"));
			}
			BoardDao dao = new BoardDao();
			Board dbboard = dao.selectOne(board.getNum());
			msg = "비밀번호가 틀렸습니다.";
			url = "updateForm.do?num=" + board.getNum() + "&btype=" + board.getBtype();

			if (board.getPass().equals(dbboard.getPass())) {
				if (dao.update(board)) { // db의 게시물 수정
					msg = "게시물 수정 완료";
					url = "info.do?num=" + board.getNum() + "&btype=" + board.getBtype();
				} else
					msg = "게시물 수정 실패";
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}

	public ActionForward delete(HttpServletRequest request, HttpServletResponse response) {
		int num = Integer.parseInt(request.getParameter("num"));
		int btype = Integer.parseInt(request.getParameter("btype"));
		String pass = request.getParameter("pass");
		BoardDao dao = new BoardDao();
		Board dbBoard = dao.selectOne(num);

		String msg = "게시물의 비밀번호가 틀렸습니다.";
		String url = "deleteForm.jsp?num=" + num;

		// 게시물의 비밀번호가 틀렸을 경우
		if (dbBoard == null) {// deleteForm의 pass파라미터 값과 db에 파라미터값과 비교
			msg = "없는 게시글 입니다.";
			url = "list.do?btype=" + btype;
		} else {
			if (pass.equals(dbBoard.getPass())) {
				if (dao.delete(num)) {
					msg = "게시글 삭제 성공.";
					url = "list.do?btype=" + btype;
				} else {
					msg = "게시글 삭제 실패.";
					url = "info.do?num=" + num;
				}
			}
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}

	public ActionForward imgupload(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String path = request.getServletContext().getRealPath("/") + "model2/board/imgfile/";
		File f = new File(path);
		if (!f.exists())
			f.mkdirs();
		MultipartRequest multi = new MultipartRequest(request, path, 10 * 1024 * 1024, "euc-kr");
		String fileName = multi.getFilesystemName("upload");
		request.setAttribute("fileName", fileName);
		request.setAttribute("CKEditorFuncNum", request.getParameter("CKEditorFuncNum"));
		return new ActionForward(false, "ckeditor.jsp");
	}

	public ActionForward graph(HttpServletRequest request, HttpServletResponse response) {
		List<Map<String, Object>> list = sdao.boardgraph();
		StringBuilder json = new StringBuilder("[");
		int i = 0;
		for (Map<String, Object> m : list) {
			for (Map.Entry<String, Object> me : m.entrySet()) {
				if (me.getKey().equals("ttype")) {
					int v = (Integer) me.getValue();
					json.append("{\"ttype\":\"" + (v == 1 ? "토익" : v == 2 ? "토플" : v == 3 ? "토스" : "아이엘츠") + "\",");
				} else if (me.getKey().equals("cnt"))
					json.append("\"cnt\":" + me.getValue() + "}");
			}
			i++;
			if (i < list.size())
				json.append(",");
		}
		json.append("]");
		request.setAttribute("json", json.toString().trim());
		return new ActionForward();
	}

	public ActionForward slist(HttpServletRequest request, HttpServletResponse response) {
		int pageNum = 1;
		try {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		} catch (NumberFormatException e) {
		}
		String column = request.getParameter("column");
		String id = (String)request.getSession().getAttribute("login");
		String find = request.getParameter("find");
		if (column == null || column.trim().equals("")) {
			column = null;
			find = null;
		}
		if (find == null || find.trim().equals("")) {
			column = null;
			find = null;
		}
		int limit = 5;
		int scorecount = sdao.scoreCount(column, find, id);
		List<Score> slist = sdao.slist(pageNum, limit, column, find, id);
//		System.out.println(slist.size());
		int maxpage = (int) ((double) scorecount / limit + 0.95);
		int startpage = ((int) (pageNum / 5.0 + 0.9) - 1) * 5 + 1;
		int endpage = startpage + 4;
		if (endpage > maxpage)
			endpage = maxpage;
		int scorenum = scorecount - (pageNum - 1) * limit;
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sf.format(new Date());
		request.setAttribute("scorecount", scorecount);
		request.setAttribute("slist", slist);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("maxpage", maxpage);
		request.setAttribute("startpage", startpage);
		request.setAttribute("endpage", endpage);
		request.setAttribute("scorenum", scorenum);
		request.setAttribute("today", today);
		return new ActionForward();
	}
	
	

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
	
	
	public ActionForward comment(HttpServletRequest request, HttpServletResponse response) {
		Comment c = new Comment();
		c.setNum(Integer.parseInt(request.getParameter("num")));
		c.setBtype(Integer.parseInt(request.getParameter("btype")));
		c.setId(request.getParameter("id"));
		c.setContent(request.getParameter("content"));
		
		int no = cdao.maxno();
		String msg = "답변등록시 오류발생";
		String url = "info.do?num=" + c.getNum() + "&btype=" + c.getBtype();
		c.setNo(++no);
		if (cdao.insert(c)) {
			msg = "답변등록 완료";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		
		return new ActionForward(false, "../alert.jsp");
		
	}
	
	
}
