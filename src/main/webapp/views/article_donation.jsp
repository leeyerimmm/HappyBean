<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="donation.DonationMgr, donation.DonationBean" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String user_id = (String)session.getAttribute("idKey");
    String serverName = request.getServerName(); // 호스트 이름 (localhost)
    int serverPort = request.getServerPort(); // 포트 번호
    String scheme = request.getScheme(); // 프로토콜 (http 또는 https)
	String contextPath = request.getContextPath();

    String fullUrl = scheme + "://" + serverName + ":" + serverPort + contextPath;
%>
<jsp:useBean id="dMgr" class="donation.DonationMgr" />
<jsp:useBean id="dBean" class="donation.DonationBean" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	article {
	  margin: 0 auto;
	  padding-top: 60px;
	}
	article.donation {
	  margin-top: 20px;
	}
	article > h3.list_title {
	  padding-bottom: 20px;
	}
	article > h3.list_title > a {
	  position: relative;
	  font-size: 1.5em;
	}
	article > h3.list_title > a::after {
	  content: "";
	  display: block;
	  position: absolute;
	  top: 50%;
	  right: -20px;
	  transform: translateY(-50%) rotate(45deg);
	  width: 10px;
	  height: 10px;
	  border: 1px solid;
	  border-color: #222 #222 transparent transparent;
	}
	  .thumb_container {
	    position: relative;
	    display: inline-block;
		}
	  .ended_label {
	    position: absolute;
	    top: 50%;
	    left: 50%;
	    transform: translate(-50%, -50%);
	    color: black;
	    background-color: white;
	    padding: 10px 20px;
	    border-radius: 5px;
	    font-size: 18px;
	    font-weight: bold;
	    text-align: center;
	    z-index: 1; 
		}
		.blurred {
		    filter: blur(5px); 
		}
		.thumb{
			overflow: hidden;
		}
</style>
</head>
  <article class="donation w_max">
    <h3 class="list_title"><a href="<%= fullUrl %>/sub/donation/donation.jsp">100% 전달하는 기부</a></h3>
    <ul class="item_list list_style_1">
    	<%
  	List<DonationBean> donations = dMgr.getPreviewDonations(); 

  	
  	for (int i = 0; i < donations.size(); i++) {
  		DonationBean donation = donations.get(i);
        	NumberFormat nf = NumberFormat.getInstance();
          String formattedRaisedAmount = nf.format(donation.getRaisedAmount());
       	// 진행률
          int progressPercentage = (donation.getRaisedAmount() * 100) / donation.getGoalAmount();
          boolean isEnded = "종료됨".equals(donation.getStatus());
          System.out.println(donation.getStatus());
    	%>
      <li>
        <a href="<%= fullUrl %>/sub/fundrasing/sub/fundrasing_sub1.jsp?subnum=<%= donation.getId() %>&donation_type=후원">
          <div class="thumb_container">
              <% if (isEnded) { %>
              <div class="ended_label">종료</div>
              <% } %>
              <p class="thumb">
                  <img class="<%= isEnded ? "blurred" : "" %>" src="<%= fullUrl %>/sub/donation/images/<%= donation.getThumb() %>" alt="<%= donation.getTitle() %>">
              </p>
          </div>
          <div class="list_info">
            <h4 class="title"><%= donation.getTitle() %></h4>
            <p class="org"><%= donation.getCompany() %></p>
            <%
           	if(progressPercentage > 100){
           		progressPercentage = 100;
           	}
           	%>
            <p class="prog_bar">
              <span class="sr-only">현재 진행률</span><strong style="width: <%= progressPercentage %>%"></strong>
            </p>
            <p class="prog_info">
              <span class="prog_num">
              	<%= progressPercentage %>%
              </span>
              <span class="amount_num"><%= formattedRaisedAmount %>원</span>
            </p>
          </div>
        </a>
      </li>
      <%
  	}
      %>
    </ul>
  </article>
</body>
</html>