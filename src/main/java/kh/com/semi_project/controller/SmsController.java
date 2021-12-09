package kh.com.semi_project.controller;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.InetAddress;
import java.net.Socket;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import utils.AuthNumberCreate;
import utils.SmsSend;





/**
 * Servlet implementation class SmsController
 */
@WebServlet("*.sms")
public class SmsController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		actionDo(request, response);
	}
	
	public void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(); // 세션
		SmsSend sDao = new SmsSend(); //인코딩 디코딩
		
		
		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = uri.substring(ctxPath.length());
		System.out.println("요청 url : " + cmd);
		
		String charsetType = "UTF-8"; // UTF-8로 변경
		request.setCharacterEncoding(charsetType);
		response.setCharacterEncoding(charsetType);
		    
		    if(cmd.equals("/SmsSend.sms")) {
		    	
		    	AuthNumberCreate anc = new AuthNumberCreate();
				String phoneAuthNumber = anc.AuthNumberCreate(6);
				HashMap<String,String> phoneAuthNumMap = new HashMap<>();
				phoneAuthNumMap.put("phoneAuthNumId",phoneAuthNumber);
				//세션에 phoneAuthNum 저장
				session.setAttribute("phoneAuthNum", phoneAuthNumMap); 
				
				
				//String rhone2 =request.getParameter("rphone");
				//System.out.println("rhone2 : "+rhone2);
				String sms_url = "";
		        sms_url = "https://sslsms.cafe24.com/sms_sender.php"; // SMS 전송요청 URL
		        String user_id = sDao.base64Encode("xoghks1904"); // SMS아이디
		        String secure = sDao.base64Encode("3bc06f199c8bb9b55c32fb805fb1fdde");//인증키
		        String msg = sDao.base64Encode("[맛집플레이트] 본인확인 인증번호 [ "+phoneAuthNumber+" ]입니다. 타인 노출 금지 ");
		        String rphone ="";
		        try {
		        	rphone = sDao.base64Encode(sDao.nullcheck(request.getParameter("rphone"),"")); // p	
		    	}catch(Exception e) {
		    		e.printStackTrace();
		    	}
		       
		        String sphone1 = sDao.base64Encode("010"); //p
		        String sphone2 = sDao.base64Encode("5670"); //p
		        String sphone3 = sDao.base64Encode("5842"); //p
		        String rdate = sDao.base64Encode("");
		        String rtime = sDao.base64Encode("");
		        String mode = sDao.base64Encode("1");
		        
		        String smsType = sDao.base64Encode("S");
		        String subject = "";
		        if(smsType.equals("L")) {
		            subject = sDao.base64Encode("");
		        }
		        String testflag = sDao.base64Encode("");
		        String destination = sDao.base64Encode("");
		        String repeatFlag = sDao.base64Encode("");
		        String repeatNum = sDao.base64Encode("");
		        String repeatTime = sDao.base64Encode("");
		        String returnurl = "";
		        String nointeractive = "";
		        

		        String[] host_info = sms_url.split("/");
		        String host = host_info[2];
		        String path = "/" + host_info[3];
		        int port = 80;

		        // 데이터 맵핑 변수 정의
		        String arrKey[]
		            = new String[] {"user_id","secure","msg", "rphone","sphone1","sphone2","sphone3","rdate","rtime"
		                        ,"mode","testflag","destination","repeatFlag","repeatNum", "repeatTime", "smsType", "subject"};
		        String valKey[]= new String[arrKey.length] ;
		        valKey[0] = user_id;
		        valKey[1] = secure;
		        valKey[2] = msg;
		        valKey[3] = rphone;
		        valKey[4] = sphone1;
		        valKey[5] = sphone2;
		        valKey[6] = sphone3;
		        valKey[7] = rdate;
		        valKey[8] = rtime;
		        valKey[9] = mode;
		        valKey[10] = testflag;
		        valKey[11] = destination;
		        valKey[12] = repeatFlag;
		        valKey[13] = repeatNum;
		        valKey[14] = repeatTime;
		        valKey[15] = smsType;
		        valKey[16] = subject;

		        String boundary = "";
		        Random rnd = new Random();
		        String rndKey = Integer.toString(rnd.nextInt(32000));
		        MessageDigest md;
				try {
					md = MessageDigest.getInstance("MD5");
					 byte[] bytData = rndKey.getBytes();
				        md.update(bytData);
				        byte[] digest = md.digest();
				        for(int i =0;i<digest.length;i++)
				        {
				            boundary = boundary + Integer.toHexString(digest[i] & 0xFF);
				        }
				       boundary = "---------------------"+boundary.substring(0,11);
				       
				} catch (NoSuchAlgorithmException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		        
		         //본문 생성
		        String data = "";
		        String index = "";
		        String value = "";
		        for (int i=0;i<arrKey.length; i++)
		        {
		           index =  arrKey[i];
		            value = valKey[i];
		            data +="--"+boundary+"\r\n";
		            data += "Content-Disposition: form-data; name=\""+index+"\"\r\n";
		            data += "\r\n"+value+"\r\n";
		            data +="--"+boundary+"\r\n";
		        }
				//System.out.print(data);
		        //out.println(data);
				
		        InetAddress addr = InetAddress.getByName(host);
		        Socket socket = new Socket(host, port);
		         //헤더 전송
		        BufferedWriter wr = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream(), charsetType));
		        wr.write("POST "+path+" HTTP/1.0\r\n");
		        wr.write("Content-Length: "+data.length()+"\r\n");
		        wr.write("Content-type: multipart/form-data, boundary="+boundary+"\r\n");
		        wr.write("\r\n");

		         //데이터 전송
		        wr.write(data);
		        wr.flush();

		        // 결과값 얻기
		        BufferedReader rd = new BufferedReader(new InputStreamReader(socket.getInputStream(),charsetType));
		        String line;
		        String alert = "";
		        ArrayList tmpArr = new ArrayList();
		        while ((line = rd.readLine()) != null) {
		            tmpArr.add(line);
		        }
		        wr.close();
		        rd.close();

		        String tmpMsg = (String)tmpArr.get(tmpArr.size()-1);
		        String[] rMsg = tmpMsg.split(",");
		        String Result= rMsg[0]; //발송결과
		        String Count= ""; //잔여건수
		        if(rMsg.length>1) {Count= rMsg[1]; }

		                        //발송결과 알림
		        if(Result.equals("success")) {
		        	System.out.println("성공적으로 발송하였습니다.");
		        	System.out.println(" 잔여건수는 "+ Count+"건 입니다.");
		        	response.getWriter().write("success");
		        }
		        else if(Result.equals("reserved")) {
		        	System.out.println("성공적으로 예약되었습니다");
		        	System.out.println(" 잔여건수는 "+ Count+"건 입니다.");
		        	response.getWriter().write("reserved");
		        }
		        else if(Result.equals("3205")) {
		        	System.out.println(" 잘못된 번호형식입니다.");
		        	response.getWriter().write("regexError");
		        }
		        else {
		         	System.out.println("[Error]"+Result);
		        }
		        
		    }else if(cmd.equals("/phoneAuthNumSend.sms")) {
		    	
		    	System.out.println("요청 도착");
		    	String phoneAuthNumInput = request.getParameter("phoneAuthNumInput");
		    	System.out.println("phoneAuthNumInput : "+ phoneAuthNumInput);
		    	
		    	//세션에서 phoneAuthNumId 을 가져온다
		    	HashMap<String,String> phoneAuthNumMap= (HashMap)session.getAttribute("phoneAuthNum");
				String phoneAuthNum = phoneAuthNumMap.get("phoneAuthNumId");
				System.out.println(phoneAuthNum);
				
				if(phoneAuthNumInput.equals(phoneAuthNum)) {
					response.getWriter().write("success");
				}else {
					response.getWriter().write("fail");
				}
		    	
		    
		    }
		
	}
}
