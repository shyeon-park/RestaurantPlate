package kh.com.semi_project.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kh.com.semi_project.dao.ListDAO;
import kh.com.semi_project.dao.RestMarkDAO;
import kh.com.semi_project.dao.RestaurantDAO;
import kh.com.semi_project.dao.RestaurantFileDAO;
import kh.com.semi_project.dto.ListDTO;
import kh.com.semi_project.dto.RestMarkDTO;
import kh.com.semi_project.dto.RestaurantDTO;
import kh.com.semi_project.dto.RestaurantFileDTO;
import kh.com.semi_project.dto.RestaurantJoinFileDTO;

@WebServlet("*.re")
public class RestaurantController extends HttpServlet {

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
		RestaurantDAO dao = new RestaurantDAO();

		// 맛집 정보 추가
		if (cmd.equals("/addRestProc.re")) {
			System.out.println("요청도착");

			String filePath = request.getServletContext().getRealPath("restFiles");
			System.out.println(filePath);
			File dir = new File(filePath);
			if (!dir.exists()) {
				dir.mkdir();
			}
			int fileSize = 1024 * 1024 * 10;

			System.out.println("filePath : " + filePath);
			System.out.println("fileSize : " + fileSize);

			try {
				MultipartRequest multi = new MultipartRequest(request, filePath, fileSize, "utf-8",
						new DefaultFileRenamePolicy());

				int seq_list = Integer.parseInt(multi.getParameter("seq_list"));
				String restName = multi.getParameter("restName");
				String restIntro = multi.getParameter("restIntro");
				String sido = multi.getParameter("sido");
				String sigungu = multi.getParameter("sigungu");
				String bname = multi.getParameter("bname");
				String postcode = multi.getParameter("postcode");
				String address = multi.getParameter("address");
				String tel = multi.getParameter("tel");
				String time = multi.getParameter("time");
				String parkingPossible = multi.getParameter("parkingPossible");
				int seq_rest = dao.getRestaurantSequence();

				int rs = dao.addRestaurant(new RestaurantDTO(seq_rest, seq_list, restName, restIntro, sido, sigungu,
						bname, postcode, address, tel, time, parkingPossible, 0));

				String origin_name = multi.getOriginalFileName("restFile");
				String system_name = multi.getFilesystemName("restFile");
				System.out.println("origin_name : " + origin_name);
				System.out.println("system_name : " + system_name);

				RestaurantFileDAO daoRFile = new RestaurantFileDAO();
				int rsFile = daoRFile.insertFile(new RestaurantFileDTO(0, seq_rest, origin_name, system_name));

				if (rs != -1 && rsFile != -1) {
					response.getWriter().write("success");
				} else {
					response.getWriter().write("fail");
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (cmd.equals("/toRestaurnatList.re")) { // 리스트의 맛집목록을 파일과 함께 사용자 페이지에 뿌려주기

			int seq_list = Integer.parseInt(request.getParameter("seq_list"));

			try {
				ListDAO ldao = new ListDAO();
				ListDTO ldto = ldao.selectBySeq(seq_list);
				ArrayList<RestaurantJoinFileDTO> restList = dao.selectRestAndFileBySeq(seq_list);

				if (ldto != null && restList != null) {
					request.setAttribute("ldto", ldto);
					request.setAttribute("restList", restList);
					request.getRequestDispatcher("/RestaurantList/listDetailView.jsp").forward(request, response);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if (cmd.equals("/toRestDetailView.re")) { // 로그인 안한 사용자에게 맛집상세정보 뿌려주기
			System.out.println("요청도착");

			int seq_rest = Integer.parseInt(request.getParameter("seq_rest"));
			System.out.println(seq_rest);

			try {
				RestaurantDTO dto = dao.selectBySeq_rest(seq_rest);

				if (dto != null) {
					request.setAttribute("restDto", dto);
					request.getRequestDispatcher("/RestaurantList/restaurantDetailView.jsp").forward(request, response);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (cmd.equals("/toRestDetailLoginView.re")) { // 로그인한 사용자에게 맛집상세정보 뿌려주기
			System.out.println("요청도착");

			int seq_rest = Integer.parseInt(request.getParameter("seq_rest"));
			HttpSession session = request.getSession();
			HashMap<String, String> map = (HashMap)session.getAttribute("loginSession");
			String user_id = map.get("id");
			System.out.println(seq_rest);
			System.out.println(user_id);
			
			try {
				RestaurantDTO dto = dao.selectBySeq_rest(seq_rest);
				RestMarkDAO rmDao = new RestMarkDAO();
				RestMarkDTO rmDto =  rmDao.checkRestMark(seq_rest, user_id);
				
				if(dto != null ) {
					HashMap<String, Object> restMap = new HashMap<>();
					restMap.put("restDto", dto);
					restMap.put("rmDto", rmDto);
					System.out.println(restMap);
					request.setAttribute("restMap", restMap);
					request.getRequestDispatcher("/RestaurantList/restaurantDetailView.jsp").forward(request, response);
				}
//				} else if (dto != null && rmDto == null) {
//					request.setAttribute("restDto", dto);
//					request.setAttribute("rmDto", null);
//					request.getRequestDispatcher("/restaurantList/restaurantDetailView.jsp").forward(request, response);
//				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}

		} else if (cmd.equals("/toRestManagerView.re")) { // 관리자 페이지에 맛집목록 뿌려주기
			int seq_list = Integer.parseInt(request.getParameter("seq_list"));

			try {
				ListDAO ldao = new ListDAO();
				ListDTO ldto = ldao.selectBySeq(seq_list);
				ArrayList<RestaurantJoinFileDTO> restList = dao.selectRestAndFileBySeq(seq_list);

				if (ldto != null && restList != null) {
					request.setAttribute("ldto", ldto);
					request.setAttribute("restList", restList);
					request.getRequestDispatcher("/manager/restaurantManagement.jsp").forward(request, response);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}
