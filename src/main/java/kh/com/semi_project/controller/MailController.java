package kh.com.semi_project.controller;
import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import utils.AuthNumberCreate;
import utils.MailSend;

/**
 * Servlet implementation class MailController
 */
@WebServlet("*.mail")
public class MailController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		action(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		action(request, response);
	}
	
	public void action(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		
		
		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = uri.substring(ctxPath.length());
	
		System.out.println("요청 utl : " +cmd);
		
		//버튼 클릭시 로그인 페이지 이동
		if(cmd.equals("/sendEmail.mail")) {
			System.out.println("요청도착");
			
			//인증번호 생성
			AuthNumberCreate anc = new AuthNumberCreate();
			String authNumber = anc.AuthNumberCreate(6);
			HashMap<String,String> authNumMap = new HashMap<>();
			//System.out.println("authNumber : " + authNumMap.get("authNumId"));
			authNumMap.put("authNumId",authNumber);
			session.setAttribute("authNum", authNumMap);
			String email = request.getParameter("email");
			System.out.println("authNumber : " + authNumber + "email : " +email);
			MailSend ms = new MailSend();
			String mailSend= ms.authenticationMail(authNumber, email);
			if(mailSend.equals("success")) {
				response.getWriter().write("메일전송완료!"); 
			}else {
				response.getWriter().write("메일전송실패");
			}
			
		}else if(cmd.equals("/authNumCheck.mail")) {
			
		
			String authNumInput = request.getParameter("authNumInput");
			System.out.println("authNumInput : " + authNumInput);
			
			HashMap<String,String> authNumMap = (HashMap)session.getAttribute("authNum");
			
			String authNumber = authNumMap.get("authNumId");
			System.out.println(authNumber);
			if(authNumInput.equals(authNumber)) {
				session.removeAttribute("authNum");
				response.getWriter().write("success");
				
			}else {
				response.getWriter().write("fail");
			}
			//
		}
		
	}
}
