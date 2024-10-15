package donation;

import java.sql.Connection;
import java.sql.PreparedStatement; // PreparedStatement 임포트
import java.sql.ResultSet;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnectionMgr {

    private static DBConnectionMgr instance;

    private DBConnectionMgr() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static DBConnectionMgr getInstance() {
        if (instance == null) {
            instance = new DBConnectionMgr();
        }
        return instance;
    }

    public Connection getConnection() throws SQLException {
        String url = "jdbc:mysql://127.0.0.1:3306/happypotato?useUnicode=true&characterEncoding=UTF-8";
        String user = "root";
        String password = "1234";
        return DriverManager.getConnection(url, user, password);
    }

    public void freeConnection(Connection conn, PreparedStatement pstmt, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void freeConnection(Connection conn, PreparedStatement pstmt) {
        freeConnection(conn, pstmt, null);
    }
}
