package kh.com.semi_project.dto;

public class RestMarkDTO {
	private int seq_markNo;
	private int seq_rest;
	private String user_id;
	private int mark_check;
	
	public RestMarkDTO() {}

	public RestMarkDTO(int seq_markNo, int seq_rest, String user_id, int mark_check) {
		super();
		this.seq_markNo = seq_markNo;
		this.seq_rest = seq_rest;
		this.user_id = user_id;
		this.mark_check = mark_check;
	}

	public int getSeq_markNo() {
		return seq_markNo;
	}

	public void setSeq_markNo(int seq_markNo) {
		this.seq_markNo = seq_markNo;
	}

	public int getSeq_rest() {
		return seq_rest;
	}

	public void setSeq_rest(int seq_rest) {
		this.seq_rest = seq_rest;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public int getMark_check() {
		return mark_check;
	}

	public void setMark_check(int mark_check) {
		this.mark_check = mark_check;
	}
	
}
