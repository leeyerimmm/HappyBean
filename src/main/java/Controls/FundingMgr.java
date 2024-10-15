package Controls;


import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;




public class FundingMgr {
	
	private DBConnectionMgr pool;


	public FundingMgr() {
		try {
			pool = DBConnectionMgr.getInstance(); // DBConnectionMgr의 인스턴스를 가져옵니다.
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
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
	}
	
	// 현재 날짜와 end_date가 일치할 경우 status 업데이트
    public void updateFundingStatus() {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = pool.getConnection(); // 데이터베이스 연결을 가져옵니다.
            String sql = "UPDATE FundingTBL SET status = '종료' WHERE end_date = ?"; // 종료일이 현재 날짜와 일치하는 경우 상태 업데이트
            pstmt = con.prepareStatement(sql);
            
            Date currentDate = new Date(System.currentTimeMillis()); // 현재 날짜를 가져옵니다.
            pstmt.setDate(1, currentDate); // 현재 날짜를 쿼리에 설정합니다.

            int rowsUpdated = pstmt.executeUpdate(); // 쿼리를 실행하여 업데이트합니다.
            System.out.println(rowsUpdated + "개의 펀딩 상태가 업데이트되었습니다."); // 업데이트된 행 수 출력
        } catch (Exception e) {
            e.printStackTrace(); // 예외 발생 시 스택 트레이스 출력
        } finally {
            pool.freeConnection(con, pstmt, null); // 데이터베이스 연결 해제
        }
    }
	
	
	// 펀딩 목록 조회
    public Vector<FundingBean> getFundingList() {
    	Vector<FundingBean> fundingList = new Vector<FundingBean>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = pool.getConnection(); // 데이터베이스 연결
            String sql = "SELECT * FROM FundingTBL ORDER BY num DESC"; // 펀딩 테이블의 모든 데이터를 조회
            pstmt = con.prepareStatement(sql);
           
            rs = pstmt.executeQuery();

            while (rs.next()) {
                FundingBean bean = new FundingBean();
                bean.setNum(rs.getInt("num"));
                bean.setKategotie(rs.getString("kategorie"));
                bean.setStatus(rs.getString("status"));
                bean.setTitle(rs.getString("title"));
                bean.setThumb(rs.getString("thumb"));
                bean.setCompany(rs.getString("company"));
                bean.setSlogan(rs.getString("slogan"));
                bean.setOption(rs.getString("option"));
                bean.setDelivery_amount(rs.getString("delivery_amount"));
                bean.setDelivery_free(rs.getString("delivery_free"));
                bean.setStart_date(rs.getString("start_date"));
                bean.setEnd_date(rs.getString("end_date"));
                bean.setGoal_amount(rs.getString("goal_amount"));
                bean.setRased_amount(rs.getString("rased_amount"));
                bean.setDescription(rs.getString("description"));
                fundingList.add(bean); // 리스트에 추가
            }
        } catch (Exception e) {
            e.printStackTrace(); // 예외 발생 시 스택 트레이스 출력
        } finally {
            pool.freeConnection(con, pstmt, rs); // 데이터베이스 연결 해제
        }

        return fundingList; // 펀딩 목록 반환
    }
    
    //펀딩 디테일 페이지 article 리스트
    public Vector<FundingBean> getFundingArticleList(int num) {
    	Vector<FundingBean> fundingList = new Vector<FundingBean>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = pool.getConnection();
            String sql = "SELECT * FROM fundingTBL WHERE num <> ? AND status = '진행중'"; 
            pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, num);
           
            rs = pstmt.executeQuery();

            while (rs.next()) {
                FundingBean bean = new FundingBean();
                bean.setNum(rs.getInt("num"));
                bean.setKategotie(rs.getString("kategorie"));
                bean.setStatus(rs.getString("status"));
                bean.setTitle(rs.getString("title"));
                bean.setThumb(rs.getString("thumb"));
                bean.setCompany(rs.getString("company"));
                bean.setSlogan(rs.getString("slogan"));
                bean.setOption(rs.getString("option"));
                bean.setDelivery_amount(rs.getString("delivery_amount"));
                bean.setDelivery_free(rs.getString("delivery_free"));
                bean.setStart_date(rs.getString("start_date"));
                bean.setEnd_date(rs.getString("end_date"));
                bean.setGoal_amount(rs.getString("goal_amount"));
                bean.setRased_amount(rs.getString("rased_amount"));
                bean.setDescription(rs.getString("description"));
                fundingList.add(bean); // 리스트에 추가
            }
        } catch (Exception e) {
            e.printStackTrace(); // 예외 발생 시 스택 트레이스 출력
        } finally {
            pool.freeConnection(con, pstmt, rs); // 데이터베이스 연결 해제
        }

        return fundingList; // 펀딩 목록 반환
    }
    
    // 펀딩 상세보기(게시글 보기)
    public FundingBean getFundingById(int num) {
    	Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
    	FundingBean bean = new FundingBean();   
        
        
        try  {
        	con = pool.getConnection();
			sql = "SELECT * FROM FundingTBL WHERE num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

            if (rs.next()) {
            	bean = new FundingBean();
                bean.setKategotie(rs.getString("kategorie"));
                bean.setStatus(rs.getString("status"));
                bean.setTitle(rs.getString("title"));
                bean.setThumb(rs.getString("thumb"));
                bean.setCompany(rs.getString("company"));
                bean.setSlogan(rs.getString("slogan"));
                bean.setOption(rs.getString("option"));
                bean.setDelivery_amount(rs.getString("delivery_amount"));
                bean.setDelivery_free(rs.getString("delivery_free"));
                bean.setStart_date(rs.getString("start_date"));
                bean.setEnd_date(rs.getString("end_date"));
                bean.setGoal_amount(rs.getString("goal_amount"));
                bean.setRased_amount(rs.getString("rased_amount"));
                bean.setDescription(rs.getString("description"));
            }
        } catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
    }

	// 펀딩 상품 등록
	public boolean insertFunding(FundingBean bean) {
		Connection con = null;
	    PreparedStatement pstmt = null;
	    boolean flag = false;
	
	    try {
	        con = pool.getConnection(); 
	        String sql = "INSERT INTO FundingTBL (kategorie, status, title, thumb, company, slogan, `option`, delivery_amount, delivery_free, start_date, end_date, goal_amount, rased_amount, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0, ?);";
	        pstmt = con.prepareStatement(sql);	
	        
	        pstmt.setString(1, bean.getKategotie());
	        pstmt.setString(2, "진행중");
	        pstmt.setString(3, bean.getTitle());
	        pstmt.setString(4, bean.getThumb());
	        pstmt.setString(5, bean.getCompany());
	        pstmt.setString(6, bean.getSlogan());
	        pstmt.setString(7, bean.getOption());
	        pstmt.setString(8, bean.getDelivery_amount());
	        pstmt.setString(9, bean.getDelivery_free());
	        pstmt.setString(10, bean.getStart_date()); 
	        pstmt.setString(11, bean.getEnd_date()); 
	        pstmt.setString(12, bean.getGoal_amount());
	        pstmt.setString(13, bean.getDescription()); 
	
	        int rowsAffected = pstmt.executeUpdate(); 
	        if (rowsAffected > 0) {
	            flag = true; 
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, null); 
	    }
	    return flag; 
	}
	
	// 펀딩상품 수정
	public boolean updateFunding(FundingBean funding) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    boolean isUpdated = false;

	    try {
	        con = pool.getConnection();
	        String sql = "UPDATE FundingTBL SET kategorie = ?, status = ?, title = ?, thumb = ?, company = ?, slogan = ?, `option` = ?, delivery_amount = ?, delivery_free = ?,  start_date = ?, end_date = ?, goal_amount = ?, description = ? WHERE (num = ?)";
	        pstmt = con.prepareStatement(sql);

	        // PreparedStatement에 값 설정
	        pstmt.setString(1, funding.getKategotie());
	        pstmt.setString(2, funding.getStatus());
	        pstmt.setString(3, funding.getTitle());
	        pstmt.setString(4, funding.getThumb());
	        pstmt.setString(5, funding.getCompany());
	        pstmt.setString(6, funding.getSlogan());
	        pstmt.setString(7, funding.getOption());
	        pstmt.setString(8, funding.getDelivery_amount());
	        pstmt.setString(9, funding.getDelivery_free());
	        pstmt.setString(10, funding.getStart_date());
	        pstmt.setString(11, funding.getEnd_date());
	        pstmt.setString(12, funding.getGoal_amount());
	        pstmt.setString(13, funding.getDescription());
	        pstmt.setInt(14, funding.getNum());

	        // 쿼리 실행
	        int rowsAffected = pstmt.executeUpdate();
	        isUpdated = (rowsAffected > 0); // 업데이트된 행이 있으면 true
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        closeResources(con, pstmt, null);
	    }

	    return isUpdated; // 업데이트 성공 여부 반환
	}
	
	// funding 상품 삭제
	public void deleteFunding(int[] nums) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = null;

	    try {
	        con = pool.getConnection();
	        sql = "DELETE FROM fundingTBL WHERE num = ?";
	        pstmt = con.prepareStatement(sql);
	        for (int num : nums) {
	            pstmt.setInt(1, num);
	            pstmt.addBatch(); // 배치로 추가
	        }
	        pstmt.executeBatch(); // 배치 실행
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt);
	    }
	}
	
	//펀딩 게시물 페이지네이션	
	public Vector<FundingBean> getFundingListByPage(int pageNumber, int pageSize) {
		Vector<FundingBean> fundingList = new Vector<FundingBean>();
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	
	    try {
	        con = pool.getConnection();
	        String sql = "SELECT * FROM FundingTBL ORDER BY num LIMIT ? OFFSET ?"; 
	        pstmt = con.prepareStatement(sql);
	        
	        int offset = (pageNumber - 1) * pageSize; 
	        pstmt.setInt(1, pageSize); 
	        pstmt.setInt(2, offset); 
	
	        rs = pstmt.executeQuery();
	
	        while (rs.next()) {
	            FundingBean bean = new FundingBean();
	            bean.setNum(rs.getInt("num"));
	            bean.setKategotie(rs.getString("kategorie"));
	            bean.setStatus(rs.getString("status"));
	            bean.setTitle(rs.getString("title"));
	            bean.setThumb(rs.getString("thumb"));
	            bean.setCompany(rs.getString("company"));
	            bean.setSlogan(rs.getString("slogan"));
	            bean.setOption(rs.getString("option"));
	            bean.setDelivery_amount(rs.getString("delivery_amount"));
	            bean.setDelivery_free(rs.getString("delivery_free"));
	            bean.setStart_date(rs.getString("start_date"));
	            bean.setEnd_date(rs.getString("end_date"));
	            bean.setGoal_amount(rs.getString("goal_amount"));
	            bean.setRased_amount(rs.getString("rased_amount"));
	            bean.setDescription(rs.getString("description"));
	            fundingList.add(bean); 
	        }
	    } catch (Exception e) {
	        e.printStackTrace(); 
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	
	    return fundingList; 
	}
	
	//전체 게시물 카운트
	public int getTotalFundingCount() {
		
		int totalCount = 0;
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    try {
	        con = pool.getConnection(); 
	        String query = "SELECT COUNT(*) FROM FundingTBL"; 
	        pstmt = con.prepareStatement(query);
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
	

	
	//카테고리 별 펀딩리스트 데이터 가져오기
	public Vector<FundingBean> getKategorieList(String stat, String target){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		FundingBean bean = null;
		Vector<FundingBean> vlist = new Vector<FundingBean>();
		
		try {
			con = pool.getConnection();
			
			if(stat != null) {
				sql = "SELECT * FROM fundingTBL WHERE kategorie = ? ORDER BY num DESC";
				
			} else {
				sql = "SELECT * FROM fundingTBL ORDER BY num DESC";
			}
			
			pstmt = con.prepareStatement(sql);
			
			if(stat != null) {
				pstmt.setString(1, target);
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				bean = new FundingBean();				
                bean.setNum(rs.getInt("num"));
                bean.setKategotie(rs.getString("kategorie"));
                bean.setStatus(rs.getString("status"));
                bean.setTitle(rs.getString("title"));
                bean.setThumb(rs.getString("thumb"));
                bean.setCompany(rs.getString("company"));
                bean.setSlogan(rs.getString("slogan"));
                bean.setOption(rs.getString("option"));
                bean.setDelivery_amount(rs.getString("delivery_amount"));
                bean.setDelivery_free(rs.getString("delivery_free"));
                bean.setStart_date(rs.getString("start_date"));
                bean.setEnd_date(rs.getString("end_date"));
                bean.setGoal_amount(rs.getString("goal_amount"));
                bean.setRased_amount(rs.getString("rased_amount"));
                bean.setDescription(rs.getString("description"));
                vlist.add(bean); // 리스트에 추가
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return vlist;
		
	}
	
	//Status 값에 따른 리스트 필터링
	public Vector<FundingBean> getFundingListByStatus(Vector<FundingBean> fundingList, String status) {
	    Vector<FundingBean> filteredList = new Vector<FundingBean>();
	
	    for (FundingBean funding : fundingList) {
	        if (funding.getStatus().equals(status)) {
	            filteredList.add(funding);
	        }
	    }
	
	    return filteredList;
	}
	
	//Status 값이 '전체'일 때 실행 필터링
	public Vector<FundingBean> getFundingListByStatus(String status) {
	    Vector<FundingBean> fundingList = new Vector<>();
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    try {
	        con = pool.getConnection();
	        String sql = "SELECT * FROM FundingTBL ORDER BY num DESC"; // 전체 데이터 조회
	        pstmt = con.prepareStatement(sql);
	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            FundingBean bean = new FundingBean();
	            bean.setNum(rs.getInt("num"));
	            bean.setKategotie(rs.getString("kategorie"));
	            bean.setStatus(rs.getString("status"));
	            bean.setTitle(rs.getString("title"));
	            bean.setThumb(rs.getString("thumb"));
	            bean.setCompany(rs.getString("company"));
	            bean.setSlogan(rs.getString("slogan"));
	            bean.setOption(rs.getString("option"));
	            bean.setDelivery_amount(rs.getString("delivery_amount"));
	            bean.setDelivery_free(rs.getString("delivery_free"));
	            bean.setStart_date(rs.getString("start_date"));
	            bean.setEnd_date(rs.getString("end_date"));
	            bean.setGoal_amount(rs.getString("goal_amount"));
	            bean.setRased_amount(rs.getString("rased_amount"));
	            bean.setDescription(rs.getString("description"));

	            // 상태에 따라 필터링
	            if (status.equals("전체") || bean.getStatus().equals(status)) {
	                fundingList.add(bean);
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }

	    return fundingList;
	}



}