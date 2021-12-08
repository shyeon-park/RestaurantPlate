package utils;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MailAuth extends Authenticator{
	
	  PasswordAuthentication pa;
	    
	    public MailAuth() {
	    	 String mail_id = "qwe7wer";
	    	 String mail_pw = "dsvythksmzqyvujs";
	    		        
	    	 pa = new PasswordAuthentication(mail_id, mail_pw);
	    }
	    public PasswordAuthentication getPasswordAuthentication() {
	        return pa;
	    }
}
