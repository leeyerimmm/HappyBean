package Controls;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import Controls.DBConnectionMgr;

public class joinMgr {
	private DBConnectionMgr pool;
	
	public joinMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// ID 중복체크
	public boolean idCheck(String user_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select * from usertbl where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				flag = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return flag;
	}
	
	// E-mail 중복체크
	public boolean emailCheck(String email) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select * from usertbl where email = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				flag = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return flag;
	}
	
	// 연락처 중복체크
	public boolean phoneCheck(String phone) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select * from usertbl where phone = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, phone);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				flag = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return flag;
	}
	
	// 회원가입
	public boolean insertUser(joinBean jBean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert into usertbl (user_num, user_id, pwd, name, email, phone, add1, add2, gender, regdate, user_type, amount_held)"
					+ "values (default, ?, ?, ?, ?, ?, ?, ?, ?, now(), '유저', 0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, jBean.getUser_id());
			pstmt.setString(2, jBean.getPwd());
			pstmt.setString(3, jBean.getName());
			pstmt.setString(4, jBean.getEmail());
			pstmt.setString(5, jBean.getPhone());
			pstmt.setString(6, jBean.getAdd1());
			pstmt.setString(7, jBean.getAdd2());
			pstmt.setString(8, jBean.getGender());
			if(pstmt.executeUpdate() == 1) {
				flag = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	// 로그인 기능
	public boolean login(String user_id, String pwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select * from usertbl where user_id = ? and pwd = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				flag = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	// 유저 정보 페이지 불러오기
	public joinBean userInfo(String user_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		joinBean bean = new joinBean();
		try {
			con = pool.getConnection();
			sql = "select * from usertbl where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setName(rs.getString("name"));
				bean.setAmount_held(rs.getInt("amount_held"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	// 금액 충전
	public boolean chargeAmount(String user_id, int charge) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update usertbl set amount_held = case "
							+ "when amount_held + ? > 10000000 then 10000000 "
							+ "else amount_held + ? "
						+ "end "
					+ "where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, charge);
			pstmt.setInt(2, charge);
			pstmt.setString(3, user_id);
			if(pstmt.executeUpdate() == 1) {
				flag = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	// 정보 불러오기
	public joinBean callInfo(String user_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		joinBean bean = new joinBean();
		try {
			con = pool.getConnection();
			sql = "select * from usertbl where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setName(rs.getString("name"));
				bean.setPwd(rs.getString("pwd"));
				bean.setEmail(rs.getString("email"));
				bean.setPhone(rs.getString("phone"));
				bean.setAdd1(rs.getString("add1"));
				bean.setAdd2(rs.getString("add2"));
				bean.setGender(rs.getString("gender"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	// 회원정보 수정
	public boolean editUser(joinBean jBean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update usertbl set "
					+ "pwd = ?, name = ?, email = ?, phone = ?, add1 = ?, add2 = ?, gender = ? "
					+ "where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, jBean.getPwd());
			pstmt.setString(2, jBean.getName());
			pstmt.setString(3, jBean.getEmail());
			pstmt.setString(4, jBean.getPhone());
			pstmt.setString(5, jBean.getAdd1());
			pstmt.setString(6, jBean.getAdd2());
			pstmt.setString(7, jBean.getGender());
			pstmt.setString(8, jBean.getUser_id());
			if(pstmt.executeUpdate() == 1) {
				flag = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	// 보유 금액
	public int amountHeld(String user_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int amount_held = 0;
		try {
			con = pool.getConnection();
			sql = "select amount_held from usertbl where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				amount_held = rs.getInt("amount_held");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return amount_held;
	}
}
