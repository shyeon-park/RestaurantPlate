package kh.com.semi_project.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.com.semi_project.dto.MemberDTO;



public class MemberDAO {
	
private BasicDataSource bds;
	
	public MemberDAO(){
		try {
			Context iCtx = new InitialContext();
			Context endCtx = (Context)iCtx.lookup("java:comp/env");
			bds = (BasicDataSource)endCtx.lookup("jdbc/bds");
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public Connection getConnection() throws Exception{
		return bds.getConnection();
	}
	
	public int deleteById(String id) throws Exception{
		String sql = "delete from tbl_member where user_id = ?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setString(1, id);
			int rs = pstmt.executeUpdate();
			if(rs != 0) return rs;
		}
		return -1;		
	}
	
	public int modifyMypage(MemberDTO dto) throws Exception{
		String sql = "update tbl_member set user_nickname = ?,  user_email = ?, user_phone =?, post_code=?, road_addr =?, detail_addr =?,extra_addr =? where  user_id = ?  ";
		try(Connection con = this.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setString(1, dto.getUser_nickname());
			pstmt.setString(2, dto.getUser_email());
			pstmt.setString(3, dto.getUser_phone());
			pstmt.setString(4, dto.getPost_code());
			pstmt.setString(5, dto.getRoad_addr());
			pstmt.setString(6, dto.getDetail_addr());
			pstmt.setString(7, dto.getExtra_addr());
			pstmt.setString(8, dto.getUser_id());
			
			int rs = pstmt.executeUpdate();
			if(rs != -1) return rs;
		}
		return -1;
	}
	//비밀번호변경
	public int changePw(String id, String password) throws Exception{
		String sql = "update tbl_member set user_password = ? where user_id=?";
		try(Connection con = this.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setString(1, password);
			pstmt.setString(2, id);
			
			int rs = pstmt.executeUpdate();
			if(rs != -1) return rs;
		}
		return -1;
	}
	//임시비밀번호 발급
	public int modifyPw(String id, String phone, String password) throws Exception{
		String sql = "update tbl_member set user_password = ? where user_id=? and user_phone =?";
		try(Connection con = this.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setString(1, password);
			pstmt.setString(2, id);
			pstmt.setString(3, phone);
			
			
			int rs = pstmt.executeUpdate();
			if(rs != -1) return rs;
		}
		return -1;
	}
	
	public MemberDTO selectByDto(String id) throws Exception{
		String sql = "select * from tbl_member where user_id =?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setString(1, id);
			
			ResultSet rs = pstmt.executeQuery();
			MemberDTO dto = new MemberDTO();
			if(rs.next()) {
				dto.setUser_id(rs.getString(1));
				dto.setUser_password(rs.getString(2));
				dto.setUser_nickname(rs.getString(3));
				dto.setSignup_date(rs.getDate(4));
				dto.setUser_email(rs.getString(5));
				dto.setUser_phone(rs.getString(6));
				dto.setPost_code(rs.getString(7));
				dto.setRoad_addr(rs.getString(8));
				dto.setDetail_addr(rs.getString(9));
				dto.setExtra_addr(rs.getString(10));
				dto.setIdentification(rs.getInt(11));
			}
			return dto;
	   }
	}
	
	
	public String selectById(String phone) throws Exception{
		String sql = "select * from tbl_member where user_phone =?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setString(1, phone);
			String id ;
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				id = rs.getString(1);
				return rs.getString(1);
			}
			return "x";
	   }
		
	}
	public int insert(MemberDTO dto) throws Exception{
		String sql = "insert into TBL_MEMBER values(? ,? ,? ,DEFAULT ,? ,? ,? ,? , ?, ?,0)";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
				
			pstmt.setString(1, dto.getUser_id());
			pstmt.setString(2, dto.getUser_password());
			pstmt.setString(3, dto.getUser_nickname());
			pstmt.setString(4, dto.getUser_email());
			pstmt.setString(5, dto.getUser_phone());
			
			pstmt.setString(6, dto.getPost_code());
			pstmt.setString(7, dto.getRoad_addr());
			pstmt.setString(8, dto.getDetail_addr());
			pstmt.setString(9, dto.getExtra_addr());
			
			int rs = pstmt.executeUpdate();
			if(rs != -1) return rs;
		}
		return -1;
	}
	
	public boolean isLoginOk(String id, String pw) throws Exception{
		String sql ="select * from tbl_member where user_id = ? and user_password =?";
		
		try(Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
				pstmt.setString(1, id);
				pstmt.setString(2, pw);
				
				ResultSet rs = pstmt.executeQuery();
				if(rs.next()) return true;
				}catch (Exception e) {
					e.printStackTrace();
				}
		return false;
	}
}