package kh.com.semi_project.dto;

public class ListJoinFileDTO {
	private int seq_list;
	private String list_title;
	private String system_name;
	
	public ListJoinFileDTO() {}

	public ListJoinFileDTO(int seq_list, String list_title, String system_name) {
		super();
		this.seq_list = seq_list;
		this.list_title = list_title;
		this.system_name = system_name;
	}

	public int getSeq_list() {
		return seq_list;
	}

	public void setSeq_list(int seq_list) {
		this.seq_list = seq_list;
	}

	public String getList_title() {
		return list_title;
	}

	public void setList_title(String list_title) {
		this.list_title = list_title;
	}

	public String getSystem_name() {
		return system_name;
	}

	public void setSystem_name(String system_name) {
		this.system_name = system_name;
	}
	
}
