package action.member;

import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.ActionForward;

public class MailAction extends AdminLoginAction {
   @Override
   protected ActionForward doExecute(HttpServletRequest request, HttpServletResponse response) {
      try {
    	  //네이버 mail id. 보낸메일 주소
         String sendid = request.getParameter("naverid");
         // 네이버 비밀번호.
         String sendpw = request.getParameter("naverpw");
         //수신메일.
         String recipient = request.getParameter("recipient");
         //제목
         String title = request.getParameter("title");
         //문서형식
         String mtype = request.getParameter("mtype");
         //메일의 내용
         String contents = request.getParameter("contents");
         //메일 서버의 환경 변수 설정
         Properties prop = new Properties();
         prop.put("mail.smtp.host", "smtp.naver.com");
         prop.put("mail.smtp.port", "465");
 //        prop.put("mail.smtp.starttls.enable", "true");
         //인증 받아서 메일 전송. 포털사이트인 경우 필수
         prop.put("mail.smtp.auth", "true");
         prop.put("mail.debug", "true"); //개발시에 true
         prop.put("mail.smtp.user", sendid); //전송자 설정.
         prop.put("mail.smtp.socketFactory.port", "465");
         //보안메일 방식
         prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
         prop.put("mail.smtp.socketFactory.fallback", "false");
         //인증 객체
         MyAuthenticator auth = new MyAuthenticator(sendid,sendpw);
         //session: 메일전송서버에 접속
         Session session = Session.getDefaultInstance(prop,auth);
         //mail 전송을 위한 객체
         MimeMessage mail = new MimeMessage(session);
         mail.setFrom(new InternetAddress(sendid)); //보내는 이메일 주소
         String[] recaddr = recipient.split(","); //여러 이메일을 ,를 기준으로 나눈다
         InternetAddress[] address = new InternetAddress[recaddr.length];
         for(int i = 0; i < recaddr.length; i++) {
            address[i] = new InternetAddress(recaddr[i]);
         }
         //받는 이메일 주소들.
         //Message.RecipientType.TO : 수신인
         //Message.RecipientType.CC : 참조인
         mail.setRecipients(Message.RecipientType.TO, address);
         //제목
         mail.setSubject(title);
         //보낸일자
         mail.setSentDate(new Date());
         mail.setText(contents);
         //내용
         MimeMultipart multipart = new MimeMultipart();
         MimeBodyPart body = new MimeBodyPart();
         //내용, 문서형식
         body.setContent(contents,mtype);
         multipart.addBodyPart(body);
         mail.setContent(multipart); //메일의 내용부분
         Transport.send(mail); //메일 전송.
         request.setAttribute("msg", String.join("\\n",recaddr) + "\\n메일전송 완료.");
      } catch(Exception e) {
         e.printStackTrace();
         request.setAttribute("msg","메일 전송 중 오류 발생.");
      }
      request.setAttribute("url", "list.me");
      return new ActionForward(false,"../alert.jsp");
   }
   private final class MyAuthenticator extends Authenticator {
      private String id;
      private String pw;
      public MyAuthenticator(String id, String pw) {
         this.id = id;
         this.pw = pw;
      }
      protected PasswordAuthentication getPasswordAuthentication() {
         return new PasswordAuthentication(id,pw);
      }
   }
}