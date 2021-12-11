package kh.com.semi_project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.com.semi_project.dto.ListFileDTO;
import kh.com.semi_project.dto.RestaurantFileDTO;

public class RestaurantFileDAO {
	private BasicDataSource bds;

	public RestaurantFileDAO() {
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

	// 맛집 파일 추가
	public int insertFile(RestaurantFileDTO dto) throws Exception {
		String sql = "INSERT INTO tbl_restFile VALUES(seq_restFile.nextval, ?, ?, ?)";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setInt(1, dto.getSeq_rest());
			pstmt.setString(2, dto.getOrigin_name());
			pstmt.setString(3, dto.getSystem_name());

			int rs = pstmt.executeUpdate();
			if (rs != -1)
				return rs;
		}
		return -1;
	}

	// 맛집 이미지(파일)를 불러오는 작업
	public RestaurantFileDTO getFile(int seq_rest) throws Exception {
		String sql = "SELECT * FROM tbl_restFile WHERE seq_rest=?";

		try (Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setInt(1, seq_rest);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				int seq_file = rs.getInt("seq_file");
				String origin_name = rs.getString("origin_name");
				String system_name = rs.getString("system_name");
				return new RestaurantFileDTO(seq_file, seq_rest, origin_name, system_name);
			}
		}
		return null;
	}

	// 맛집 이미지(파일) 수정
	public int modifyFile(RestaurantFileDTO dto) throws Exception {
		String sql = "UPDATE tbl_restFile SET origin_name=?, system_name=? WHERE seq_rest=?";

		try (Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setString(1, dto.getOrigin_name());
			pstmt.setString(2, dto.getSystem_name());
			pstmt.setInt(3, dto.getSeq_rest());

			int rs = pstmt.executeUpdate();
			if (rs != -1)
				return rs;
		}
		return -1;
	}
}
