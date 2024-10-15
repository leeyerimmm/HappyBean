<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="Controls.FundingBean" %>
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
    
    
<article class="funding w_max" style="margin: 40px auto;">
  <h3 class="list_title">
    <a href="${pageContext.request.contextPath}/sub/funding/fundings.jsp">소셜벤처를 먼저 만나는 펀딩</a>
  </h3>
  <ul class="item_list list_style_2 list_div_3" style="flex-flow: row nowrap;">
  <%
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	Date today = new Date();
    	
    	NumberFormat nFormat = NumberFormat.getInstance(Locale.KOREA);
    	
    	int limit = Math.min(4, fundingList.size());
    	for(int i = 0; i < limit; i++) {  
    		FundingBean funding = fundingList.get(i);
    		Date endDate = sdf.parse(funding.getEnd_date());
    		long diff = endDate.getTime() - today.getTime();
    		long dDay = diff / (1000 * 60 * 60 * 24);
    		
    		// 진행률 환산
    		long goalAmount = Long.parseLong(funding.getGoal_amount()); 
        long rasedAmount = Long.parseLong(funding.getRased_amount());
        double progressPercentage = goalAmount > 0 ? Math.round((double) rasedAmount / goalAmount * 100) : 0;
        
    		
   	%>
    <li>
      <a href="${pageContext.request.contextPath}/sub/funding/detail.jsp?num=<%= funding.getNum() %>">
        <p class="thumb">
          <img src="${pageContext.request.contextPath}/sub/funding/images/<%= funding.getThumb() %>.jpg" alt="<%= funding.getTitle()%>" />
        </p>
        <div class="list_info">
          <div class="title_wrap">
            <p class="org"><%= funding.getCompany() %></p>
            <h4 class="title">
              <%= funding.getTitle() %>
            </h4>
          </div>
          <div class="prog_circle">
            <p class="prog_num2"><span><%= (int)progressPercentage + "%" %></span></p>
          </div>
        </div>
      </a>
    </li>

    <%          		
     	}
    %>
  </ul>
</article>