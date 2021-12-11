package kh.com.semi_project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.com.semi_project.dto.ListDTO;
import kh.com.semi_project.dto.RestaurantDTO;
import kh.com.semi_project.dto.RestaurantJoinFileDTO;

public class RestaurantDAO {
	private BasicDataSource bds;

	public RestaurantDAO() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context) iCtx.lookup("java:comp/env");
			bds = (BasicDataSource) envCtx.lookup("jdbc/bds");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public Connection getConnection() throws Exception {
		return bds.getConnection();
	}

	// 맛집 번호를 미리 불러오는 작업
	public int getRestaurantSequence() throws Exception {
		String sql = "SELECT seq_rest.nextval FROM dual";

		try (Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {

			ResultSet rs = pstmt.executeQuery();
			if (rs.next())
				return rs.getInt(1);
		}
		return -1;
	}

	// 맛집 등록 작업
	public int addRestaurant(RestaurantDTO dto) throws Exception {
		String sql = "INSERT INTO tbl_rest VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";

		try (Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setInt(1, dto.getSeq_rest());
			pstmt.setInt(2, dto.getSeq_list());
			pstmt.setString(3, dto.getRest_name());
			pstmt.setString(4, dto.getRest_introduction());
			pstmt.setString(5, dto.getSido());
			pstmt.setString(6, dto.getSigungu());
			pstmt.setString(7, dto.getBname());
			pstmt.setString(8, dto.getPostCode());
			pstmt.setString(9, dto.getRest_address());
			pstmt.setString(10, dto.getRest_tel());
			pstmt.setString(11, dto.getRest_time());
			pstmt.setString(12, dto.getParking_possible());

			int rs = pstmt.executeUpdate();

			if (rs != -1)
				return rs;
		}
		return -1;
	}
	
	// 해당 리스트의 맛집들을 맛집테이블과 맛집파일테이블을 조인하여 새로운 DTO로 뿌려주는 작업
	public ArrayList<RestaurantJoinFileDTO> selectRestAndFileBySeq(int listNum) throws Exception {
		String sql = "SELECT * FROM tbl_rest JOIN tbl_restFile USING(seq_rest) WHERE seq_list=?";
		
		try (Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			
			pstmt.setInt(1, listNum);
			
			ResultSet rs = pstmt.executeQuery();
			ArrayList<RestaurantJoinFileDTO> list = new ArrayList<>();
			while(rs.next()) {
				int seq_rest = rs.getInt("seq_rest");
				int seq_list = rs.getInt("seq_list");
				String rest_name = rs.getString("rest_name");
				String rest_introduction = rs.getString("rest_introduction");
				String sido = rs.getString("sido");
				String sigungu = rs.getString("sigungu");
				String bname = rs.getString("bname");
				String postCode = rs.getString("postCode");
				String rest_address = rs.getString("rest_address");
				String rest_tel = rs.getString("rest_tel");
				String rest_time = rs.getString("rest_time");
				String parking_possible = rs.getString("parking_possible");
				String system_name = rs.getString("system_name");
				list.add(new RestaurantJoinFileDTO(seq_rest, seq_list, rest_name, rest_introduction, sido, sigungu, bname, postCode, rest_address,
						                             rest_tel, rest_time, parking_possible, system_name)); 
			}
			return list;
		}	
	}
	
	// 해당 번호의 맛집정보 조회
	public RestaurantDTO selectBySeq_rest(int seq_rest) throws Exception {
			String sql = "SELECT * FROM tbl_rest WHERE seq_rest=?";
			
			try(Connection con = this.getConnection();
					PreparedStatement pstmt = con.prepareStatement(sql);){
				
				pstmt.setInt(1, seq_rest);
				
				ResultSet rs = pstmt.executeQuery();
				if(rs.next()) {
					int seq_list = rs.getInt("seq_list");
					String rest_name = rs.getString("rest_name");
					String rest_introduction = rs.getString("rest_introduction");
					String sido = rs.getString("sido");
					String sigungu = rs.getString("sigungu");
					String bname = rs.getString("bname");
					String postCode = rs.getString("postCode");
					String rest_address = rs.getString("rest_address");
					String rest_tel = rs.getString("rest_tel");
					String rest_time = rs.getString("rest_time");
					String parking_possible = rs.getString("parking_possible");
					int mark_count = rs.getInt("mark_count");
					
					return new RestaurantDTO(seq_rest, seq_list, rest_name, rest_introduction,
							  sido, sigungu, bname, postCode, rest_address, rest_tel, rest_time, parking_possible, mark_count);
				}
			}
			return null;
	}
	
	// 추천 카운트 올리는 작업
	public int markCountUp(int seq_rest) throws Exception {
		String sql = "UPDATE tbl_rest SET mark_count = mark_count+1 WHERE seq_rest=?";
		
		try(Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setInt(1, seq_rest);
			
			int rs = pstmt.executeUpdate();
			if(rs != -1) return rs;
		}
		return -1;
	}
	
	// 추천 카운트 내리는 작업
	public int markCountDown(int seq_rest) throws Exception {
		String sql = "UPDATE tbl_rest SET mark_count = mark_count-1 WHERE seq_rest=?";
		
		try(Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setInt(1, seq_rest);
			
			int rs = pstmt.executeUpdate();
			if(rs != -1) return rs;
		}
		return -1;
	}
	
	// 총 추천 카운트 불러오는 작업
	public int getTotalMarkCount(int seq_rest) throws Exception {
		String sql = "SELECT * FROM tbl_rest WHERE seq_rest = ?";
		
		try(Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setInt(1, seq_rest);
			
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) return rs.getInt("mark_count");
		}
		return -1;
	}
	
	// 맛집 수정
	public int modifyBySeq(RestaurantDTO dto) throws Exception {
		String sql = "UPDATE tbl_rest SET rest_name=?, rest_introduction=?, sido=?, sigungu=?, bname=?, postCode=?,"
				+ " rest_address=?, rest_tel=?, rest_time=?, parking_possible=? WHERE seq_rest=?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setString(1, dto.getRest_name());
			pstmt.setString(2, dto.getRest_introduction());
			pstmt.setString(3, dto.getSido());
			pstmt.setString(4, dto.getSigungu());
			pstmt.setString(5, dto.getBname());
			pstmt.setString(6, dto.getPostCode());
			pstmt.setString(7, dto.getRest_address());
			pstmt.setString(8, dto.getRest_tel());
			pstmt.setString(9, dto.getRest_time());
			pstmt.setString(10, dto.getParking_possible());
			pstmt.setInt(11, dto.getSeq_rest());
			
			int rs = pstmt.executeUpdate();
			if(rs != -1 ) return rs;
			
		}
		return -1;
	}
}
