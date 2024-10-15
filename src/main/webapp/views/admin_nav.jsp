<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="Controls.FundingBean" %>
 <%@ page import="Controls.CampaignBean" %>
 <%@ page import="donation.DonationBean" %>
 <%@ page import="java.util.Vector" %>
 <jsp:useBean id="fMgr" class="Controls.FundingMgr"/> 
 <jsp:useBean id="cMgr" class="Controls.CampaignMgr"/> 
 <jsp:useBean id="dMgr" class="donation.DonationMgr" />
 <%
	request.setCharacterEncoding("utf-8");
  Vector<FundingBean> fundingList = new Vector<FundingBean>();
  Vector<CampaignBean> campaignList = new Vector<CampaignBean>();
  int fundingOnGoingCount = 0;
  int campaignOnGoingCount = 0;
   
   try {
     fundingList = fMgr.getFundingList();
     campaignList = cMgr.getCampaignList();
     
 		 // 진행 중인 게시물 개수 세기
     for (FundingBean funding : fundingList) {
       if ("진행중".equals(funding.getStatus())) {
    	   	fundingOnGoingCount++;
       }
     }
 		 
     for (CampaignBean campaign : campaignList) {
       if ("진행중".equals(campaign.getStatus())) {
    	   	campaignOnGoingCount++;
       }
     }
 		 
   } catch (Exception e) {
       e.printStackTrace(); 
   }
   
   
%>  

<!DOCTYPE html>
<section id="user_info_list_wrap" class="w_max">
   <div class="user_name_box">
     <div class="icon manager"><span class="sr-only">해피빈 마스코트</span></div>
     <h2><span class="user_name">관리자</span>님</h2>
   </div>
   <div class="user_info_box">
     <ul class="info_list">
       <li>
         <a href="#">
           <p>진행중 기부</p>
           <p><strong class="hold_bean"><%= dMgr.getOngoingDonationCount() %></strong> 건</p>
         </a>
       </li>
       <li>
         <a href="#">
           <p>진행중 펀딩</p>
           <p><strong class="payment"><%= fundingOnGoingCount %></strong> 건</p>
         </a>
       </li>
       <li>
         <a href="#">
           <p>진행중 캠페인</p>
           <p><strong class="cash_box"><%= campaignOnGoingCount %></strong> 건</p>
         </a>
       </li>
     </ul>
   </div>
   <nav class="user_menu_list_box">
     <ul id="user_menu_list">
       <li class=""><a href="${pageContext.request.contextPath}/admin/manager_donation.jsp">기부 관리</a></li>
       <li class=""><a href="${pageContext.request.contextPath}/admin/manager_funding.jsp">펀딩 관리</a></li>
       <li class=""><a href="${pageContext.request.contextPath}/admin/manager_campaign.jsp">캠페인 관리</a></li>
       <li class=""><a href="${pageContext.request.contextPath}/admin/manager_notice.jsp">공지사항 관리</a></li>
     </ul>
   </nav>
 </section>