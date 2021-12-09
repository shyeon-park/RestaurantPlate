package kh.com.semi_project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

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
		String sql = "INSERT INTO tbl_rest VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

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
				String rest_address = rs.getString("rest_address");
				String rest_tel = rs.getString("rest_tel");
				String rest_time = rs.getString("rest_time");
				String parking_possible = rs.getString("parking_possible");
				String system_name = rs.getString("system_name");
				list.add(new RestaurantJoinFileDTO(seq_rest, seq_list, rest_name, rest_introduction, sido, sigungu, bname, rest_address,
						                             rest_tel, rest_time, parking_possible, system_name)); 
			}
			return list;
		}
		
	}
}
