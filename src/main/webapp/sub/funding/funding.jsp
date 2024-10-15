<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Controls.FundingBean" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<jsp:useBean id="fMgr" class="Controls.FundingMgr"/>
<%
	request.setCharacterEncoding("utf-8");
  Vector<FundingBean> fundingList = new Vector<FundingBean>();
  fMgr.updateFundingStatus();
   
   try {
       fundingList = fMgr.getFundingList();
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sub/funding/style.css" />
    <script defer src="${pageContext.request.contextPath}/js/common/common.js"></script>
    <title>해피빈 : 펀딩</title>
  </head>
  <body>
    <jsp:include page="/views/header.jsp"/>
    <div id="wrap">
      <section style="padding-top: 60px">       

        <div class="w_max">
          <ul class="item_list list_style_2">
          <%
          	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
          	Date today = new Date();
          	
          	NumberFormat nFormat = NumberFormat.getInstance(Locale.KOREA);
          	
          	for(FundingBean funding : fundingList) {  
          		Date endDate = sdf.parse(funding.getEnd_date());
          		long diff = endDate.getTime() - today.getTime();
          		long dDay = diff / (1000 * 60 * 60 * 24);
          		
          		// 진행률 환산
          		long goalAmount = Long.parseLong(funding.getGoal_amount()); 
              long rasedAmount = Long.parseLong(funding.getRased_amount());
              double progressPercentage = goalAmount > 0 ? Math.round((double) rasedAmount / goalAmount * 100) : 0;
              
          		
         	%>
         		
         		<li>
              <a href="detail.jsp?num=<%= funding.getNum() %>">
                <p class="thumb">
                  <img src="./images/<%= funding.getThumb() %>" alt="<%= funding.getTitle()%>"/>
                </p>
                <div class="list_info">
                  <div class="title_wrap">
                    <h4 class="title"><%= funding.getTitle() %></h4>
                    <p class="org"><%= funding.getCompany() %></p>
                  </div>
                  <div class="prog_circle">
                    <p class="prog_num2">
                    	<span><%= (int)progressPercentage + "%" %></span>
                    </p>
                  </div>
                </div>
                <div class="d_day_wrap">
                  <p>
                  	<%= dDay >= 0 ? "<span class='day'>"+ dDay +"</span>일 남음" : "종료" %>
                  </p>
                  <p><strong class="total"><%= nFormat.format(Long.parseLong(funding.getRased_amount())) %></strong>원</p>
                </div>
              </a>
            </li>
         		
         	<%          		
          	}
          %>
            

          </ul>
        </div>
      </section>
    </div>
    <jsp:include page="/views/footer.jsp"/>
  </body>
</html>
