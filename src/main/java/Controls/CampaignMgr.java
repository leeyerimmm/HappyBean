package Controls;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

public class CampaignMgr {
	
	private DBConnectionMgr pool;
	
	public CampaignMgr() {
		try {
			pool = DBConnectionMgr.getInstance(); // DBConnectionMgr의 인스턴스를 가져옵니다.
		} catch (Exception e) {
			e.printStackTrace();
		}
	}// end of public CampaignMgr()
	
	public void closeResources(Connection con, PreparedStatement pstmt, ResultSet rs) {
	    try {
	        if (rs != null) {
	            rs.close();
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    
	    try {
	        if (pstmt != null) {
	            pstmt.close();
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    try {
	        if (con != null) {
	            con.close();
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}// end of public void closeResources()
	
	
	// 현재 날짜와 end_date가 일치할 경우 status 업데이트
	public void updateCampaignStatus() {
		Connection con = null;
        PreparedStatement pstmt = null;
        
        try {
        	con = pool.getConnection();        	
        	String sql = "UADATE campaignTBL SET status = '종료' WHERE end_date = ?";
        	pstmt = con.prepareStatement(sql);
        	
        	Date currentDate = new Date(System.currentTimeMillis());
        	pstmt.setDate(1, currentDate);
        	
        	int rowsUpdated = pstmt.executeUpdate();
        	
        	System.out.println(rowsUpdated + "개의 켐페인 상태가 업데이트되었습니다."); // 업데이트된 행 수 출력
        } catch(Exception e) {
        	e.printStackTrace();
        } finally {
        	pool.freeConnection(con, pstmt, null);
        }
	}//end of public void updateCampaignStatus()
	
	// 켐페인 목록 조회
	public Vector<CampaignBean> getCampaignList() {
		Vector<CampaignBean> campaignList = new Vector<CampaignBean>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = pool.getConnection();
			String sql = "SELECT * FROM campaignTBL";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CampaignBean bean = new CampaignBean();
				bean.setNum(rs.getInt("num"));
				bean.setStatus(rs.getString("status"));
				bean.setTitle(rs.getString("title"));
				bean.setHash_tag(rs.getString("hash_tag"));
				bean.setThumb(rs.getString("thumb"));
				bean.setStart_date(rs.getString("start_date"));
				bean.setEnd_date(rs.getString("end_date"));
				bean.setDescription(rs.getString("description"));
				campaignList.add(bean); // 리스트에 추가
			}
			
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return campaignList;
	}//end of public Vector<CampaignBean> getCampaignList()
	
	// 켐페인 글 상세보기(read)
	public CampaignBean getCampaignById(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		CampaignBean bean = new CampaignBean();
		
		try{
			con = pool.getConnection();
			sql = "SELECT * FROM campaignTBL WHERE num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bean = new CampaignBean();
				bean.setNum(rs.getInt("num"));
				bean.setStatus(rs.getString("status"));
				bean.setTitle(rs.getString("title"));
				bean.setHash_tag(rs.getString("hash_tag"));
				bean.setThumb(rs.getString("thumb"));
				bean.setStart_date(rs.getString("start_date"));
				bean.setEnd_date(rs.getString("end_date"));
				bean.setDescription(rs.getString("description"));
			}
			
		} catch(Exception e) {
			
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}		
		
		return bean;
	}//end of public CampaignBean getCampaignById()
	
	//켐페인 등록
	public boolean insertCampaign(CampaignBean bean) {
		Connection con = null;
	    PreparedStatement pstmt = null;
	    boolean flag = false;
	    
	    try {
	    	con = pool.getConnection();
	    	String sql = "INSERT INTO campaignTBL (status, title, hash_tag, thumb, start_date, end_date, description) VALUE (?, ?, ?, ?, ?, ?, ?);";
	    	pstmt = con.prepareStatement(sql);
	    	
	    	pstmt.setString(1, bean.getStatus());
	    	pstmt.setString(2, bean.getTitle());
	    	pstmt.setString(2, bean.getHash_tag());
	    	pstmt.setString(4, bean.getThumb());
	    	pstmt.setString(5, bean.getStart_date());
	    	pstmt.setString(6, bean.getEnd_date());
	    	pstmt.setString(7, bean.getDescription());
	    	
	    	int rowsAffected = pstmt.executeUpdate();
	    	
	    	if(rowsAffected > 0) {
	    		flag = true;
	    	}
	    	
	    } catch(Exception e) {
	    	e.printStackTrace();
	    } finally {
	    	pool.freeConnection(con, pstmt, null);
	    }
	    
	    return flag;
	}// end of insertCampaign(CampaignBean bean)
	
	// 켐페인 수정
	public boolean updateCampaign(CampaignBean campaign) {
		Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = null;
	    boolean flag = false;
	    
	    try {
	    	con = pool.getConnection();
	    	sql = "UPDATE campaignTBL SET status = ?, title = ?, hash_tag = ?, thumb = ?, start_date = ?, end_date = ?, description = ? WHERE (num = ?)";
	    	pstmt = con.prepareStatement(sql);
	    	
	    	pstmt.setString(1, campaign.getStatus());
	    	pstmt.setString(2, campaign.getTitle());
	    	pstmt.setString(3, campaign.getHash_tag());
	    	pstmt.setString(4, campaign.getThumb());
	    	pstmt.setString(5, campaign.getStart_date());
	    	pstmt.setString(6, campaign.getEnd_date());
	    	pstmt.setString(7, campaign.getDescription());
	    	pstmt.setInt(8, campaign.getNum());
	    	
	    	int rowsAffected = pstmt.executeUpdate();
	    	flag = (rowsAffected > 0);
	    	
	    } catch(Exception e) {
	    	e.printStackTrace();
	    } finally {
	    	pool.freeConnection(con, pstmt, null);
	    }
	    
	    return flag;
	}// end of updateCampaign(CampaignBean campaign)
	
	// 켐페인 삭제
	public void deleteCampaign(int[] nums) {
		Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = null;
	    
	    try {
	    	con = pool.getConnection();
	    	sql = "DELETE FROM campaignTBL WHERE num = ?";
	    	pstmt = con.prepareStatement(sql);
	    	
	    	for(int num : nums) {
	    		pstmt.setInt(1, num);
	    		pstmt.addBatch();
	    	}
	    	
	    	pstmt.executeBatch();
	    	
	    } catch(Exception e) {
	    	e.printStackTrace();
	    } finally {
	    	pool.freeConnection(con, pstmt);
	    }
	}// end of deleteCampaign(int[] nums)
	
	// 켐페인 게시물 페이지네이션
	public Vector<CampaignBean> getCampaignListByPage(int pageNumber, int pageSize) {
		Vector<CampaignBean> campaignList = new Vector<CampaignBean>();
		Connection con = null;
		String sql = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	    	con = pool.getConnection();
	    	sql = "SELECT * FROM campaignTBL ORDER BY num LIMIT ? OFFSET ?";
	    	pstmt = con.prepareStatement(sql);	    	
	    	int offset = (pageNumber - 1) * pageSize;
	    	
	    	pstmt.setInt(1, pageSize);
	    	pstmt.setInt(2, offset);
	    	
	    	rs = pstmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		CampaignBean bean = new CampaignBean();
	    		bean.setNum(rs.getInt("num"));
				bean.setStatus(rs.getString("status"));
				bean.setTitle(rs.getString("title"));
				bean.setHash_tag(rs.getString("hash_tag"));
				bean.setThumb(rs.getString("thumb"));
				bean.setStart_date(rs.getString("start_date"));
				bean.setEnd_date(rs.getString("end_date"));
				bean.setDescription(rs.getString("description"));
				campaignList.add(bean);
	    	}
	    	
	    	
	    } catch(Exception e) {
	    	e.printStackTrace();
	    } finally {
	    	pool.freeConnection(con, pstmt, rs);
	    }
	    
	    return campaignList;
		
	}//end of getCampaignListByPage(int pageNumber, int pageSize)
	
	// 켐페인 전체 게시물 카운트 
	public int getTotalFundingCount() {			
		int totalCount = 0;
	    Connection con = null;
	    String sql = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	
	    try {
	        con = pool.getConnection(); 
	        sql = "SELECT COUNT(*) FROM campaignTBL"; 
	        pstmt = con.prepareStatement(sql);
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
	
	} // end of getTotalFundingCount()
	
	
	//Status 값에 따른 리스트 필터링
	public Vector<CampaignBean> getCampaignListStatus(String status){
		Vector<CampaignBean> campaignList = new Vector<CampaignBean>();
		Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	    	con = pool.getConnection();
	    	String sql = "SELECT * FROM campaignTBL";
	    	pstmt = con.prepareStatement(sql);
	    	rs = pstmt.executeQuery();
	    	
	    	while(rs.next()) {
	    		CampaignBean bean = new CampaignBean();
	    		bean.setNum(rs.getInt("num"));
				bean.setStatus(rs.getString("status"));
				bean.setTitle(rs.getString("title"));
				bean.setHash_tag(rs.getString("hash_tag"));
				bean.setThumb(rs.getString("thumb"));
				bean.setStart_date(rs.getString("start_date"));
				bean.setEnd_date(rs.getString("end_date"));
				bean.setDescription(rs.getString("description"));
				
				if (status.equals("전체") || bean.getStatus().equals(status)) {
	                campaignList.add(bean);
	            }
	    	}
	    	
	    	
	    } catch(Exception e) {
	    	e.printStackTrace();
	    } finally {
	    	pool.freeConnection(con, pstmt, rs);
	    }
		
		
		return campaignList;
	}
	
	
	
	
}//end of public class CampaignMgr
