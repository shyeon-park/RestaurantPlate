package kh.com.semi_project.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
import kh.com.semi_project.service.MemberService;
import utils.AuthNumberCreate;
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

			// id 중복검사
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
			session.removeAttribute("phoneAuthNum"); // 회원가입 클릭 시 핸드폰 인증번호 세션 삭제
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			System.out.print(id);
			boolean regex = Pattern.matches("^[0-9]*$", id);
			// 카카오 회원가입인지 아닌지 구분 카카오 id는 10자리의 숫자키로 이루어져있다.
			System.out.println(regex);
			if (regex) {
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
				if (!regex) { // 카카오 로그인이 아닐 때
					if (rs != -1) {
						out.println("<script>alert(\"회원가입에 성공하였습니다.\"); location.href='/member/login.jsp';</script>");
						out.flush();
					} else {
						out.println(
								"<script>alert(\"회원가입에 실패하였습니다. 관리자에게 문의해주세요.(010-5670-5842)\"); location.href='/member/login.jsp';</script>");
						out.flush();
					}
				} else { // 카카오 로그인
					if (rs != -1) {
						HashMap<String, String> loginMap = new HashMap<>();
						loginMap.put("id", id);
						loginMap.put("nickname", nickname);
						session.setAttribute("loginSession", loginMap);
						response.sendRedirect("/");

					} else {
						out.println(
								"<script>alert(\"카카오 회원가입에 실패하였습니다. 관리자에게 문의해주세요.(010-5670-5842)\"); location.href='/member/login.jsp';</script>");
						out.flush();
					}

				}
			} catch (Exception e) {
				e.printStackTrace();
			}

			// 로그인 승인
		} else if (cmd.equals("/loginProc.mem")) {
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");

			pw = EncryptionUtils.getSHA512(pw);
			System.out.println("id : " + id + "pw : " + pw);

			try {
				boolean rs = dao.isLoginOk(id, pw);
				if (rs) {
					MemberDTO dto = dao.selectByDto(id);
					String nickname = dto.getUser_nickname();
					HashMap<String, String> loginMap = new HashMap<>();
					// 값 추가
					loginMap.put("id", id);
					loginMap.put("nickname", nickname);
					loginMap.put("identification", String.valueOf(dto.getIdentification()));
					session.setAttribute("loginSession", loginMap);
					System.out.println(loginMap.get("id"));
					System.out.println(loginMap.get("nickname"));
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

			// 로그아웃 기능
		} else if (cmd.equals("/logoutProc.mem")) {
			HashMap<String, String> loginMap = (HashMap) session.getAttribute("loginSession");
			String id = loginMap.get("id");
			System.out.println(id);

			session.removeAttribute("loginSession");
			response.sendRedirect("/home");
			// 카카오 로그인을 누르면 id, nickname 값을 kakaoSignup.jsp로 보내준다
		} else if (cmd.equals("/kakaoLogin.mem")) {

			System.out.println("요청도착");

			String kakaoId = request.getParameter("kakaoId");
			String kakaoNickname = request.getParameter("kakaoNickname");
			System.out.println("kakaoId  : " + kakaoId + " kakaoNickname : " + kakaoNickname);

			try {

				MemberDTO dto = dao.selectByDto(kakaoId);
				if (dto.getUser_id() != null) {
					HashMap<String, String> loginMap = new HashMap<>();
					loginMap.put("id", kakaoId);
					loginMap.put("nickname", kakaoNickname);
					session.setAttribute("loginSession", loginMap);
					response.sendRedirect("/home");
				} else {
					HashMap<String, String> kakaoInformation = new HashMap<>();
					kakaoInformation.put("kakaoId", kakaoId);
					kakaoInformation.put("kakaoNickname", kakaoNickname);
					RequestDispatcher rd = request.getRequestDispatcher("/member/kakaoSignup.jsp");
					request.setAttribute("kakaoInformation", kakaoInformation);
					rd.forward(request, response);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if (cmd.equals("/pwInput.mem")) {
			// 현재 로그인된 사용자의 id 값을 얻어 옴
			HashMap<String, String> loginMap = (HashMap) session.getAttribute("loginSession");
			String id = loginMap.get("id");

			// 카카오 회원가입인지 아닌지 구분 카카오 id는 10자리의 숫자키로 이루어져있다.
			boolean regex = Pattern.matches("^[0-9]*$", id);
			// 카카오 아이디이면 이용불가 페이지로 이동
			if (regex)
				response.sendRedirect("/member/notAvailable.jsp");
			// 카카오 로그인이 아니면 패스워드 이동 페이지 이동
			else
				response.sendRedirect("/member/pwInput.jsp");

		} else if (cmd.equals("/changePw.mem")) {
			// 현재 로그인된 사용자의 id 값을 얻어 옴
			HashMap<String, String> loginMap = (HashMap) session.getAttribute("loginSession");
			String id = loginMap.get("id");
			String pw = request.getParameter("pw");
			String changePw = request.getParameter("changePw");
			pw = EncryptionUtils.getSHA512(pw);
			changePw = EncryptionUtils.getSHA512(changePw);
			PrintWriter out = response.getWriter();
			try {
				if (dao.isLoginOk(id, pw)) {// 로그인 성공 시
					int rs = dao.changePw(id, changePw);
					if (rs != -1) {
						session.removeAttribute("loginSession");
						out.println(
								"<script>alert(\"비밀번호 변경에 성공하였습니다. 다시 로그인 해주세요\"); location.href='/home';</script>");
						out.flush();
					} else {
						out.println(
								"<script>alert(\"비밀번호 변경에 실패하였습니다.\"); location.href='/member/pwInput.jsp';</script>");
						out.flush();
					}

				} else {
					out.println("<script>alert(\"PW를 확인해주세요. \"); location.href='/member/pwInput.jsp';</script>");
					out.flush();
				}

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		} else if (cmd.equals("/mypage.mem")) {

			// 현재 로그인된 사용자의 id 값을 얻어 옴
			HashMap<String, String> loginMap = (HashMap) session.getAttribute("loginSession");
			String id = loginMap.get("id");

			// id값을 이용해서 DB에서 사용자의 정보를 불러 옴.
			MemberDTO dto;
			try {
				dto = dao.selectByDto(id);
//				System.out.println(dto.getUser_nickname());
//				System.out.println(dto.getUser_email());
//				System.out.println(dto.getUser_phone());
//				System.out.println(dto.getPost_code());
//				System.out.println(dto.getRoad_addr());
//				System.out.println(dto.getDetail_addr());
//				System.out.println(dto.getExtra_addr());

				RequestDispatcher rd = request.getRequestDispatcher("/member/mypage.jsp");
				request.setAttribute("dto", dto);
				rd.forward(request, response);
			} catch (Exception e) {

				e.printStackTrace();
			}
		} else if (cmd.equals("/modifyProc.mem")) {
			String nickname = request.getParameter("nickname");
			String email = request.getParameter("email");
			String phone = request.getParameter("phone");
			String postCode = request.getParameter("postCode");
			String roadAddress = request.getParameter("roadAddress");
			String detailAddr = request.getParameter("detailAddr");
			String extraAddr = request.getParameter("extraAddr");

			// System.out.println("nickname : "+nickname + " email :" + email + " phone : "
			// + phone + " postCode : " + postCode + " roadAddress : "+roadAddress +"
			// detailAddr : " + detailAddr + " extraAddr :"+ extraAddr);
			System.out.println("요청도착" + email);
			// 현재 로그인된 사용자의 id 값을 얻어 옴
			HashMap<String, String> loginMap = (HashMap) session.getAttribute("loginSession");
			String id = loginMap.get("id");

			// id값을 이용해서 DB에서 사용자의 셋팅를 불러 옴.

			try {
				MemberDTO dto = new MemberDTO();

				dto.setUser_id(id);
				dto.setUser_nickname(nickname);
				dto.setUser_email(email);
				dto.setUser_phone(phone);
				dto.setPost_code(postCode);
				dto.setRoad_addr(roadAddress);
				dto.setDetail_addr(detailAddr);
				dto.setExtra_addr(extraAddr);

				int rs = dao.modifyMypage(dto);
				PrintWriter out = response.getWriter();
				if (rs != -1) {
					out.println("<script>alert(\"마이페이지 수정 완료 완료되었습니다.\"); location.href='/mypage.mem';</script>");
					out.flush();
				} else {
					out.println(
							"<script>alert(\"마이페이지 수정 실패 되었습니다. 다시 시도해주세요\"); location.href='/mypage.mem';</script>");
					out.flush();
				}

			} catch (Exception e) {

				e.printStackTrace();
			}

		} else if (cmd.equals("/deleteMember.mem")) { // 회원탈퇴 페이지 이동
			System.out.println("요청도착");
			response.sendRedirect("/member/deleteMember.jsp");
		} else if (cmd.equals("/deleteProc.mem")) {
			System.out.println("요청도착");
			HashMap<String, String> loginMap = (HashMap) session.getAttribute("loginSession");
			String id = loginMap.get("id");
			System.out.println(id);
			try {
				int rs = dao.deleteById(id);
				PrintWriter out = response.getWriter();
				if (rs != -1) {
					session.removeAttribute("loginSession");
					out.println("<script>alert(\"회원삭제가 완료되었습니다.\"); location.href='/home';</script>");
					out.flush();
				} else {
					out.println(
							"<script>alert(\"회원삭제가 실패하였습니다 관리자에게 문의하세요(010-5670-5842).\"); location.href='/home';</script>");
					out.flush();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 인증이 성공했을때 id를 보내준다.
		} else if (cmd.equals("/searchId.mem")) {
			String phone = request.getParameter("phone");
			String id;
			session.removeAttribute("phoneAuthNum");// 인증번호 세션 삭제
			try {
				id = dao.selectById(phone);
				if (id.equals("x")) {
					// 등록된 아이디가 없을 시
					response.getWriter().write("x");
				} else {
					boolean regex = Pattern.matches("^[0-9]*$", id);
					if (regex) {
						// 카카오 로그인일 시
						response.getWriter().write("kakao");
					} else {
						// 등록된 아이디에 마지막 3자리를 ***변환
						id = id.replace(id.substring(id.length() - 3), "***");
						System.out.println("id : " + id);
						response.getWriter().write(id);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 비밀번호 찾기할때 필요한 ID를 불러온다
		} else if (cmd.equals("/searchPw.mem")) {
			String id = request.getParameter("id");
			System.out.println(id);
			try {
				MemberDTO dto = dao.selectByDto(id);

				if (dto.getUser_id() != null) {
					response.getWriter().write("success");
				} else
					response.getWriter().write("fail");

			} catch (Exception e) {
				e.printStackTrace();
			}
			// 인증이 성공하였을 때 임시비밀번호를 생성해서 보내준다.
		} else if (cmd.equals("/tempPw.mem")) {
			String id = request.getParameter("id");
			String phone2 = request.getParameter("phone2");
			System.out.println(id + " : " + phone2);

			session.removeAttribute("phoneAuthNum");// 인증번호 세션 삭제

			AuthNumberCreate anc = new AuthNumberCreate();
			String tempPw = anc.pwGenerate();
			String tempPw1 = EncryptionUtils.getSHA512(tempPw);

			try {
				int rs = dao.modifyPw(id, phone2, tempPw1);
				if (rs != -1)
					response.getWriter().write(tempPw);
				else
					response.getWriter().write("fail");

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (cmd.equals("/toMemberManagement.mem")) {
			System.out.println("요청도착");
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));
			System.out.println("currentPage : " + currentPage);
			MemberService mService = new MemberService();
			HashMap<String, Object> naviMap = mService.getPageNavi(currentPage);
			ArrayList<MemberDTO> list = mService.getMemberList((int) naviMap.get("currentPage"));
			naviMap.put("list", list);

			if (list != null) {
				Gson gson = new Gson();
				String rs = gson.toJson(naviMap);
				response.getWriter().write(rs);
			}else response.getWriter().write("fail");
				

			
		}else if (cmd.equals("/checkBoxDelMem.mem")) {
			System.out.println("요청도착");
			int rs2;
			try {
				rs2 = dao.nullcheck(request.getParameterValues("chk_arr"));
				PrintWriter out = response.getWriter();
				if (rs2 == -1) {
					String[] checkBox = request.getParameterValues("chk_arr");
					for (String id : checkBox) {
						int rs = dao.deleteById(id);
						if(rs != -1) {
							response.getWriter().write("성공");
						}else {
							response.getWriter().write("실패");
						}
					}
					
				}else {
					System.out.println("널값입니다.");
					response.getWriter().write("선택");
				}

			} catch (Exception e1) {
				e1.printStackTrace();
			}

		}
	
	}
}
