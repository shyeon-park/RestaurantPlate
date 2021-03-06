package kh.com.semi_project.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kh.com.semi_project.dao.ListDAO;
import kh.com.semi_project.dao.ListFileDAO;
import kh.com.semi_project.dto.ListDTO;
import kh.com.semi_project.dto.ListFileDTO;
import kh.com.semi_project.dto.ListJoinFileDTO;
import kh.com.semi_project.dto.MemberDTO;
import kh.com.semi_project.service.MemberService;
import kh.com.semi_project.service.Service;

@WebServlet("*.li")
public class ListController extends HttpServlet {
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
		ListDAO dao = new ListDAO();

		// 리스트 등록(리스트 사진도 같이 등록)
		if (cmd.equals("/addListProc.li")) {
			System.out.println("요청도착");

			String filePath = request.getServletContext().getRealPath("listFiles");
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

				String list_title = multi.getParameter("title");

				int seq_list = dao.getListSequence();
				int rs = dao.addList(new ListDTO(seq_list, list_title));

				String origin_name = multi.getOriginalFileName("listImg");
				String system_name = multi.getFilesystemName("listImg");
				System.out.println("origin_name : " + origin_name);
				System.out.println("system_name : " + system_name);

				ListFileDAO daoLFile = new ListFileDAO();
				int rsFile = daoLFile.insertFile(new ListFileDTO(0, seq_list, origin_name, system_name));

				if (rs != -1 && rsFile != -1) {
					response.getWriter().write("success");
				} else {
					response.getWriter().write("fail");
				}
			} catch (Exception e) {
				response.sendRedirect("/Error/error.jsp");
				e.printStackTrace();
			}
		} else if (cmd.equals("/getListProc.li")) { // 넘어온 페이지에 속해있는 리스트 목록 불러오기
			System.out.println("요청도착");
			
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));
			System.out.println("currentPage : " + currentPage);
			Service service = new Service();
			HashMap<String, Object> naviMap = service.getListPageNavi(currentPage);
			ArrayList<ListDTO> list = service.getRestaurantList((int) naviMap.get("currentPage"));
			naviMap.put("list", list);

			if (list != null) {
				Gson gson = new Gson();
				String rs = gson.toJson(naviMap);
				response.getWriter().write(rs);
			} else {
				response.getWriter().write("fail");
			}
//			try {
//				int currentPage = Integer.parseInt(request.getParameter("currentPage"));
//				Service service = new Service();
//				HashMap<String, Object> naviMap = service.getListPageNavi(currentPage);
//				ArrayList<ListDTO> list = service.getRestaurantList((int) naviMap.get("currentPage"));
//				
//				Gson gson = new Gson();
//				HashMap<String, Object> listMap = new HashMap<>();
//				listMap.put("list", list);
//				listMap.put("currentPage", currentPage);
//				
//				String groups = gson.toJson(listMap);
//
//				if (list != null) {
//					response.getWriter().write(groups);
//				} else {
//					response.getWriter().write("fail");
//				}
//			} catch (Exception e) {
//				response.sendRedirect("/Error/error.jsp");
//				e.printStackTrace();
//			}
		} else if (cmd.equals("/getAllListInfo.li")) { // 리스트 번호로 해당 리스트 정보불러와 json형태로 뿌려주기
			System.out.println("요청도착");

			try {
				int seq_list = Integer.parseInt(request.getParameter("seq_list"));
				System.out.println(seq_list);
				ListDTO dto = dao.selectBySeq(seq_list);

				Gson gson = new Gson();
				String rs = gson.toJson(dto);

				if (dto != null) {
					response.getWriter().write(rs);
				} else {
					response.getWriter().write("fail");
				}

//				ListFileDAO daoFile = new ListFileDAO();
//				ListFileDTO dtoFile = daoFile.getFile(seq_list);
//				
//				String system_name = dtoFile.getSystem_name();
//				String uploadFilePath = request.getServletContext().getRealPath("files");
//				String filePath = uploadFilePath + File.separator + system_name;
//				system_name = new String(system_name.getBytes("UTF-8"), "ISO-8859-1");
//				
//				try (DataInputStream dis = new DataInputStream(new FileInputStream(filePath));
//						DataOutputStream dos = new DataOutputStream(response.getOutputStream());) {
//					byte[] arr = dis.readAllBytes();
//					request.setAttribute("arr", arr);
//				} catch (Exception e) {
//					e.printStackTrace();
//				}
			} catch (Exception e) {
				response.sendRedirect("/Error/error.jsp");
				e.printStackTrace();
			}
		} else if (cmd.equals("/deleteListProc.li")) { // 리스트와 파일삭제
			System.out.println("요청도착");

			try {

				int seq_list = Integer.parseInt(request.getParameter("seq_list"));
				ListFileDAO daoFile = new ListFileDAO();

				// 리스트 삭제
				int rs = dao.deleteBySeq(seq_list);

				// 실제 경로에 있는 파일 삭제
				ListFileDTO dtoFile = daoFile.getFile(seq_list);
				String system_name = dtoFile.getSystem_name();
				String deleteFilePath = request.getServletContext().getRealPath("listFiles");
				String filePath = deleteFilePath + File.separator + system_name;
				File deleteFile = new File(filePath);

				// 해당 리스트 파일 정보 삭제
				int rsFile = daoFile.deleteFile(seq_list);

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
		} else if (cmd.equals("/modifyListProc.li")) { // 리스트 정보 수정, 해당 리스트 파일정보도 수정
			System.out.println("요청도착");

			String filePath = request.getServletContext().getRealPath("listFiles");
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
				String title = multi.getParameter("title");
				File uploadFile = multi.getFile("listImg");
				System.out.println(seq_list + " : " + title + " : " + uploadFile);

				// 새로 업로드한 파일이 있다면
				if (uploadFile != null) {
					ListFileDAO daoFile = new ListFileDAO();
					ListFileDTO dtoFile = daoFile.getFile(seq_list);

					// 기존에 있던 실제 파일 삭제
					String deleteFilePath = filePath + File.separator + dtoFile.getSystem_name();
					File deleteFile = new File(deleteFilePath);
					if (deleteFile.exists()) {
						deleteFile.delete();
						System.out.println("파일이 삭제되었습니다.");
					} else {
						System.out.println("파일이 존재하지 않습니다.");
					}

					// 리스트 정보 수정
					int rs = dao.modifyBySeq(new ListDTO(seq_list, title));

					// 리스트 파일 정보 수정
					String origin_name = multi.getOriginalFileName("listImg");
					String system_name = multi.getFilesystemName("listImg");
					int rsFile = daoFile.modifyFile(new ListFileDTO(0, seq_list, origin_name, system_name));
					

					if (rs == 1 && rsFile == 1) {
						response.getWriter().write("success");
					} else {
						response.getWriter().write("fail");
					}

				} else { // 새로 업로드한 파일이 없다면
					// 리스트 정보만 수정
					int rs = dao.modifyBySeq(new ListDTO(seq_list, title));

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
		} else if (cmd.equals("/toTotalListView.li")) { // 리스트 전체 목록 조회 페이지로 이동
			System.out.println("요청도착");

			Random random = new Random();
			int rd = random.nextInt(8) + 1;
			System.out.println(rd);
			String rdFile = rd + ".png";
			System.out.println(rdFile);

			try {
				ArrayList<ListJoinFileDTO> list = dao.selectListAndFileAll();

				if (list != null) {
					request.setAttribute("random", rdFile);
					request.setAttribute("list", list);
					request.getRequestDispatcher("/RestaurantList/totalListView.jsp").forward(request, response);
				}
			} catch (Exception e) {
				response.sendRedirect("/Error/error.jsp");
				e.printStackTrace();
			}

		} else if (cmd.equals("/getHomeList.li")) { // 메인페이지에 랜덤으로 리스트를 뿌려주는 작업
			System.out.println("요청도착");

			try {
				ArrayList<ListJoinFileDTO> list = dao.getHomeListRandom();
				Gson gson = new Gson();
				String rs = gson.toJson(list);
				System.out.println(rs);

				if (list != null) {
					response.getWriter().write(rs);
				} else {
					response.getWriter().write("fail");
				}
			} catch (Exception e) {
				response.sendRedirect("/Error/error.jsp");
				e.printStackTrace();
			}
		} else if (cmd.equals("/toListManagement.li")) { // 관리자 리스트 페이지 요청 시
			System.out.println("요청도착");
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));

			Service service = new Service();
			HashMap<String, Object> naviMap = service.getListPageNavi(currentPage);

			if (naviMap != null) {
				request.setAttribute("naviMap", naviMap);
				request.setAttribute("currentPage", currentPage);
				request.getRequestDispatcher("/manager/listManagement.jsp").forward(request, response);
			}
		} 

	}
}



//ArrayList<ListDTO> list = service.getRestaurantList((int) naviMap.get("currentPage"));

//System.out.println("요청도착");
//
//try {
//	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
//
//	Service service = new Service();
//	HashMap<String, Object> naviMap = service.getListPageNavi(currentPage);
//	ArrayList<ListDTO> list = service.getRestaurantList((int) naviMap.get("currentPage"));
//	Gson gson = new Gson();
//	String data1 = gson.toJson(list);
//	String data2 = gson.toJson(naviMap);
//	
//	if (data1 != null && data2 != null) {
//		response.getWriter().write(data1);
//		response.getWriter().write(data2);
//	} else {
//		response.getWriter().write("fail");
//	}
//}catch(Exception e) {
//	e.printStackTrace();
