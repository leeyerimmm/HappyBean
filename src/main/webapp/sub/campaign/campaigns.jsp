<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="Controls.CampaignBean" %>
<jsp:useBean id="cMgr" class="Controls.CampaignMgr"/>
<%
    request.setCharacterEncoding("utf-8");
    Vector<CampaignBean> campaignList = new Vector<CampaignBean>();
    cMgr.updateCampaignStatus();
    
    try {
        campaignList = cMgr.getCampaignList();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="icon" href="${pageContext.request.contextPath}/images/common/favicon.ico" type="image/x-icon" />	
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sub/campaign/campain.css" />
		<script defer src="${pageContext.request.contextPath}/js/common/common.js"></script>
		<title>해피빈 : 캠페인</title>
	</head>
	<body>
		<jsp:include page="/views/header.jsp" />
		<div id="wrap">
			<section id="campaign">
				<section class="campaign_title_wrap">
					<h2 class="campaign_title">
						CRS뉴스레터<br />
						해피빈 캠페인
					</h2>
					<p class="desc">해피빈 캠페인은 기업 파트너의 CSR, 사회공헌 이슈를 <br />전달하는 해피빈 뉴스레터입니다</p>
				</section>
				<h2 class="sr-only">캠페인 리스트</h2>
				<div class="w_max">
					<ul class="item_list list_style_2 campaign">
						<% 
						for(CampaignBean campaign : campaignList) { 
							String listClass = campaign.getStatus().equals("종료") ? "off" : "";
						
						%>
						<li class="<%= listClass %>">
							<a href="detail.jsp?num=<%= campaign.getNum() %>">
								<p class="thumb">
									<img src="./images/<%= campaign.getThumb() %>" alt="<%= campaign.getTitle() %>" />
								</p>
								<div class="list_info">
									<div class="title_wrap">
										<h4 class="title"><%= campaign.getTitle() %></h4>
										<p class="org"><%= campaign.getHash_tag() %></p>
									</div>
								</div>
								<p class="company">해피빈</p>
							</a>
						</li>
						<% } %>
					</ul>
				</div>
			</section>
		</div>
		<jsp:include page="/views/footer.jsp" />
	</body>
</html>

