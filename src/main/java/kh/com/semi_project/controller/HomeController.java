package kh.com.semi_project.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kh.com.semi_project.dao.ListDAO;
import kh.com.semi_project.dto.ListJoinFileDTO;

@WebServlet("*.home")
public class HomeController extends HttpServlet {

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

		if (cmd.equals("/toGetList.home")) {
			System.out.println("요청도착");

			ListDAO dao = new ListDAO();
			try {
				ArrayList<ListJoinFileDTO> list = dao.getListAndFile();
				Gson gson = new Gson();
				String rs = gson.toJson(list);
				System.out.println(rs);

				if (list != null) {
					response.getWriter().write(rs);
				} else {
					response.getWriter().write("fail");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}
