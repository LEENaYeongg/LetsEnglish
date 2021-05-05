package action.member;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.ActionForward;

public class MailFormAction extends AdminLoginAction{

	@Override
	protected ActionForward doExecute(HttpServletRequest request, HttpServletResponse response) {
		List<String> list = Arrays.asList(request.getParameterValues("mailchk"));
		//mail을 보낼 mail주소들을 저장하고 있는것 : list
		request.setAttribute("list", list);
		return new ActionForward();
	}
	

}
