package kh.com.semi_project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

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
}
