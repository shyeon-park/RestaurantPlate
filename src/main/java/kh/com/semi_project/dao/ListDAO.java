package kh.com.semi_project.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.com.semi_project.dto.ListDTO;
import kh.com.semi_project.dto.ListJoinFileDTO;
import kh.com.semi_project.dto.ViewDTO;

public class ListDAO {
	private BasicDataSource bds;
	
	public ListDAO() {
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
	
	// 리스트 번호를 불러오는 작업
	public int getListSequence() throws Exception {
		String sql = "SELECT seq_list.nextval FROM dual";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) return rs.getInt(1);
		}
		return -1;
	}
	
	// 리스트 등록(추가) 작업
	public int addList(ListDTO dto) throws Exception {
		String sql = "INSERT INTO tbl_list VALUES(?, ?)";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setInt(1, dto.getSeq_list());
			pstmt.setString(2, dto.getList_title());
			
			int rs = pstmt.executeUpdate();
			
			if(rs != -1) return rs;
		}
		return -1;
	}
	
	// 리스트 전체목록 불러오는 작업
	public ArrayList<ListDTO> selectAll() throws Exception {
		String sql = "SELECT * FROM tbl_list";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			ResultSet rs = pstmt.executeQuery();
			ArrayList<ListDTO> list = new ArrayList<>();
			while(rs.next()) {
				int seq_list = rs.getInt("seq_list");
				String list_title = rs.getString("list_title");
				list.add(new ListDTO(seq_list, list_title));
			}
			return list;
		}
	}
	
	// 리스트 번호로 해당 리스트 정보를 불러오는 작업
	public ListDTO selectBySeq(int seq_list) throws Exception {
		String sql = "SELECT * FROM tbl_list WHERE seq_list = ?";
		
		try(Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			
			pstmt.setInt(1, seq_list);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				String title = rs.getString("list_title");
				ListDTO dto = new ListDTO(seq_list, title);
				return dto;
			}
		}
		return null;
	}
	
	// 리스트 삭제
	public int deleteBySeq(int seq_list) throws Exception {
		String sql = "DELETE FROM tbl_list WHERE seq_list=?";
		
		try(Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setInt(1, seq_list);
			int rs = pstmt.executeUpdate();
			if(rs != -1) return rs;
		}
		return -1;
	}
	
	// 리스트 수정
	public int modifyBySeq(ListDTO dto) throws Exception {
		String sql = "UPDATE tbl_list SET list_title=? WHERE seq_list=?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setString(1, dto.getList_title());
			pstmt.setInt(2, dto.getSeq_list());
			
			int rs = pstmt.executeUpdate();
			if(rs != -1) return rs;
		}
		return -1;
	}
	
	// 리스트 테이블과 리스트파일 테이블을 조인해서 8개의 데이터를 랜덤으로 뽑아주는 작업
	public ArrayList<ListJoinFileDTO> getHomeListRandom() throws Exception {
		String sql = "select * from (select * from tbl_list order by dbms_random.random())"
				     + "JOIN tbl_listFile USING(seq_list) where rownum <= 8";
		
		try(Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
			
			ResultSet rs = pstmt.executeQuery();
			ArrayList<ListJoinFileDTO> list = new ArrayList<>();
			while(rs.next()) {
				int seq_list = rs.getInt("seq_list");
				String list_title = rs.getString("list_title");
				String system_name = rs.getString("system_name");
				list.add(new ListJoinFileDTO(seq_list, list_title, system_name));
			}
			return list;
		}
	}
	
	
	// ListFile 테이블과 조인하여 모든 데이터 조회
	public ArrayList<ListJoinFileDTO> selectListAndFileAll() throws Exception {
		String sql = "select * from tbl_list JOIN tbl_listFile USING (seq_list)";
		
		try(Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
			
			ResultSet rs = pstmt.executeQuery();
			ArrayList<ListJoinFileDTO> list = new ArrayList<>();
			while(rs.next()) {
				int seq_list = rs.getInt("seq_list");
				String list_title = rs.getString("list_title");
				String system_name = rs.getString("system_name");
				list.add(new ListJoinFileDTO(seq_list, list_title, system_name));
			}
			return list;
		}
	}
	
	// 리스트의 총 갯수 확인
	public int listCountAll() throws Exception {
		String sql = "SELECT COUNT(*) FROM tbl_list";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) return rs.getInt(1);
		}
		return -1;
	}
	
	// 리스트 목록을 번호순으로 정렬하여 순위를 매겨 뿌려주는 작업
	public ArrayList<ListDTO> getRestaurantList(int startRange, int endRange) throws Exception{
		String sql = "SELECT * FROM"
				+ "(SELECT ROW_NUMBER() OVER(ORDER BY seq_list DESC) 순위,"
				+ "a.* FROM tbl_list a)"
				+ "WHERE 순위 BETWEEN ? AND ?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setInt(1, startRange);
			pstmt.setInt(2, endRange);
			
			ResultSet rs = pstmt.executeQuery();
			ArrayList<ListDTO> list = new ArrayList<>();
			while(rs.next()) {
				int seq_list = rs.getInt("seq_list");
				String list_title = rs.getString("list_title");			
				list.add(new ListDTO(seq_list, list_title));
			}
			return list;			
		}
	}
	
}
