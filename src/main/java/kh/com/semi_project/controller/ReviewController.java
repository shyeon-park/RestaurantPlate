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
import kh.com.semi_project.service.Service;

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

				Service service = new Service();
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
				response.sendRedirect("/Error/error.jsp");
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
				String rest_name = request.getParameter("rest_name");
				System.out.println(seq_rest);
				
				HashMap<String, String> loginSession = (HashMap)session.getAttribute("loginSession");
			
				String user_id = loginSession.get("id");
				String user_name = loginSession.get("nickname");
				System.out.println(user_name);
				String review_content = request.getParameter("review_content");
				System.out.println(review_content);
		
				
				int rs = dao.insert(new ViewDTO(0,seq_rest,rest_name,user_name,user_id,review_content,null));
				
				if(rs == 1) {
					response.sendRedirect("/toRestDetailView.re?seq_rest="+seq_rest);
				}
			}catch(Exception e) {
				e.printStackTrace();
				response.sendRedirect("/Error/error.jsp");
			}
		}else if(cmd.equals("/toDetailViewProc.vi")) {
			System.out.println("요청 도착");
			int seq_rest = Integer.parseInt(request.getParameter("seq_rest"));
			System.out.println("seq_rest : " + seq_rest);
			
			ArrayList<ViewDTO> list = dao.getViewCheckList(seq_rest);
			//list를 json으로 변환
			Gson gson = new Gson();
			String rs = gson.toJson(list);
			System.out.println(rs);
			
			
			if(list != null) {
				response.getWriter().write(rs);
			}else {
				response.getWriter().write("fail");
			}
		}else if(cmd.equals("/toDetailViewModify.vi")) {
			System.out.println("요청 도착");
			int seq_view = Integer.parseInt(request.getParameter("seq_view"));
			System.out.println(seq_view);
			try {
				ViewDTO dto = dao.selectBySeq_view(seq_view);
				
				System.out.println(dto);
				RequestDispatcher rd = request.getRequestDispatcher("/View/viewModify.jsp");
				request.setAttribute("dto", dto);
				rd.forward(request, response);
			}catch(Exception e) {
				e.printStackTrace();
				response.sendRedirect("/Error/error.jsp");
			}
		}else if(cmd.equals("/viewModifyProc.vi")) {
			System.out.println("요청 도착");
			try {
				int seq_rest = Integer.parseInt(request.getParameter("seq_rest"));
				int seq_view = Integer.parseInt(request.getParameter("seq_view"));
				System.out.println(seq_view + seq_rest);
			
				String review_content = request.getParameter("review_content");
				System.out.println(review_content);
		
				
				int rs = dao.modify(seq_view,review_content);
				
				if(rs != -1) {
					RequestDispatcher rd = request.getRequestDispatcher("/toRestDetailView.re?seq_rest="+seq_rest);

					request.setAttribute("seq_rest",seq_rest);
					rd.forward(request, response);
				}
			}catch(Exception e) {
				e.printStackTrace();
				response.sendRedirect("/Error/error.jsp");
			}
		}else if(cmd.equals("/toDetailViewDelete.vi")) {
			int seq_view = Integer.parseInt(request.getParameter("seq_view"));
			int seq_rest = Integer.parseInt(request.getParameter("seq_rest"));
			System.out.println(seq_view + " : " + seq_rest);
			try {
				// 리뷰 삭제
				int rs = dao.delete(seq_view);
				
				if(rs != -1) {
					response.getWriter().write("success");
					System.out.println("파일이 삭제되었습니다.");
				}else {
					response.getWriter().write("fail");
					System.out.println("파일이 존재하지 않습니다.");
				}
			}catch(Exception e) {
				e.printStackTrace();
				response.sendRedirect("/Error/error.jsp");
				
			}
			
			
		}else if (cmd.equals("/managerReviewProc.vi")) {
	         System.out.println("요청 도착");
	         try {
	            int currentPage = Integer.parseInt(request.getParameter("currentPage"));
	            System.out.println("currentPage : " + currentPage);

	            Service service = new Service();
	            HashMap<String, Object> naviMap = service.getPageNavi(currentPage);
	            ArrayList<ViewDTO> list = service.getViewList((int) naviMap.get("currentPage"));
	            naviMap.put("list", list);
	            System.out.println(list);

	            if (list != null) {
	               Gson gson = new Gson();
	               String rs = gson.toJson(naviMap);
	               response.getWriter().write(rs);
	            } else {
	               response.getWriter().write("fail");
	            }

	         } catch (Exception e) {
	            e.printStackTrace();
	            response.sendRedirect("/Error/error.jsp");

	         }

	      }

	}

}