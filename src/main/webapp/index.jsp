<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="donation.DonationMgr, donation.DonationBean, Controls.FundingBean" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String user_id = (String)session.getAttribute("idKey");
%>
<jsp:useBean id="dMgr" class="donation.DonationMgr" />
<jsp:useBean id="dBean" class="donation.DonationBean" />
<jsp:useBean id="fMgr" class="Controls.FundingMgr" />
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="icon" href="./images/common/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="./css/reset.css" />
    <link rel="stylesheet" href="./css/index/index_style.css" />
    <script defer src="./js/common/common.js"></script>
    <title>해피빈</title>
  </head>
  <body>
	<jsp:include page="/views/header.jsp" />
    <div id="wrap">
      <section id="index_main">
        <h2 class="sr-only">이벤트 배너입니다.</h2>
        <div id="banner_bg"></div>
        <div id="banner_wrap">
          <ul class="banner_list">
            <li class="in">
              <a href="#">
                <img
                  src="./images/carousel/item_img_01.png"
                  alt="매주 화요일마다 해피빈 땡큐위크에 놀러오세요. 콩 쿠폰부터 다양한 미션까지 혜택이 풍성"
                />
              </a>
            </li>
          </ul>
        </div>

				<jsp:include page="/views/article_donation.jsp" />
		
				<jsp:include page="/views/article_funding.jsp" />
				
				<jsp:include page="/views/article_campaign.jsp"/>
		
      </section>
    </div>

	<jsp:include page="/views/footer.jsp" />
  </body>
</html>
