package kh.com.semi_project.dto;

public class RestaurantDTO {
	private int seq_rest;
	private int seq_list;
	private String rest_name;
	private String rest_introduction;
	private String sido;
	private String sigungu;
	private String bname;
	private String postCode;
	private String rest_address;
	private String rest_tel;
	private String rest_time;
	private String parking_possible;
	
	public RestaurantDTO() {}

	

	public RestaurantDTO(int seq_rest, int seq_list, String rest_name, String rest_introduction, String sido,
			String sigungu, String bname, String postCode, String rest_address, String rest_tel, String rest_time,
			String parking_possible) {
		super();
		this.seq_rest = seq_rest;
		this.seq_list = seq_list;
		this.rest_name = rest_name;
		this.rest_introduction = rest_introduction;
		this.sido = sido;
		this.sigungu = sigungu;
		this.bname = bname;
		this.postCode = postCode;
		this.rest_address = rest_address;
		this.rest_tel = rest_tel;
		this.rest_time = rest_time;
		this.parking_possible = parking_possible;
	}



	public int getSeq_rest() {
		return seq_rest;
	}



	public void setSeq_rest(int seq_rest) {
		this.seq_rest = seq_rest;
	}



	public int getSeq_list() {
		return seq_list;
	}



	public void setSeq_list(int seq_list) {
		this.seq_list = seq_list;
	}



	public String getRest_name() {
		return rest_name;
	}



	public void setRest_name(String rest_name) {
		this.rest_name = rest_name;
	}



	public String getRest_introduction() {
		return rest_introduction;
	}



	public void setRest_introduction(String rest_introduction) {
		this.rest_introduction = rest_introduction;
	}



	public String getSido() {
		return sido;
	}



	public void setSido(String sido) {
		this.sido = sido;
	}



	public String getSigungu() {
		return sigungu;
	}



	public void setSigungu(String sigungu) {
		this.sigungu = sigungu;
	}



	public String getBname() {
		return bname;
	}



	public void setBname(String bname) {
		this.bname = bname;
	}



	public String getPostCode() {
		return postCode;
	}



	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}



	public String getRest_address() {
		return rest_address;
	}



	public void setRest_address(String rest_address) {
		this.rest_address = rest_address;
	}



	public String getRest_tel() {
		return rest_tel;
	}



	public void setRest_tel(String rest_tel) {
		this.rest_tel = rest_tel;
	}



	public String getRest_time() {
		return rest_time;
	}



	public void setRest_time(String rest_time) {
		this.rest_time = rest_time;
	}



	public String getParking_possible() {
		return parking_possible;
	}



	public void setParking_possible(String parking_possible) {
		this.parking_possible = parking_possible;
	}
	
}
