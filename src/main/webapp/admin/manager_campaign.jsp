<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Controls.CampaignBean" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<jsp:useBean id="cMgr" class="Controls.CampaignMgr"/>
<%
	request.setCharacterEncoding("utf-8");
	String selectStatus = request.getParameter("status") != null ? request.getParameter("status") : "전체";
	Vector<CampaignBean> campaignList = cMgr.getCampaignList();
	Vector<CampaignBean> campaignStatusList = cMgr.getCampaignListStatus(selectStatus);  
	
	cMgr.updateCampaignStatus();
	
	int ongoingCount = 0; 
	int offgoingCount = 0; 
	
	for (CampaignBean campaign : campaignList) {
        if ("진행중".equals(campaign.getStatus())) {
            ongoingCount++;
        }
        
        if ("종료".equals(campaign.getStatus())) {
            offgoingCount++;
        }
    }
   
	
	// 페이지네이션 변수
  int pageSize = 10; // 한 페이지에 보여줄 게시글 수
  int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1; // 현재 페이지
  int totalCampaignCount = campaignList.size(); // 현재 상태에 따른 전체 펀딩 개수
  int totalPages = (int) Math.ceil((double) totalCampaignCount / pageSize); // 총 페이지 수

  // 현재 페이지에 해당하는 펀딩 리스트 가져오기
  int startIndex = (currentPage - 1) * pageSize;
  int endIndex = Math.min(startIndex + pageSize, totalCampaignCount);
  campaignList = new Vector<>(campaignList.subList(startIndex, endIndex)); // 페이지에 해당하는 리스트 생성
  
   
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" href="${pageContext.request.contextPath}/images/common/favicon.ico" type="image/x-icon" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/my/manager.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
  <title>해피빈 관리자</title>
</head>
<body>
	<jsp:include page="/views/header.jsp"/>
  <div id="wrap" class="w_max">
    <jsp:include page="/views/admin_nav.jsp"/>
    <div style="align-self: flex-start; flex-grow: 2;">
      <section id="user_activity_view_wrap">
				<h2 class="sr-only">캠페인 아이템 관리 페이지</h2>
				<div class="user_activity">
					<div class="current_bean">
						<ul class="info_list">
							<li class="list_head" style="border: none; margin: 0; padding: 0">
								<h3>현재 진행중인 캠페인</h3>
								<p><strong class="total_sum"><%= ongoingCount %></strong>건</p>
							</li>
						</ul>
					</div>
					<div class="total_donation">
						<ul class="info_list">
							<li class="list_head" style="border: none; margin: 0; padding: 0">
								<h3>종료된 캠페인</h3>
								<p><strong class="donation_total"><%= offgoingCount %></strong>건</p>
							</li>
						</ul>
					</div>
				</div>
			</section>
      

      <section id="item_list_wrap">
        <h2 class="campaign_title">캠페인 아이템 리스트</h2>
        <div class="filter_box">
          <form action="#" method="post" style="margin-top: 40px" name="currentFrm" onchange="changeSelect()">
		        <select name="status" id="statusSelect">
		            <option value="전체" selected>전체</option>
		            <option value="진행중" <%= selectStatus.equals("진행중") ? "selected" : "" %>>진행중</option>
		            <option value="종료" <%= selectStatus.equals("종료") ? "selected" : "" %>>종료</option>
		        </select>
		    	</form>
          <a href="./campaign_write.jsp" class="campaign_write writeBtn">켐페인 등록</a>
        </div>
        <form action="campaign_delete.jsp" method="post">
	        <table>
						<colgroup>
							<td style="width: 5%;"></td>
							<td style="width: 10%;"></td>
							<td style="width: 40%;"></td>
							<td style="width: 25%;"></td>
							<td style="width: 20%;"></td>
						</colgroup>
						
						<tr class="table_header">
							<th scope="row">
								<input type="checkbox" name="selectAll">
							</th>
							<th>진행상황</th>
							<th>제목</th>
							<th>종료일</th>
							<th>아아템 관리</th>
						</tr>
						<%			        
			        for(CampaignBean campaign : campaignStatusList) {  	        		    		
						%>
						<tr>
							<td><input type="checkbox" name="select" value="16"></td>
							<td><p class="status on"><%= campaign.getStatus() %></p></td>
							<td><a href="${pageContext.request.contextPath}/sub/campaign/detail.jsp?num=<%= campaign.getNum() %>"><%= campaign.getTitle() %></a></td>
							<td><%= campaign.getEnd_date() %></td>
							<td>
								<a href="campaign_edit.jsp?num=<%= campaign.getNum() %>" class="btn edit">수정</a>
								<form action="campaing_delete.jsp" method="post"/>
									<input type="hidden" name="select" value="<%= campaign.getNum() %>">
									<button class="btn delete" type="submit" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
								</form>
							</td>
						</tr>
						
						<% } %>				
					</table>     
	        <button type="submit" class="deleteBtn" onclick="return confirm('정말 삭제하시겠습니까?');">선택 삭제</button>

	        <nav class="page_index_wrap">
	          <a href="?page=<%= currentPage - 1 %>" class="pagePrev" <%= currentPage == 1 ? "style='display:none;'" : "" %>></a>
	          <ul class="page_index" style="justify-content:center;">
	            <%
				        for (int i = 1; i <= totalPages; i++) {
				            if (i == currentPage) {
					    %>
					                <li class="current"><a href="?page=<%= i %>"><%= i %></a></li>
					    <%
					            } else {
					    %>
					                <li><a href="?page=<%= i %>"><%= i %></a></li>
					    <%
					            }
					        }
					    %>
	          </ul>
	          <a href="?page=<%= currentPage + 1 %>" class="pageNext" <%= currentPage == totalPages ? "style='display:none;'" : "" %>></a> 
	        </nav>
      	</form>
      </section>
    </div>    
  </div>
  <jsp:include page="/views/footer.jsp"/>
  <script>
	  function changeSelect(){
	      let selectStatus = document.querySelector('select[name="status"]').value;
	      let actionUrl = "manager_campaign.jsp?status=" + selectStatus; 
	      document.currentFrm.action = actionUrl;
	      document.currentFrm.submit();
	  }
  </script>
</body>
</html>