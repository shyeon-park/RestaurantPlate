package kh.com.semi_project.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import kh.com.semi_project.dao.RestMarkDAO;
import kh.com.semi_project.dao.RestaurantDAO;
import kh.com.semi_project.dto.RestMarkDTO;

@WebServlet("*.mr")
public class RestMarkController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		actionDo(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		actionDo(request, response);
	}

	private void actionDo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");

		String url = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = url.substring(ctxPath.length());
		RestMarkDAO dao = new RestMarkDAO();

		if (cmd.equals("/restmarkProc.mr")) {    // 마크체크여부 확인하여 결과값 뿌려주기
			System.out.println("요청도착");
			
			int seq_rest = Integer.parseInt(request.getParameter("seq_rest"));
			HttpSession session = request.getSession();
			HashMap<String, String> map = (HashMap)session.getAttribute("loginSession");
			String user_id = map.get("id");
			
			Gson json = new Gson();
			HashMap<String, String> markMap = new HashMap<>();
			RestaurantDAO restDao = new RestaurantDAO(); 
			
			System.out.println(seq_rest);
			System.out.println(user_id);
			
			try {
				RestMarkDTO dto = dao.checkRestMark(seq_rest, user_id);
				
				if(dto == null) {
					int rs = dao.insertMark(new RestMarkDTO(0, seq_rest, user_id, 0));
					
					if(rs == 1) {
						restDao.markCountUp(seq_rest);
						int totalCount = restDao.getTotalMarkCount(seq_rest);
						
						markMap.put("totalCount", Integer.toString(totalCount));
						markMap.put("msg", "successMark");
						
						String data = json.toJson(markMap); 
						response.getWriter().write(data);
					}
				} else {
					int rs = dao.deleteMark(seq_rest, user_id);
					
					if(rs == 1) {
						restDao.markCountDown(seq_rest);
						int totalCount = restDao.getTotalMarkCount(seq_rest);
						
						markMap.put("totalCount", Integer.toString(totalCount));
						markMap.put("msg", "cancleMark");
						
						String data = json.toJson(markMap); 
						response.getWriter().write(data);
					}
				}
				
			} catch (Exception e) {
				response.sendRedirect("/Error/error.jsp");
				e.printStackTrace();
			}
		}
	}

}
