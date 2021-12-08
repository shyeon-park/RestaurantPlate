package kh.com.semi_project.dto;

import java.sql.Date;

public class MemberDTO {
	
	private String user_id;	
	private String user_password;	
	private String user_nickname;	
	private Date signup_date;	
	private String user_email;	
	private String user_phone;	
	private String post_code;	
	private String road_addr;	
	private String detail_addr;	
	private String extra_addr;	
	private int identification;
	
	public MemberDTO() {}
	public MemberDTO(String user_id, String user_password, String user_nickname, Date signup_date, String user_email,
			String user_phone, String post_code, String road_addr, String detail_addr, String extra_addr,
			int identification) {
		super();
		this.user_id = user_id;
		this.user_password = user_password;
		this.user_nickname = user_nickname;
		this.signup_date = signup_date;
		this.user_email = user_email;
		this.user_phone = user_phone;
		this.post_code = post_code;
		this.road_addr = road_addr;
		this.detail_addr = detail_addr;
		this.extra_addr = extra_addr;
		this.identification = identification;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_password() {
		return user_password;
	}
	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}
	public String getUser_nickname() {
		return user_nickname;
	}
	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}
	public Date getSignup_date() {
		return signup_date;
	}
	public void setSignup_date(Date signup_date) {
		this.signup_date = signup_date;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public String getPost_code() {
		return post_code;
	}
	public void setPost_code(String post_code) {
		this.post_code = post_code;
	}
	public String getRoad_addr() {
		return road_addr;
	}
	public void setRoad_addr(String road_addr) {
		this.road_addr = road_addr;
	}
	public String getDetail_addr() {
		return detail_addr;
	}
	public void setDetail_addr(String detail_addr) {
		this.detail_addr = detail_addr;
	}
	public String getExtra_addr() {
		return extra_addr;
	}
	public void setExtra_addr(String extra_addr) {
		this.extra_addr = extra_addr;
	}
	public int getIdentification() {
		return identification;
	}
	public void setIdentification(int identification) {
		this.identification = identification;
	}	
	
	
}


