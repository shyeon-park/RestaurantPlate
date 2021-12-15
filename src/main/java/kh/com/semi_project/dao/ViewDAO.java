package kh.com.semi_project.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.com.semi_project.dto.ViewDTO;

public class ViewDAO {

	private BasicDataSource bds;
	
	
	public ViewDAO() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context)iCtx.lookup("java:comp/env");
			bds = (BasicDataSource)envCtx.lookup("jdbc/bds");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public Connection getConnection() throws Exception{
		return bds.getConnection();
	}
	
	public ArrayList<ViewDTO> selectAll() throws Exception{
		 String sql = "select * from tbl_view";
		 
		 try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			 
			 ResultSet rs  = pstmt.executeQuery();
			 
			 ArrayList<ViewDTO> list = new ArrayList<>();
			 
			 while(rs.next()) {
				 
				 int seq_rest = rs.getInt("seq_rest");
				 int seq_review = rs.getInt("seq_view");
				 String rest_name = rs.getString("rest_name");
				 String user_name = rs.getString("user_name");
				 String user_id = rs.getString("user_id");
				 String review_content = rs.getString("review_content");
				 Date reivew_date = rs.getDate("review_date");
				 
				 list.add(new ViewDTO(seq_rest, seq_review,rest_name, user_name,user_id, review_content, reivew_date)); 
			 }
			 
			 return list;
		 }
	}
	
	public int insert(ViewDTO dto) throws Exception {
		String sql = "insert into tbl_view values(seq_view.nextval,?,?,?,?,?,sysdate)";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setInt(1, dto.getSeq_rest());
			pstmt.setString(2, dto.getRest_name());
			pstmt.setString(3, dto.getUser_name());
			pstmt.setString(4, dto.getUser_id());
			pstmt.setString(5, dto.getReview_content());
			
			int rs = pstmt.executeUpdate();
			
			if(rs != -1) {
				return rs;
			}
		}
		return -1;
	}
	
	public ArrayList<ViewDTO> selectByRestaurant(int seq_rest) throws Exception {
		
		String sql ="select * from tbl_view where seq_rest = ?";
		

		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setInt(1, seq_rest);
			
			ResultSet rs = pstmt.executeQuery();
			
			ArrayList<ViewDTO> list = new ArrayList<>();
			 
			while(rs.next()) {
				 int seq_review = rs.getInt("seq_view");
				 String rest_name = rs.getString("rest_name");
				 String user_name = rs.getString("user_name");
				 String user_id = rs.getString("user_id");
				 String review_content = rs.getString("review_content");
				 Date reivew_date = rs.getDate("review_date");
				 
				 list.add(new ViewDTO(seq_rest, seq_review,rest_name, user_name, user_id, review_content, reivew_date));
			}
			for(ViewDTO dto : list) {
				System.out.println(dto);
			}
			return list;
		}
	}
	
	public int countAll() throws Exception {
		String sql = "select count(*) from tbl_view";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) return rs.getInt(1);
		}
		return -1;
	}
	
	public ArrayList<ViewDTO> getViewList(int startRange, int endRange) throws Exception{
		String sql = "select * from"
				+ "(select row_number() over(order by seq_view desc) 순위,"
				+ "a.* from tbl_view a)"
				+ "where 순위 between ? and ?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setInt(1, startRange);
			pstmt.setInt(2, endRange);
			
			ResultSet rs = pstmt.executeQuery();
			ArrayList<ViewDTO> list = new ArrayList<>();
			while(rs.next()) {
				int seq_rest = rs.getInt("seq_rest");
				int seq_view = rs.getInt("seq_view");
				String rest_name = rs.getString("rest_name");
				String user_name = rs.getString("user_name");
				String user_id = rs.getString("user_id");
				String review_content = rs.getString("review_content");
				Date review_date = rs.getDate("review_date");
				
				list.add(new ViewDTO(seq_view,seq_rest,rest_name, user_name, user_id, review_content, review_date));
			}
			return list;			
		}
	}
	
public ArrayList<ViewDTO> getViewCheckList(int seq_rest){
		
		String sql = "select * from tbl_view where seq_rest = ?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setInt(1, seq_rest);
			
			ResultSet rs = pstmt.executeQuery();
			
			ArrayList<ViewDTO> list = new ArrayList<>();
			
			while(rs.next()) {
				int seq_view = rs.getInt("seq_view");
				String rest_name = rs.getString("rest_name");
				String user_name = rs.getString("user_name");
				String user_id = rs.getString("user_id");
				String review_content = rs.getString("review_content");
				Date review_date = rs.getDate("review_date");
				
				System.out.println(seq_view);
				
				list.add(new ViewDTO(seq_view,seq_rest,rest_name, user_name, user_id, review_content, review_date));
				
			}
			return list;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
		
	}
public ViewDTO selectBySeq_view(int seq_view) throws Exception {
	String sql = "select * from tbl_view where seq_view=?";
	
	try(Connection con = this.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);){
		
		pstmt.setInt(1, seq_view);
		
		ResultSet rs = pstmt.executeQuery();
		
		ViewDTO dto = new ViewDTO();
		if(rs.next()) {
			dto.setRest_name(rs.getString("rest_name"));
			dto.setUser_id(rs.getString("user_id"));
			dto.setReview_content(rs.getString("review_content"));
			dto.setReview_date(rs.getDate("review_date"));
			dto.setSeq_rest(rs.getInt("seq_rest"));
			dto.setSeq_view(seq_view);
		}
		return dto;
	}
}


public int modify(int seq_view, String review_content) throws Exception {
	String sql = "update tbl_view set review_content=?, review_date=sysdate where seq_view=?";
	
	try(Connection con = this.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);) {
		
		pstmt.setString(1,review_content);
		pstmt.setInt(2, seq_view);
		
		int rs = pstmt.executeUpdate();
		
		if(rs != -1) {
			return rs;
		}
	}
	return -1;
}

public int delete(int seq_view) throws Exception {
	
	String sql = "delete from tbl_view where seq_view = ?";
	
	try(Connection con = this.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);) {
		
		pstmt.setInt(1, seq_view);
		
		int rs = pstmt.executeUpdate();
		
		if(rs != -1) {
			return rs;
		}
	}
	return -1;
}

}