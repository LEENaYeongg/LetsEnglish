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
	 * 1. �Ķ���� ���� model.Board ��ü ����. MultipartRequest ��ü ���. 
	 * 2. �Խù� ��ȣ num ���� ��ϵ� num�� �ִ밪�� ��ȸ. �ִ밪+1 ��ϵ� �Խù��� ��ȣ. 
	 * 	  db���� maxnum �� ���ؼ� +1 ������ num �����ϱ� 
	 * 3. board ������ db�� ������ �̵� ��ϼ��� : list.do ������ �̵� 
	 * 							��Ͻ��� : �޼��� ���. writeForm.do ������ �̵�
	 */

	public ActionForward write(HttpServletRequest request, HttpServletResponse response) {
		String path = request.getServletContext().getRealPath("/") + "model2/board/file/";
		File f = new File(path);
		if (!f.exists())
			f.mkdirs();
		MultipartRequest multi; //���� ���ε� �� �� request�� ���޾Ƽ� multi�� ����.
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
			// board table���� num �÷��� �ִ밪 ����. �ִ밪�� ���� ��� 0���� ����
			int num = dao.maxnum();
			board.setNum(++num);
			board.setGrp(num);
			if (dao.insert(board)) {
				return new ActionForward(true, "list.do?btype=" + multi.getParameter("btype"));
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		request.setAttribute("msg", "�Խù� ��� ����");
		request.setAttribute("url", "writeForm.jsp");
		return new ActionForward(false, "../alert.jsp");
	}

	/*
	 * 1.�� ������ �� 10���� �Խù��� ����ϱ�. pageNum �Ķ���Ͱ��� ���� => ���� ���� 1�� �����ϱ�. 
	 * 2.�ֱ� ��ϵ� �Խù��� ���� ������ ��ġ��. 
	 * 3.db���� �ش� �������� ��µ� ������ ��ȸ�Ͽ� ȭ�鿡 ���. 
	 *   �Խù��� ��ºκ�. ������ ���� ��� �κ�
	 * 
	 * 20201123 ����  1. ÷�������� �ִ� ��� @ǥ���ϱ� 
	 * 			   2. ���� ��ϵ� �Խù��� �� :��:�ʷ� ����ϰ� ���� ��ϵ� �Խù��� �ƴѱ��� ��-��-�� ��:�� ���� ���
	 *  		   3. ����� ��� �鿩����. ������-6 
	 *			   4. �������� ��ȸ��ȣ�� ��µǵ��� �����ϱ�
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
	 * 1. num �Ķ���� ����
	 * 2. num���� �Խù��� db���� ��ȸ. Board BoardDao.selectOne(num) 
	 * 3. num���� �Խù��� ��ȸ�� ������Ű�� void BoardDao.readcntAdd(num) 
	 * 4. ��ȸ�� �Խù� ȭ�鿡 ���.
	 */
	public ActionForward info(HttpServletRequest request, HttpServletResponse response) {
		int num = Integer.parseInt(request.getParameter("num"));
		int btype = Integer.parseInt(request.getParameter("btype"));
		List<Comment> comment = cdao.comment(num,btype); //�������� ���
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sf.format(new Date());
		request.setAttribute("comment", comment);
		request.setAttribute("today", today);
		Board b = dao.selectOne(num);
		dao.readcntAdd(num); // ��ȸ�� ����
		request.setAttribute("b", b);
		return new ActionForward();
	}

	/*
	 * 1. ������ num�� �Ķ���ͷ� �޴´�. 
	 * 2. db���� num�� �Խù� ��ȸ�Ͽ� ������ num,grp,grplevel,grpstep ������ ���� 
	 * 3. �Է� ȭ�� ǥ��
	 */
	public ActionForward replyForm(HttpServletRequest request, HttpServletResponse response) {
		int num = Integer.parseInt(request.getParameter("num"));
		Board b = dao.selectOne(num);
		request.setAttribute("b", b);
		return new ActionForward();
	}

	/*
	 * 1. �Ķ���� ���� Board ��ü�� �����ϱ� => useBean �±� ���. �������� : num, grp, grplevel,grpstep
	 * ������� : name, pass, title, content => ��� ���� 
	 * 2. ���� grp ���� ����ϴ� �Խù����� grpstep ���� 1 �����ϱ�. void BoardDao.grpStepAdd(grp,grpstep) 
	 * 3. Board ��ü�� db�� insert �ϱ�. 
	 * 	  num : maxnum +1 grp : ���۰� ����. grplevel : ���� +1 grpstep : ���� +1 
	 * 4. ��� ������: "�亯 ��� �Ϸ�" �޽��� ��� ��, list.jsp �������� �̵� 
	 * 				        ��� ���н� : "�亯 ��Ͻ� �����߻�" �޽��� �����, replyForm.jsp �������� �̵�
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
		int num = dao.maxnum();// �ִ� num�� ��ȸ
		String msg = "�亯��Ͻ� �����߻�";
		String url = "replyForm.do?num=" + b.getNum() + "&btype=" + b.getBtype();
		b.setNum(++num);
		b.setGrplevel(grplevel + 1);
		b.setGrpstep(grplevel + 1);
		if (dao.insert(b)) {
			msg = "�亯��� �Ϸ�";
			url = "list.do?btype=" + b.getBtype();
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}

	/*
	 * 1. num���� �ش��ϴ� �Խù��� ��ȸ 
	 * 2. ��ȸ�� �Խù��� ȭ�鿡 ���
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
			msg = "��й�ȣ�� Ʋ�Ƚ��ϴ�.";
			url = "updateForm.do?num=" + board.getNum() + "&btype=" + board.getBtype();

			if (board.getPass().equals(dbboard.getPass())) {
				if (dao.update(board)) { // db�� �Խù� ����
					msg = "�Խù� ���� �Ϸ�";
					url = "info.do?num=" + board.getNum() + "&btype=" + board.getBtype();
				} else
					msg = "�Խù� ���� ����";
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

		String msg = "�Խù��� ��й�ȣ�� Ʋ�Ƚ��ϴ�.";
		String url = "deleteForm.jsp?num=" + num;

		// �Խù��� ��й�ȣ�� Ʋ���� ���
		if (dbBoard == null) {// deleteForm�� pass�Ķ���� ���� db�� �Ķ���Ͱ��� ��
			msg = "���� �Խñ� �Դϴ�.";
			url = "list.do?btype=" + btype;
		} else {
			if (pass.equals(dbBoard.getPass())) {
				if (dao.delete(num)) {
					msg = "�Խñ� ���� ����.";
					url = "list.do?btype=" + btype;
				} else {
					msg = "�Խñ� ���� ����.";
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
					json.append("{\"ttype\":\"" + (v == 1 ? "����" : v == 2 ? "����" : v == 3 ? "�佺" : "���̿���") + "\",");
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
		request.setAttribute("msg", "�Խù� ��� ����");
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
		String msg = "�亯��Ͻ� �����߻�";
		String url = "info.do?num=" + c.getNum() + "&btype=" + c.getBtype();
		c.setNo(++no);
		if (cdao.insert(c)) {
			msg = "�亯��� �Ϸ�";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		
		return new ActionForward(false, "../alert.jsp");
		
	}
	
	
}
