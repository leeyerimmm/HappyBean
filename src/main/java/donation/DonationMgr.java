package donation;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DonationMgr {

    private DBConnectionMgr pool;

    public DonationMgr() {
        try {
            pool = DBConnectionMgr.getInstance();
        } catch (Exception e) {
            System.out.println("Error: 커넥션 연결 실패");
            e.printStackTrace();
        }
    }

    public DonationBean getDonationById(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        DonationBean donation = null;

        try {
            conn = pool.getConnection();
            String sql = "SELECT subnum, title, description, goal_amount, raised_amount, start_date, end_date, category, thumb, company, "
                       + "sub_images, cost_details, cost_descriptions, cost_amounts, project_duration, target_group, target_count, expected_effect,status "
                       + "FROM donaraisingTBL WHERE subnum = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                donation = new DonationBean();
                donation.setId(rs.getInt("subnum"));
                donation.setTitle(rs.getString("title"));
                donation.setDescription(rs.getString("description"));
                donation.setGoalAmount(rs.getInt("goal_amount"));
                donation.setRaisedAmount(rs.getInt("raised_amount"));
                donation.setStartDate(rs.getDate("start_date"));
                donation.setEndDate(rs.getDate("end_date"));
                donation.setCategory(rs.getString("category"));
                donation.setThumb(rs.getString("thumb"));
                donation.setCompany(rs.getString("company"));
                donation.setSubImages(rs.getString("sub_images"));
                donation.setCostDetails(rs.getString("cost_details"));
                donation.setCostDescriptions(rs.getString("cost_descriptions"));
                donation.setCostAmounts(rs.getString("cost_amounts"));
                donation.setProjectDuration(rs.getString("project_duration"));
                donation.setTargetGroup(rs.getString("target_group"));
                donation.setTargetCount(rs.getInt("target_count"));
                donation.setExpectedEffect(rs.getString("expected_effect"));
                donation.setStatus(rs.getString("status"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(conn, pstmt, rs);
        }

        return donation;
    }

    
    
    // 모든 기부 데이터 반환
    public List<DonationBean> getAllDonations() {
    	List<DonationBean> donations = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
       

        try {
            conn = pool.getConnection();
            String sql = "SELECT subnum, thumb, title, company, raised_amount, goal_amount, status FROM donaraisingTBL order by subnum desc"; 
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                DonationBean donation = new DonationBean();
    			donation.setId(rs.getInt("subnum"));
    			donation.setThumb(rs.getString("thumb"));
    			donation.setTitle(rs.getString("title"));
    			donation.setCompany(rs.getString("company"));
    			donation.setRaisedAmount(rs.getInt("raised_amount"));
    			donation.setGoalAmount(rs.getInt("goal_amount"));
    			donation.setStatus(rs.getString("status"));
                donations.add(donation);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(conn, pstmt, rs);
        }

        return donations; 
    }
    
    
    // 미리보기 기부 데이터 반환
    public List<DonationBean> getPreviewDonations() {
        List<DonationBean> donations = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = pool.getConnection();
            String sql = "SELECT subnum, thumb, title, company, raised_amount, goal_amount, status FROM donaraisingTBL ORDER BY subnum DESC LIMIT 4";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                DonationBean donation = new DonationBean();
                donation.setId(rs.getInt("subnum"));
                donation.setThumb(rs.getString("thumb"));
                donation.setTitle(rs.getString("title"));
                donation.setCompany(rs.getString("company"));
                donation.setRaisedAmount(rs.getInt("raised_amount"));
                donation.setGoalAmount(rs.getInt("goal_amount"));
                donation.setStatus(rs.getString("status"));
                donations.add(donation);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(conn, pstmt, rs);
        }

        return donations;
    }


    // 모금액 불러오기
    public int raisedAmount(int subnum, String donation_type) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        int raisedAmount = 0;
        try {
        	con = pool.getConnection();
        	sql = "select sum(amount) from donationstbl where campaign_num = ? and donation_type = ?";
        	pstmt = con.prepareStatement(sql);
        	pstmt.setInt(1, subnum);
        	pstmt.setString(2, donation_type);
        	rs = pstmt.executeQuery();
        	if(rs.next()) {
        		raisedAmount = rs.getInt("sum(amount)");
        		if(donation_type.equals("후원")) {
        			sql = "update donaraisingtbl set raised_amount = ? where subnum = ?";
        			pstmt = con.prepareStatement(sql);
        			pstmt.setInt(1, raisedAmount);
        			pstmt.setInt(2, subnum);
        			pstmt.executeUpdate();
        		} else {
        			sql = "update fundingtbl set rased_amount = ? where num = ?";
        			pstmt = con.prepareStatement(sql);
        			pstmt.setInt(1, raisedAmount);
        			pstmt.setInt(2, subnum);
        			pstmt.executeUpdate();
        		}
        	}
        }catch(Exception e) {
        	e.printStackTrace();
        }finally {
        	pool.freeConnection(con, pstmt, rs);
        }
        return raisedAmount;
    }
    
    // 후원 모금 타이틀 / 회사 불러오기
    public String[] getTitleCompany(int subnum, String donation_type) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        String[] titleCompany = new String[2];
        try {
        	con = pool.getConnection();
        	if(donation_type.equals("후원")) {
        		sql = "select * from donaraisingtbl where subnum = ?";        		
        	}else {
        		sql = "select * from fundingtbl where num = ?";        		        		
        	}
        	pstmt = con.prepareStatement(sql);
        	pstmt.setInt(1, subnum);
        	rs = pstmt.executeQuery();
        	if(rs.next()) {
            	titleCompany[0] = rs.getString("title");
            	titleCompany[1] = rs.getString("company");
        	}

        }catch(Exception e) {
        	e.printStackTrace();
        }finally {
        	pool.freeConnection(con, pstmt, rs);
        }
    	return titleCompany;
    }
    
    // 후원 금액 / 펀딩금액 불러오기
    public int[] getDonaFundAmount(String user_id) {
    	Connection con = null;
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	String sql = null;
    	int[] donaFundAmount = new int[2];
    	try {
    		con = pool.getConnection();
    		sql = "select sum(amount) from donationstbl where user_id = ? and donation_type = '후원'";
    		pstmt = con.prepareStatement(sql);
    		pstmt.setString(1, user_id);
    		rs = pstmt.executeQuery();
    		if(rs.next()) {
    			donaFundAmount[0] = rs.getInt("sum(amount)");
    		}
    		sql = "select sum(amount) from donationstbl where user_id = ? and donation_type = '펀딩'";
    		pstmt = con.prepareStatement(sql);
    		pstmt.setString(1, user_id);
    		rs = pstmt.executeQuery();
    		if(rs.next()) {
    			donaFundAmount[1] = rs.getInt("sum(amount)");
    		}
    	}catch(Exception e) {
    		e.printStackTrace();
    	}finally {
    		pool.freeConnection(con, pstmt, rs);
    	}
    	return donaFundAmount;
    }
    
    // 사용자 후원 목록 불러오기
    public List<DonationListBean> getUserPreviewDonationList(String user_id){
    	List<DonationListBean> donationLists = new ArrayList<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        try {
        	con = pool.getConnection();
        	sql = "select * from donationstbl where user_id = ? order by donation_num desc limit 3";
        	pstmt = con.prepareStatement(sql);
        	pstmt.setString(1, user_id);
        	rs = pstmt.executeQuery();
        	while(rs.next()) {
        		DonationListBean bean = new DonationListBean();
        		bean.setCampaign_num(rs.getInt("campaign_num"));
        		bean.setDonation_date(rs.getDate("Donation_date"));
        		bean.setDonation_type(rs.getString("Donation_type"));
        		bean.setAmount(rs.getInt("amount"));
        		donationLists.add(bean);
        	}
        }catch(Exception e) {
        	e.printStackTrace();
        }finally {
        	pool.freeConnection(con, pstmt, rs);
        }
    	return donationLists;
    }
    
    // 현재까지 모인 유저 / 기부금액
    public int[] getTotalUserAmount() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
    	int[] getTotalUserAmount = new int[2];
    	try {
    		con = pool.getConnection();
    		sql = "SELECT COUNT(DISTINCT user_id) as totalUser, sum(amount) as totalAmount FROM donationstbl where donation_type = '후원'";
    		pstmt = con.prepareStatement(sql);
    		rs = pstmt.executeQuery();
    		if(rs.next()) {
    			getTotalUserAmount[0] = rs.getInt("totalUser");
    			getTotalUserAmount[1] = rs.getInt("totalAmount");
    		}
    	}catch(Exception e) {
    		e.printStackTrace();
    	}finally {
    		pool.freeConnection(con, pstmt, rs);
    	}
    	return getTotalUserAmount;
    }
    
    
    public boolean insertDonation(DonationBean donation) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean flag = false;

        try {
            conn = pool.getConnection();
            String sql = "INSERT INTO donaraisingTBL (title, category, status, thumb, sub_images, company, start_date, end_date, goal_amount, project_duration, target_group, target_count, cost_details, cost_descriptions, cost_amounts, expected_effect, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, donation.getTitle());
            pstmt.setString(2, donation.getCategory());
            pstmt.setString(3, donation.getStatus());
            pstmt.setString(4, donation.getThumb());
            pstmt.setString(5, donation.getSubImages());
            pstmt.setString(6, donation.getCompany());
            pstmt.setDate(7, donation.getStartDate());
            pstmt.setDate(8, donation.getEndDate());
            pstmt.setInt(9, donation.getGoalAmount());
            pstmt.setString(10, donation.getProjectDuration());
            pstmt.setString(11, donation.getTargetGroup());
            pstmt.setInt(12, donation.getTargetCount());
            pstmt.setString(13, donation.getCostDetails());
            pstmt.setString(14, donation.getCostDescriptions());
            pstmt.setString(15, donation.getCostAmounts());
            pstmt.setString(16, donation.getExpectedEffect());
            pstmt.setString(17, donation.getDescription());

            int rowCount = pstmt.executeUpdate();
            flag = (rowCount > 0);  // 삽입 성공 여부 확인

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(conn, pstmt);
        }

        return flag;
    }

    public boolean updateDonation(DonationBean donation) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean result = false;

        try {
            conn = pool.getConnection();
            String sql = "UPDATE donaraisingTBL SET category=?, status=?, title=?, thumb=?, sub_images=?, company=?, start_date=?, end_date=?, goal_amount=?, project_duration=?, target_group=?, target_count=?, cost_details=?, cost_descriptions=?, cost_amounts=?, expected_effect=?, description=? WHERE subnum=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, donation.getCategory());
            pstmt.setString(2, donation.getStatus());
            pstmt.setString(3, donation.getTitle());
            pstmt.setString(4, donation.getThumb());
            pstmt.setString(5, donation.getSubImages());
            pstmt.setString(6, donation.getCompany());
            pstmt.setDate(7, donation.getStartDate());
            pstmt.setDate(8, donation.getEndDate());
            pstmt.setInt(9, donation.getGoalAmount());
            pstmt.setString(10, donation.getProjectDuration());
            pstmt.setString(11, donation.getTargetGroup());
            pstmt.setInt(12, donation.getTargetCount());
            pstmt.setString(13, donation.getCostDetails());
            pstmt.setString(14, donation.getCostDescriptions());
            pstmt.setString(15, donation.getCostAmounts());
            pstmt.setString(16, donation.getExpectedEffect());
            pstmt.setString(17, donation.getDescription());
            pstmt.setInt(18, donation.getId());

            int count = pstmt.executeUpdate();
            if (count > 0) {
                result = true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(conn, pstmt);
        }

        return result;
    }
    public boolean deleteDonation(int donationId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean result = false;

        try {
            conn = pool.getConnection();
            String sql = "DELETE FROM donaraisingTBL WHERE subnum = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, donationId);

            int count = pstmt.executeUpdate();
            if (count > 0) {
                result = true;
            } else {
                System.out.println("삭제할 기부 항목이 없습니다. ID: " + donationId);
            }
        } catch (SQLException e) {
            e.printStackTrace();  // SQLException을 콘솔에 출력
        } finally {
            pool.freeConnection(conn, pstmt);
        }

        return result;
    }

        
        // 진행 중인 기부 건수
        public int getOngoingDonationCount() {
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            int count = 0;
            
            try {
                conn = pool.getConnection();
                String sql = "SELECT COUNT(*) FROM donaraisingTBL WHERE status = '진행중'";
                pstmt = conn.prepareStatement(sql);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                pool.freeConnection(conn, pstmt, rs);
            }
            
            return count;
        }
        
        // 종료된 기부 건수
        public int getCompletedDonationCount() {
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            int count = 0;
            
            try {
                conn = pool.getConnection();
                String sql = "SELECT COUNT(*) FROM donaraisingTBL WHERE status = '종료됨'";
                pstmt = conn.prepareStatement(sql);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                pool.freeConnection(conn, pstmt, rs);
            }
            
            return count;
        }

        // 목표 달성한 진행 중인 기부 건수
        public int getAchievedOngoingDonationCount() {
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            int count = 0;
            
            try {
                conn = pool.getConnection();
                String sql = "SELECT COUNT(*) FROM donaraisingTBL WHERE status = '진행중' AND raised_amount >= goal_amount";
                pstmt = conn.prepareStatement(sql);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                pool.freeConnection(conn, pstmt, rs);
            }
            
            return count;
        }

        // 목표 달성하지 못한 진행 중인 기부 건수
        public int getNotAchievedOngoingDonationCount() {
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            int count = 0;
            
            try {
                conn = pool.getConnection();
                String sql = "SELECT COUNT(*) FROM donaraisingTBL WHERE status = '진행중' AND raised_amount < goal_amount";
                pstmt = conn.prepareStatement(sql);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                pool.freeConnection(conn, pstmt, rs);
            }
            
            return count;
        }

        // 목표 달성한 종료된 기부 건수
        public int getAchievedCompletedDonationCount() {
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            int count = 0;
            
            try {
                conn = pool.getConnection();
                String sql = "SELECT COUNT(*) FROM donaraisingTBL WHERE status = '종료됨' AND raised_amount >= goal_amount";
                pstmt = conn.prepareStatement(sql);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                pool.freeConnection(conn, pstmt, rs);
            }
            
            return count;
        }

        // 목표 달성하지 못한 종료된 기부 건수
        public int getNotAchievedCompletedDonationCount() {
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            int count = 0;
            
            try {
                conn = pool.getConnection();
                String sql = "SELECT COUNT(*) FROM donaraisingTBL WHERE status = '종료됨' AND raised_amount < goal_amount";
                pstmt = conn.prepareStatement(sql);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                pool.freeConnection(conn, pstmt, rs);
            }
            
            return count;
        }
    }


