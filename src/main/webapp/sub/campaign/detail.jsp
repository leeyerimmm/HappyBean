<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Controls.CampaignMgr" %>
<%@ page import="Controls.CampaignBean" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.NumberFormat" %>
<jsp:useBean id="fMgr" class="Controls.CampaignMgr"/>
<%
	request.setCharacterEncoding("utf-8");
	CampaignMgr campaignMgr = new CampaignMgr();
	CampaignBean campaign = null;
	
	String numStr = request.getParameter("num");
	int num = 0;
	
	if (numStr != null && !numStr.isEmpty()) {
	    try {
	        num = Integer.parseInt(numStr);
	        campaign = campaignMgr.getCampaignById(num); //정보 조회
	    } catch (NumberFormatException e) {
	        out.println("유효하지 않은 num 값입니다.");
	    }
	} else {
	    out.println("num 파라미터가 제공되지 않았습니다.");
	}
	
	if (campaign == null) {
	      out.println("<h2>해당 펀딩 정보를 찾을 수 없습니다.</h2>");
	      return; 
	}
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" href="${pageContext.request.contextPath}/images/common/favicon.ico" type="image/x-icon" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sub/campaign/event.css">
  <title>해피빈 : <%= campaign.getTitle() %></title>
</head>
<body>
	<jsp:include page="/views/header.jsp" />
	<div id="wrap">
	  <section class="section01 w_max">
	    <div class="title">
	          <img src="./images/<%= campaign.getThumb() %>" alt="<%= campaign.getTitle() %>">
	      <div class="text_title">
	          <span class="badge"><%= campaign.getHash_tag() %></span>
	          <h2><%= campaign.getTitle() %></h2>
	          <p class="term">참여기간 <span class="term_date"><%= campaign.getStart_date() %> ~ <%= campaign.getEnd_date() %></span></p>
	          <div class="sponsor">
	              <img src="./images/event_yuhan.jpg" alt="유한킴벌리 로고">
	              <span>유한킴벌리</span>
	          </div>
	      </div>
	 	 </div>
	   <div class="content">
	    <%= campaign.getDescription() %>
		</div>
	</section>
	<article class="article01 w_max">
	      <div class="goal_text">
	          <h3>댓글 10,000개를 달성하면<br> 유한킴벌리에서 5,000,000원 기부합니다.</h3>
	          <p>댓글 참여 시 ID 당 기부콩 1개를 드립니다.</p>
	          <p>참여기간 | 2024-08-20 ~ 2024-09-19</p>
	      </div>
	      <div class="progress-con">
	          <span class="progress-text">8,178개</span> 
	          <div class="progress-bar">
	            <div class="progress"></div>
	          </div>
	          <div class="progress-info">
	            <span>16일 남음</span>
	            <span>달성</span>
	          </div>
	      </div> 
	</article>
	<jsp:include page="/views/article_donation.jsp"/>
	<jsp:include page="/views/article_funding.jsp"/>	
	<jsp:include page="/views/footer.jsp"/>
	

	<script>
	  const $progBar = document.querySelectorAll(".prog_bar");
	  const $progValue = document.querySelectorAll(".prog_bar strong");
	  const $progNum = document.querySelectorAll(".prog_num");
	  
	
	  for(let i = 0; i < $progValue.length; i++){
	    $progValue[i].style.width = $progNum[i].innerText;
	  }
	</script>
</div>
</body>
</html>