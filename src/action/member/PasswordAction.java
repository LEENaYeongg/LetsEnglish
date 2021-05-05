package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.ActionForward;
import model.Member;
import model.MemberDao;
/*	2. pass, chgpass �Ķ���� �� ����
	3. pass ��й�ȣ�� db�� ����� ��й�ȣ�� Ʋ���� ��й�ȣ ���� �޽��� ���. passwordForm.jsp ������ �̵�
	4. pass ��й�ȣ�� db�� ����� ��й�ȣ�� ������
		MemberDao.updatePass(login, chgpass) => ���ο� ��й�ȣ�� ����
			��й�ȣ ���� ����.
		�޼��� ��� �� opener �������� info.jsp ������ �̵�. ���� ������ �ݱ�
			��й�ȣ ���� ����.
		�޽��� ��� �� opener �������� updateForm.jsp ������ �̵�.
			���� ������ �ݱ�
*/
public class PasswordAction extends UserLoginAction{

   @Override
   public ActionForward doExecute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      boolean opener = true;
      boolean closer = true;
      String msg = null;
      String url = null;
      String pass = request.getParameter("pass");
      String chgpass = request.getParameter("chgpass");
      MemberDao dao = new MemberDao();
      Member mem = dao.selectOne(login);
      if(pass.equals(mem.getPass())) {
         if(dao.updatePass(login, chgpass) > 0) {
            msg = "��й�ȣ�� ����Ǿ����ϴ�.";
            url = "info.me?id=" + login;
         } else {
            msg = "��й�ȣ ���� �� ������ �߻� �߽��ϴ�.";
            url = "updateForm.me?id=" + login;
         }
      } else { //��й�ȣ ����
         opener = false;
         closer = false;
         msg = "��й�ȣ �����Դϴ�. Ȯ���ϼ���.";
         url = "passwordForm.me";
      }
      request.setAttribute("msg", msg);
      request.setAttribute("url", url);
      request.setAttribute("opener", opener);
      request.setAttribute("closer", closer);
         
      return new ActionForward();
   }

}