package kh.com.semi_project.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.regex.Pattern;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import kh.com.semi_project.dao.MemberDAO;
import kh.com.semi_project.dto.MemberDTO;
import utils.EncryptionUtils;

/**
 * Servlet implementation class MemberController
 */
@WebServlet("*.mem")
public class MemberController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		actionDo(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		actionDo(request, response);
	}

	public void actionDo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8"); // printWrite 한글 인코딩
		
		MemberDAO dao = new MemberDAO();
		HttpSession session = request.getSession();
		
		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = uri.substring(ctxPath.length());

		System.out.println("요청 url : " + cmd);

		// 버튼 클릭시 로그인 페이지 이동
		if (cmd.equals("/login.mem")) {
			System.out.println("요청도착");
			int aa = 3;
			response.sendRedirect("/member/login.jsp");

			// 회원가입 클릭시 signup 페이지 이동
		} else if (cmd.equals("/signup.mem")) {
			System.out.println("요청도착");
			response.sendRedirect("/member/signup.jsp");

			//id 중복검사
		} else if (cmd.equals("/checkId.mem")) {
			String chickId = request.getParameter("chickId");
			System.out.println("chickId : " + chickId);

			MemberDTO dto = new MemberDTO();

			try {
				dto = dao.selectByDto(chickId);
				System.out.println("dto : " + dto.getUser_id());
				Gson gson = new Gson();
				String rs = gson.toJson(dto);
				if (dto.getUser_id() == null) {
					response.getWriter().write("success");
				} else {
					response.getWriter().write("fail");
				}
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("/errorPage.jsp");
			}

			// 회원가입 후 로그인페이지 이동
		} else if (cmd.equals("/addMember.mem")) {
			System.out.println("요청도착");
			session.removeAttribute("phoneAuthNum"); //회원가입 클릭 시 핸드폰 인증번호 세션 삭제
			String id = request.getParameter("id");
			String pw= request.getParameter("pw"); 
			System.out.print(id);
			boolean regex = Pattern.matches("^[0-9]*$", id); 
			//카카오 회원가입인지 아닌지 구분 카카오 id는 10자리의 숫자키로 이루어져있다.
			  System.out.println(regex);
				if(regex) {
					pw = "kakaoLogin";
				}
			pw = EncryptionUtils.getSHA512(pw); // 비밀번호 암호화
			
			String nickname = request.getParameter("nickname");
			String email = request.getParameter("email");
			String phone = request.getParameter("phone");
			String postCode = request.getParameter("postCode");
			String roadAddress = request.getParameter("roadAddress");
			String detailAddr = request.getParameter("detailAddr");
			String extraAddr = request.getParameter("extraAddr");
			

			MemberDTO dto = new MemberDTO(id, pw, nickname, null, email, phone, postCode, roadAddress, detailAddr,
					extraAddr, 0);
			PrintWriter out = response.getWriter();
			
			try {
				int rs = dao.insert(dto);
				if(!regex) { // 카카오 로그인이 아닐 때 
					if (rs != -1) {
						out.println("<script>alert(\"회원가입에 성공하였습니다.\"); location.href='/member/login.jsp';</script>");
						out.flush();
					}else {
						out.println("<script>alert(\"회원가입에 실패하였습니다. 관리자에게 문의해주세요.(010-5670-5842)\"); location.href='/member/login.jsp';</script>");
						out.flush();
					}
				}else { // 카카오 로그인
					if (rs != -1) {
						HashMap<String, String> loginMap = new HashMap<>();
						loginMap.put("id", id);
						loginMap.put("nickname", nickname);
						session.setAttribute("loginSession", loginMap);
						response.sendRedirect("/");
						
					}else {
						out.println("<script>alert(\"카카오 회원가입에 실패하였습니다. 관리자에게 문의해주세요.(010-5670-5842)\"); location.href='/member/login.jsp';</script>");
						out.flush();
						}
				
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			//로그인 승인
		} else if (cmd.equals("/loginProc.mem")) {
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			
			pw = EncryptionUtils.getSHA512(pw);
			System.out.println("id : " + id +"pw : " + pw);
			try {
				boolean rs = dao.isLoginOk(id, pw);
				if (rs) {
					MemberDTO dto = dao.selectByDto(id);
					String nickname = dto.getUser_nickname();
					HashMap<String, String> loginMap = new HashMap<>();
					// 값 추가
					loginMap.put("id", id);
					loginMap.put("nickname", nickname);

					System.out.println(loginMap.get("id"));
					System.out.println(loginMap.get("nickname"));

					session.setAttribute("loginSession", loginMap);
					response.sendRedirect("/");
				} else {
					RequestDispatcher rd = request.getRequestDispatcher("/member/login.jsp");
					request.setAttribute("rs", "fail");
					rd.forward(request, response);
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			//로그아웃 기능
		}else if (cmd.equals("/logoutProc.mem")) { 
			session.removeAttribute("loginSession");
			response.sendRedirect("/");
			//카카오 로그인을 누르면 id, nickname 값을 kakaoSignup.jsp로 보내준다 
		}else if(cmd.equals("/kakaoLogin.mem")) {
			
			System.out.println("요청도착");
			
			String kakaoId = request.getParameter("kakaoId");
			String kakaoNickname = request.getParameter("kakaoNickname");
			System.out.println("kakaoId  : " + kakaoId + " kakaoNickname : "+ kakaoNickname);
			
			try {
				
				MemberDTO dto = dao.selectByDto(kakaoId);
				if(dto.getUser_id() != null) {
					HashMap<String, String> loginMap = new HashMap<>();
					loginMap.put("id", kakaoId);
					loginMap.put("nickname", kakaoNickname);
					session.setAttribute("loginSession", loginMap);
					response.sendRedirect("/");
				}else {
					HashMap<String, String>  kakaoInformation= new HashMap<>();
					kakaoInformation.put("kakaoId", kakaoId);
					kakaoInformation.put("kakaoNickname", kakaoNickname);
					RequestDispatcher rd = request.getRequestDispatcher("/member/kakaoSignup.jsp");
					request.setAttribute("kakaoInformation", kakaoInformation);
					rd.forward(request, response);
				}
			}catch(Exception e){
				e.printStackTrace();
			}
			
		}

	}

}
