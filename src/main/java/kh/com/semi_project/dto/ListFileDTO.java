package kh.com.semi_project.dto;

public class ListFileDTO {
	private int seq_file;
	private int seq_list;
	private String origin_name;
	private String system_name;
	
	public ListFileDTO() {}

	public ListFileDTO(int seq_file, int seq_list, String origin_name, String system_name) {
		super();
		this.seq_file = seq_file;
		this.seq_list = seq_list;
		this.origin_name = origin_name;
		this.system_name = system_name;
	}

	public int getSeq_file() {
		return seq_file;
	}

	public void setSeq_file(int seq_file) {
		this.seq_file = seq_file;
	}

	public int getSeq_list() {
		return seq_list;
	}

	public void setSeq_list(int seq_list) {
		this.seq_list = seq_list;
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
