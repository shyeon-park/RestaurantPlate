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

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kh.com.semi_project.dao.ListDAO;
import kh.com.semi_project.dao.ListFileDAO;
import kh.com.semi_project.dao.RestMarkDAO;
import kh.com.semi_project.dao.RestaurantDAO;
import kh.com.semi_project.dao.RestaurantFileDAO;
import kh.com.semi_project.dto.ListDTO;
import kh.com.semi_project.dto.ListFileDTO;
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
				response.sendRedirect("/Error/error.jsp");
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
				response.sendRedirect("/Error/error.jsp");
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
				response.sendRedirect("/Error/error.jsp");
				e.printStackTrace();
			}
		} else if (cmd.equals("/toRestDetailLoginView.re")) { // 로그인한 사용자에게 맛집상세정보 뿌려주기
			System.out.println("요청도착");

			int seq_rest = Integer.parseInt(request.getParameter("seq_rest"));
			HttpSession session = request.getSession();
			HashMap<String, String> map = (HashMap) session.getAttribute("loginSession");
			String user_id = map.get("id");
			System.out.println(seq_rest);
			System.out.println(user_id);

			try {
				RestaurantDTO dto = dao.selectBySeq_rest(seq_rest);
				RestMarkDAO rmDao = new RestMarkDAO();
				RestMarkDTO rmDto = rmDao.checkRestMark(seq_rest, user_id);

				if (dto != null) {
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

			} catch (Exception e) {
				response.sendRedirect("/Error/error.jsp");
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
				response.sendRedirect("/Error/error.jsp");
				e.printStackTrace();
			}
		} else if (cmd.equals("/getAllListInfo.re")) { // 해당 맛집정보를 json형태로 뿌려주기
			System.out.println("요청도착");
			int seq_rest = Integer.parseInt(request.getParameter("seq_rest"));

			try {
				RestaurantDTO dto = dao.selectBySeq_rest(seq_rest);

				Gson gson = new Gson();
				String rs = gson.toJson(dto);

				if (dto != null) {
					response.getWriter().write(rs);
				} else {
					response.getWriter().write("fail");
				}
			} catch (Exception e) {
				response.sendRedirect("/Error/error.jsp");
				e.printStackTrace();
			}

		} else if(cmd.equals("/modifyRestProc.re")) {  // 맛집 수정
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

				int seq_rest = Integer.parseInt(multi.getParameter("seq_rest"));
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
				int mark_count = Integer.parseInt(multi.getParameter("mark_count"));
				File uploadFile = multi.getFile("restFile");

				// 새로 업로드한 파일이 있다면
				if (uploadFile != null) {
					RestaurantFileDAO daoFile = new RestaurantFileDAO();
					RestaurantFileDTO dtoFile = daoFile.getFile(seq_rest);

					// 기존에 있던 실제 파일 삭제
					String deleteFilePath = filePath + File.separator + dtoFile.getSystem_name();
					File deleteFile = new File(deleteFilePath);
					if (deleteFile.exists()) {
						deleteFile.delete();
						System.out.println("파일이 삭제되었습니다.");
					} else {
						System.out.println("파일이 존재하지 않습니다.");
					}

					// 맛집 정보 수정
					int rs = dao.modifyBySeq(new RestaurantDTO(seq_rest, seq_list, restName, restIntro, sido, sigungu, bname,
							postcode, address, tel, time, parkingPossible, mark_count));

					// 리스트 파일 정보 수정
					String origin_name = multi.getOriginalFileName("restFile");
					String system_name = multi.getFilesystemName("restFile");
					int rsFile = daoFile.modifyFile(new RestaurantFileDTO(0, seq_rest, origin_name, system_name));

					if (rs == 1 && rsFile == 1) {
						response.getWriter().write("success");
					} else {
						response.getWriter().write("fail");
					}

				} else { // 새로 업로드한 파일이 없다면
					// 리스트 정보만 수정
					int rs = dao.modifyBySeq(new RestaurantDTO(seq_rest, seq_list, restName, restIntro, sido, sigungu, bname,
							postcode, address, tel, time, parkingPossible, mark_count));

					if (rs == 1) {
						response.getWriter().write("success");
					} else {
						response.getWriter().write("fail");
					}
				}
			} catch (Exception e) {
				response.sendRedirect("/Error/error.jsp");
				e.printStackTrace();
			}
		} else if(cmd.equals("/deleteRestProc.re")) {	// 맛집 삭제
			System.out.println("요청도착");

			try {

				int seq_rest = Integer.parseInt(request.getParameter("seq_rest"));
				RestaurantFileDAO daoFile = new RestaurantFileDAO();

				// 맛집 삭제
				int rs = dao.deleteBySeq(seq_rest);

				// 실제 경로에 있는 파일 삭제
				RestaurantFileDTO dtoFile = daoFile.getFile(seq_rest);
				String system_name = dtoFile.getSystem_name();
				String deleteFilePath = request.getServletContext().getRealPath("restFiles");
				String filePath = deleteFilePath + File.separator + system_name;
				File deleteFile = new File(filePath);

				// 해당 맛집 파일 정보 삭제
				int rsFile = daoFile.deleteFile(seq_rest);

				if (deleteFile.exists() && rs == 1 && rsFile == 1) {
					deleteFile.delete();
					response.getWriter().write("success");
					System.out.println("파일이 삭제되었습니다.");
				} else {
					response.getWriter().write("fail");
					System.out.println("파일이 존재하지 않습니다.");
				}
			} catch (Exception e) {
				response.sendRedirect("/Error/error.jsp");
				e.printStackTrace();
			}
			
		}
			
		
	}

}
