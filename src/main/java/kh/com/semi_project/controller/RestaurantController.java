package kh.com.semi_project.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kh.com.semi_project.dao.RestaurantDAO;
import kh.com.semi_project.dao.RestaurantFileDAO;
import kh.com.semi_project.dto.RestaurantDTO;
import kh.com.semi_project.dto.RestaurantFileDTO;


@WebServlet("*.re")
public class RestaurantController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}
	
	private void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		String url = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = url.substring(ctxPath.length());
		RestaurantDAO dao = new RestaurantDAO();
		
		// 맛집 정보 추가
		if(cmd.equals("/addRestProc.re")) {
			System.out.println("요청도착");
			
			String filePath = request.getServletContext().getRealPath("restFiles");
			System.out.println(filePath);
			File dir = new File(filePath);
			if(!dir.exists()) {
				dir.mkdir();
			}
			int fileSize = 1024 * 1024 * 10;
			
			System.out.println("filePath : " + filePath);
			System.out.println("fileSize : " + fileSize);
			
			try {
				MultipartRequest multi = new MultipartRequest(request, filePath, fileSize, "utf-8", new DefaultFileRenamePolicy());
				
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
				
				int rs = dao.addRestaurant(new RestaurantDTO(seq_rest, seq_list,
						restName, restIntro, sido, sigungu, bname, postcode, address, tel, time, parkingPossible));
				
				String origin_name = multi.getOriginalFileName("restFile");
				String system_name = multi.getFilesystemName("restFile");
				System.out.println("origin_name : " + origin_name);
				System.out.println("system_name : " + system_name);
				
				RestaurantFileDAO daoRFile = new RestaurantFileDAO();
				int rsFile = daoRFile.insertFile(new RestaurantFileDTO(0, seq_rest, origin_name, system_name));
				
				if(rs != -1 && rsFile != -1) {
					response.getWriter().write("success");
				} else {
					response.getWriter().write("fail");
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}	
		}
	}

}
