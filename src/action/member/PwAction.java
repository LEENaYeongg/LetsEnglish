package action.member;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import model.MemberDao;

public class PwAction implements Action {
   
   @Override
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      //db���� id,email�� �̿��Ͽ� pw���� ����
      String id = request.getParameter("id");
      String email = request.getParameter("email");
      
      MemberDao dao = new MemberDao();
      String pw = dao.pwSearch(id, email);
      if(pw != null) {
         request.setAttribute("pw", pw);
         return new ActionForward();

      }else {
      String msg = "������ �´� pw�� ã�� �� �����ϴ�.";
      String url = "pwForm.me";
      
      request.setAttribute("url", url);
      request.setAttribute("msg", msg);
      return new ActionForward(false,"../alert.jsp");
      }
   }
}