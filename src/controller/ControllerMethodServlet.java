package controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.ActionForward;
import action.board.BoardAction;

@WebServlet(urlPatterns = {"*.do"},
      initParams = {@WebInitParam(name="properties", value = "method.properties")})
public class ControllerMethodServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
   private Properties pr = new Properties();
   private BoardAction action = new BoardAction();
   private Class[] paramType = new Class[]
         {HttpServletRequest.class, HttpServletResponse.class};
    public ControllerMethodServlet() {
        super();
    }
    @Override
    public void init(ServletConfig config) throws ServletException{
       FileInputStream f = null;
       //props : method.properties
       String props = config.getInitParameter("properties");
       try {
          f = new FileInputStream
       (config.getServletContext().getRealPath("/") + "WEB-INF/" + props);
          pr.load(f);
          f.close();
       }catch(IOException e) {
          e.printStackTrace();
       }
    }
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.setCharacterEncoding("euc-kr");
      Object[] paramObjs = new Object[] {request, response};
      ActionForward forward = null;
      String command = null;
      try {
         command = request.getRequestURI().substring
               (request.getContextPath().length());
         //methodName : hello
         String methodName = pr.getProperty(command);
         //action.getClass() : BoardAction의 Class 정보
         //method : 메서드의 이름이 hello
         // 		파라미터 정보가 request,response 인 메서드 리턴
         Method method = action.getClass().getMethod
                                       (methodName, paramType);
         //invoke : 메서드 호출.실행.
         forward = (ActionForward)method.invoke(action, paramObjs);
      }catch(NullPointerException e) {
         forward = new ActionForward();
      }catch (Exception e) {
         throw new ServletException(e);
      }
      if(forward != null) {
         if(forward.isRedirect()) {
            response.sendRedirect(forward.getView());
         }else {
            if(forward.getView() == null) {
               forward.setView(command.replace(".do", ".jsp"));
            }
            RequestDispatcher disp =
            request.getRequestDispatcher(forward.getView());
            disp.forward(request, response);
         }
      }
   }
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      doGet(request, response);
   }

}