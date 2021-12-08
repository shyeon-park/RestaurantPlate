package utils;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.Transport;

public class MailSend {
	public String authenticationMail(String authNumber, String email) {

		Properties prop = System.getProperties();
	
				// 로그인시 TLS를 사용할 것인지 설정
				prop.put("mail.smtp.starttls.enable", "true");
		        
				// 이메일 발송을 처리해줄 SMTP서버
				prop.put("mail.smtp.host", "smtp.gmail.com");
		        
				// SMTP 서버의 인증을 사용한다는 의미
				prop.put("mail.smtp.auth", "true");
		        
				// TLS의 포트번호는 587이며 SSL의 포트번호는 465이다.
				prop.put("mail.smtp.port", "587");
				prop.put("mail.smtp.ssl.protocols", "TLSv1.2");

				Authenticator auth = new MailAuth();
				
				// Properties에 저장디어있는 설정 값을 getDefaultInstance() 메소드로 설정값을 저장하여 세션 생성
				Session session = Session.getDefaultInstance(prop, auth);

				MimeMessage msg = new MimeMessage(session);
				
				try {
					// 보내는 날짜 지정
					msg.setSentDate(new Date());

					// 발송자를 지정한다. 발송자의 메일, 발송자명
					msg.setFrom(new InternetAddress("qwe7wer@gmail.com", "맛집플레이트"));
					
		            // 수신자의 메일을 생성한다.
					InternetAddress to = new InternetAddress(email);
					
		            // Message 클래스의 setRecipient() 메소드를 사용하여 수신자를 설정한다. setRecipient() 메소드로 수신자, 참조,
					// 숨은 참조 설정이 가능하다.
					// Message.RecipientType.TO : 받는 사람
					// Message.RecipientType.CC : 참조
					// Message.RecipientType.BCC : 숨은 참조
					msg.setRecipient(Message.RecipientType.TO, to);
					
		            // 메일의 제목 지정
					msg.setSubject("맛집플레이트[E-Mail 본인확인]", "UTF-8");
					
		            // Transport는 메일을 최종적으로 보내는 클래스로 메일을 보내는 부분이다.
					msg.setText("인증번호 ["+authNumber+"]를 입력해주세요!", "UTF-8");

					Transport.send(msg);
					return "success";

				} catch (AddressException ae) {
					System.out.println("AddressException : " + ae.getMessage());
					return "fail";
				} catch (MessagingException me) {
					System.out.println("MessagingException : " + me.getMessage());
					return "fail";
				} catch (UnsupportedEncodingException e) {
					System.out.println("UnsupportedEncodingException : " + e.getMessage());
					return "fail";
				}
	}	
}
