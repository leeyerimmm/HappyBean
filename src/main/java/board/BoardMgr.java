package board;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.DriverManager;
import java.util.Vector;

import java.sql.SQLException;
import java.util.List;
import java.util.Arrays;

public class BoardMgr {

	private DBConnectionMgr pool;

	public BoardMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 게시판 리스트 가져오기
	public Vector<BoardBean> getBoardList(String keyField, String keyWord, int start, int end) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector<BoardBean> vlist = new Vector<BoardBean>();
		String sql = "SELECT id, title, content, createdAt FROM NoticesTBL";

		try {
			con = pool.getConnection(); // DB 연결 객체를 얻어옵니다.

			// SQL 쿼리 작성 (검색어 유무에 따라 다르게 처리)
			if (keyWord != null && !keyWord.equals("")) {
				// 검색 필드가 title 또는 content로만 제한됨
				if (keyField.equals("title") || keyField.equals("content")) {
					sql += " WHERE " + keyField + " LIKE ?";
				} else {
					throw new IllegalArgumentException("Invalid search field.");
				}
			}

			sql += " ORDER BY createdAt DESC LIMIT ?, ?"; // 페이징 처리

			pstmt = con.prepareStatement(sql);
			if (keyWord != null && !keyWord.equals("")) {
				pstmt.setString(1, "%" + keyWord + "%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			} else {
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
			}

			rs = pstmt.executeQuery();
			while (rs.next()) {
				BoardBean bean = new BoardBean();
				bean.setId(rs.getInt("id"));
				bean.setTitle(rs.getString("title"));
				bean.setContent(rs.getString("content"));
				bean.setCreatedAt(rs.getTimestamp("createdAt"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// 총 게시물 수 가져오기
	public int getTotalCount(String keyField, String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT COUNT(*) FROM NoticesTBL";
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if (keyWord != null && !keyWord.equals("")) {
				// 검색 필드가 title 또는 content로만 제한됨
				if (keyField.equals("title") || keyField.equals("content")) {
					sql += " WHERE " + keyField + " LIKE ?";
				} else {
					throw new IllegalArgumentException("Invalid search field.");
				}
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
			} else {
				pstmt = con.prepareStatement(sql);
			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}

	// 게시물 입력
	public boolean insertBoard(String title, String description) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO noticestbl (title, content, createdAt) VALUES (?, ?, NOW())";

		try {
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, description);

			return pstmt.executeUpdate() > 0; // 성공 시 true 반환
		} catch (Exception e) {
			e.printStackTrace();
			return false; // 실패 시 false 반환
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	private Connection getConnection() {
		try {
			String url = "jdbc:mysql://localhost:3306/mydb"; // DB URL
			String user = "root"; // DB 사용자명
			String password = "1234"; // DB 비밀번호
			return DriverManager.getConnection(url, user, password);
		} catch (SQLException e) {
			e.printStackTrace();
			return null; // DB 연결 실패 시 null 반환
		}
	}

	// 게시물 가져오기 (단일 게시물)
	public BoardBean getBoard(int id) {
		BoardBean bean = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = pool.getConnection(); // 커넥션 풀에서 커넥션 가져오기
			String sql = "SELECT * FROM noticestbl WHERE id = ?"; // ID로 게시물 조회
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				bean = new BoardBean();
				bean.setId(rs.getInt("id"));
				bean.setTitle(rs.getString("title"));
				bean.setContent(rs.getString("content"));
				bean.setCreatedAt(rs.getTimestamp("createdAt"));
				// 필요한 경우 다른 필드도 여기에 추가 가능
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs); // 커넥션 해제
		}

		return bean; // 하나의 게시물 반환
	}

	// 게시물 삭제
	public boolean deleteBoard(int id) {
		String sql = "DELETE FROM NoticesTBL WHERE id=?";
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			return pstmt.executeUpdate() > 0; // 성공 시 true 반환
		} catch (Exception e) {
			e.printStackTrace();
			return false; // 실패 시 false 반환
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	// 게시물 수정
	public boolean updateBoard(BoardBean bean) {
		String sql = "UPDATE NoticesTBL SET title=?, content=? WHERE id=?";
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getTitle());
			pstmt.setString(2, bean.getContent());
			pstmt.setInt(3, bean.getId());
			return pstmt.executeUpdate() > 0; // 성공 시 true 반환
		} catch (Exception e) {
			e.printStackTrace();
			return false; // 실패 시 false 반환
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	// ID가 가장 큰 게시글의 제목을 가져오는 메서드
	public String getMaxIdTitle() {
		String title = null;
		String sql = "SELECT title FROM NoticesTBL ORDER BY id DESC LIMIT 1"; // NoticesTBL에서 제목을 조회

		try (Connection conn = getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {

			if (rs.next()) {
				title = rs.getString("title");
			}
		} catch (SQLException e) {
			e.printStackTrace(); // 예외 처리
		}

		return title;
	}

	// ID가 가장 큰 게시글의 ID를 가져오는 메서드
	public int getMaxId() {
		int maxId = -1; // 기본값
		String sql = "SELECT id FROM NoticesTBL ORDER BY id DESC LIMIT 1";

		try (Connection conn = getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {

			if (rs.next()) {
				maxId = rs.getInt("id");
			}
		} catch (SQLException e) {
			e.printStackTrace(); // 예외 처리
		}

		return maxId;
	}

}
