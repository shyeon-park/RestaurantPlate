package kh.com.semi_project.dto;

public class ListDTO {
	private int seq_list;
	private String list_title;
	
	public ListDTO() {}

	public ListDTO(int seq_list, String list_title) {
		super();
		this.seq_list = seq_list;
		this.list_title = list_title;
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
}
