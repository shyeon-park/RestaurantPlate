package kh.com.semi_project.dto;

public class RestaurantFileDTO {
	private int seq_file;
	private int seq_rest;
	private String origin_name;
	private String system_name;
	
	public RestaurantFileDTO() {}

	public RestaurantFileDTO(int seq_file, int seq_rest, String origin_name, String system_name) {
		super();
		this.seq_file = seq_file;
		this.seq_rest = seq_rest;
		this.origin_name = origin_name;
		this.system_name = system_name;
	}

	public int getSeq_file() {
		return seq_file;
	}

	public void setSeq_file(int seq_file) {
		this.seq_file = seq_file;
	}

	public int getSeq_rest() {
		return seq_rest;
	}

	public void setSeq_rest(int seq_rest) {
		this.seq_rest = seq_rest;
	}

	public String getOrigin_name() {
		return origin_name;
	}

	public void setOrigin_name(String origin_name) {
		this.origin_name = origin_name;
	}

	public String getSystem_name() {
		return system_name;
	}

	public void setSystem_name(String system_name) {
		this.system_name = system_name;
	}
	
}
