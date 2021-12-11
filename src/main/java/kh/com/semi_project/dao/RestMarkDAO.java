package kh.com.semi_project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.com.semi_project.dto.RestMarkDTO;

public class RestMarkDAO {
private BasicDataSource bds;
	
	public RestMarkDAO() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context)iCtx.lookup("java:comp/env");
			bds = (BasicDataSource)envCtx.lookup("jdbc/bds");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public Connection getConnection() throws Exception {
		return bds.getConnection();
	}
	
	// 마크 추가
	public int insertMark(RestMarkDTO dto) throws Exception {
		String sql = "INSERT INTO tbl_restMark VALUES(seq_restMark.nextval, ?, ?, ?)";
		
		try(Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setInt(1, dto.getSeq_rest());
			pstmt.setString(2, dto.getUser_id());
			pstmt.setInt(3, dto.getMark_check() + 1);
			
			int rs = pstmt.executeUpdate();
			if(rs != -1) return rs;
			
		}
		return -1;
	}
	
	// 마크 삭제
	public int deleteMark(int seq_rest, String user_id) throws Exception {
		String sql = "DELETE FROM tbl_restMark WHERE seq_rest=? AND user_id=?";
		
		try(Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			
			pstmt.setInt(1, seq_rest);
			pstmt.setString(2, user_id);
			
			int rs = pstmt.executeUpdate();
			if(rs != -1) return rs;
		}
		return -1;
	}
	
	// 인자값으로 넘어온 맛집번호와 아이디를 가진 마커정보가 있는지 확인하여 dto로 뿌려줌
//	public RestMarkDTO selectBySeqAndId(int seq_rest, String user_id) throws Exception {
//		String sql = "SELECT * FROM tbl_restMark WHERE seq_rest=? AND user_id=?";
//		
//		try(Connection con = this.getConnection();
//				PreparedStatement pstmt = con.prepareStatement(sql);) {
//			
//			pstmt.setInt(1, seq_rest);
//			pstmt.setString(2, user_id);
//			
//			ResultSet rs = pstmt.executeQuery();
//			if(rs.next()) {
//				int restmark_possible = rs.getInt("restmark_possible");
//				return new RestMarkDTO(seq_rest, user_id, restmark_possible);
//			}
//			return null;
//		}
//	}
	
	// 마커 체크
	public  RestMarkDTO checkRestMark(int seq_rest, String user_id) throws Exception {
		String sql = "SELECT * FROM tbl_restMark WHERE seq_rest=? AND user_id=?";
		
		try(Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setInt(1, seq_rest);
			pstmt.setString(2, user_id);
			
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				int seq_markNo = rs.getInt("seq_markNo");
				int restNum = rs.getInt("seq_rest");
				String id = rs.getString("user_id");
				int mark_check = rs.getInt("mark_check");
				
				return new RestMarkDTO(seq_markNo, restNum, id, mark_check);
			}
		}
		return null;
	}
}
