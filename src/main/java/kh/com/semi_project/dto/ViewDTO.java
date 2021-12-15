package kh.com.semi_project.dto;

import java.sql.Date;

public class ViewDTO {

	private int seq_view;
	private int seq_rest;
	private String rest_name;
	private String user_name;
	private String user_id;
	private String review_content;
	private Date review_date;
	
	public ViewDTO() {}

	public ViewDTO(int seq_view, int seq_rest, String rest_name, String user_name, String user_id,
			String review_content, Date review_date) {
		super();
		this.seq_view = seq_view;
		this.seq_rest = seq_rest;
		this.rest_name = rest_name;
		this.user_name = user_name;
		this.user_id = user_id;
		this.review_content = review_content;
		this.review_date = review_date;
	}

	public int getSeq_view() {
		return seq_view;
	}

	public void setSeq_view(int seq_view) {
		this.seq_view = seq_view;
	}

	public int getSeq_rest() {
		return seq_rest;
	}

	public void setSeq_rest(int seq_rest) {
		this.seq_rest = seq_rest;
	}

	public String getRest_name() {
		return rest_name;
	}

	public void setRest_name(String rest_name) {
		this.rest_name = rest_name;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getReview_content() {
		return review_content;
	}

	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}

	public Date getReview_date() {
		return review_date;
	}

	public void setReview_date(Date review_date) {
		this.review_date = review_date;
	}

}