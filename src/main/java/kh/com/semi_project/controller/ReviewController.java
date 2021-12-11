package kh.com.semi_project.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import kh.com.semi_project.dao.ViewDAO;
import kh.com.semi_project.dto.ViewDTO;
import kh.com.semi_project.service.ViewService;

@WebServlet("*.vi")
public class ReviewController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request,response);
	}
	protected void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		ViewDAO dao = new ViewDAO();


		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = uri.substring(ctxPath.length());
		
		System.out.println("요청 url : " + cmd);
		
		if(cmd.equals("/view.vi")) {
			System.out.println("요청 도착");
			try {
				int currentPage = Integer.parseInt(request.getParameter("currentPage"));
				System.out.println("currentPage : " + currentPage);

				ViewService service = new ViewService();
				HashMap<String, Object> naviMap = service.getPageNavi(currentPage);
				ArrayList<ViewDTO> list = service.getViewList((int) naviMap.get("currentPage"));

				if (list != null) {
					RequestDispatcher rd = request.getRequestDispatcher("/View/view.jsp");
					request.setAttribute("naviMap", naviMap);
					request.setAttribute("list", list);
					rd.forward(request, response);
				}
			
			}catch(Exception e) {
				e.printStackTrace();
				response.sendRedirect("/Error/error.er");
			}
		}else if(cmd.equals("/viewWrite.vi")) {
			System.out.println("요청 도착");
			int seq_rest = Integer.parseInt(request.getParameter("seq_rest"));
			System.out.println(seq_rest);
			String rest_name = request.getParameter("rest_name");
			
			
			
			RequestDispatcher rd = request.getRequestDispatcher("/View/viewWrite.jsp");
			request.setAttribute("seq_rest", seq_rest);
			request.setAttribute("rest_name", rest_name);
			rd.forward(request, response);
		}else if(cmd.equals("/viewWriteProc.vi")) {
			System.out.println("요청 도착");
			try {
				int seq_rest = Integer.parseInt(request.getParameter("seq_rest"));
				System.out.println(seq_rest);
				
				HashMap<String, String> loginSession = (HashMap)session.getAttribute("loginSession");
			
				String user_id = loginSession.get("id");
				String review_content = request.getParameter("review_content");
				System.out.println(review_content);
		
				
				int rs = dao.insert(new ViewDTO(0,seq_rest,user_id,review_content,null));
				
				if(rs == 1) {
					response.sendRedirect("/toRestDetailView.re");
				}
			}catch(Exception e) {
				e.printStackTrace();
				response.sendRedirect("/Error/error.er");
			}
		}else if(cmd.equals("/toDetailViewProc.vi")) {
			System.out.println("요청 도착");
			int seq_rest = Integer.parseInt(request.getParameter("seq_rest"));
			System.out.println("seq_rest : " + seq_rest);
			
			ArrayList<ViewDTO> list = dao.getViewCheckList(seq_rest);
			//list를 json으로 변환
			Gson gson = new Gson();
			String rs = gson.toJson(list);
			
			// 아래 writer와 같지만 단순히 변수만 만들어서 사용한 것
//			PrintWriter out = response.getWriter();
//			out.write("success");
			
			
			if(list != null) {
				//success 문자열을 반환
				response.getWriter().write(rs);
			}else {
				//fail 문자열을 반환
			}
		}

	}

}