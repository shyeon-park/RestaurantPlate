package kh.com.semi_project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.com.semi_project.dto.ListFileDTO;

public class ListFileDAO {
		private BasicDataSource bds;
		
		public ListFileDAO() {
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
		
		// 리스트 이미지(파일) 추가
		public int insertFile(ListFileDTO dto) throws Exception {  
			String sql = "INSERT INTO tbl_listFile VALUES(seq_listFile.nextval, ?, ?, ?)";
			
			try(Connection con = this.getConnection();
					PreparedStatement pstmt = con.prepareStatement(sql);){
				
				pstmt.setInt(1, dto.getSeq_list());
				pstmt.setString(2, dto.getOrigin_name());
				pstmt.setString(3, dto.getSystem_name());
				
				int rs = pstmt.executeUpdate();
				if(rs != -1 ) return rs;
			}
			return -1;
		}
		
		// 리스트 이미지(파일)를 불러오는 작업
		public ListFileDTO getFile(int seq_list) throws Exception {    
			String sql = "SELECT * FROM tbl_listFile WHERE seq_list=?";
			
			try(Connection con = this.getConnection();
					PreparedStatement pstmt = con.prepareStatement(sql);){
				
				pstmt.setInt(1, seq_list);
				ResultSet rs = pstmt.executeQuery();
				if(rs.next()) {
					int seq_file = rs.getInt("seq_file");
					String origin_name = rs.getString("origin_name");
					String system_name = rs.getString("system_name");
					return new ListFileDTO(seq_file, seq_list, origin_name, system_name);
				}
			}
			return null;
		}
		
		// 리스트 이미지(파일) 삭제
		public int deleteFile(int seq_list) throws Exception {
			String sql="DELETE FROM tbl_listFile WHERE seq_list=?";
			
			try(Connection con = this.getConnection();
					PreparedStatement pstmt = con.prepareStatement(sql);){
				
				pstmt.setInt(1, seq_list);
				int rs = pstmt.executeUpdate();
				if(rs != -1) return rs;
			}
			return -1;
		}
		
		// 리스트 이미지(파일) 수정
		public int modifyFile(ListFileDTO dto) throws Exception {
			String sql = "UPDATE tbl_listFile SET origin_name=?, system_name=? WHERE seq_list=?";
			
			try(Connection con = this.getConnection();
					PreparedStatement pstmt = con.prepareStatement(sql);){
				
				pstmt.setString(1, dto.getOrigin_name());
				pstmt.setString(2, dto.getSystem_name());
				pstmt.setInt(3, dto.getSeq_list());
				
				int rs = pstmt.executeUpdate();
				if(rs != -1) return rs;
			}
			return -1;
		}
}