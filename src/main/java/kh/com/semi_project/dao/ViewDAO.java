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
				 String user_id = rs.getString("user_id");
				 String review_content = rs.getString("review_content");
				 Date reivew_date = rs.getDate("review_date");
				 
				 list.add(new ViewDTO(seq_rest, seq_review, user_id, review_content, reivew_date)); 
			 }
			 
			 return list;
		 }
	}
	
	public int insert(ViewDTO dto) throws Exception {
		String sql = "insert into tbl_view values(seq_view.nextval,?,?,?,sysdate)";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setInt(1, dto.getSeq_rest());
			pstmt.setString(2, dto.getUser_id());
			pstmt.setString(3, dto.getReview_content());
			
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
				 String user_id = rs.getString("user_id");
				 String review_content = rs.getString("review_content");
				 Date reivew_date = rs.getDate("review_date");
				 
				 list.add(new ViewDTO(seq_rest, seq_review, user_id, review_content, reivew_date));
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
				String user_id = rs.getString("user_id");
				String review_content = rs.getString("review_content");
				Date review_date = rs.getDate("review_date");
				
				list.add(new ViewDTO(seq_rest, seq_view, user_id, review_content, review_date));
			}
			return list;			
		}
	}

}