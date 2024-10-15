<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="donation.DonationBean, java.util.*, java.text.*" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="dMgr" class="donation.DonationMgr" />
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="icon" href="./../../images/common/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="./../../css/reset.css" />
    <link rel="stylesheet" href="./css/fundraising.css" />
    <script defer src="./js/fundrasing.js"></script>
    <script defer src="./../../js/common/common.js"></script>
    <title>진행중인 모금함</title>
    <style>
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
			div.thumb_container img {
			    width: 264px;
			    height: 190px;
			    object-fit: cover;
			    box-sizing: border-box;
			}
    </style>
  </head>
  <body>
	<jsp:include page="/views/header.jsp" />
    <div id="wrap">
      <section>
      	<%
      	int[] getTotalUserAmount = new int[2];
      	getTotalUserAmount = dMgr.getTotalUserAmount();
      	%>
        <h2 class="sr-only">진행중인 모금함 리스트</h2>
        <p class="total_article">모금함 <span>793</span>개</p>
        <article>
          <h3 class="sr-only">진행중인 모금함 리스트</h3>
          <ul class="item_list list_style_1">
            <li class="total_together">
              <p><strong>ALL</strong></p>
              <p><strong>현재까지 모인 기부금</strong></p>
              <p>---</p>
              <p><strong><%= getTotalUserAmount[0] %>명</strong>이</p>
              <p><strong><%= getTotalUserAmount[1] %>원</strong>을</p>
              <p>기부하였습니다.</p>
            </li>

			<%
			List<DonationBean> bean = dMgr.getAllDonations();
			if(bean.size() < 1){
				%>
				<li></li>
				<li>진행중인 모금이 없습니다.</li>
				<li></li>
				<script>
					document.addEventListener("DOMContentLoaded", ()=>{
						$total_article_textContent()
					});
				</script>
				<%
			}else{
				for(int i=0; i<bean.size(); i++){
					DonationBean lists = bean.get(i);
	              	NumberFormat nf = NumberFormat.getInstance();
	                String formattedRaisedAmount = nf.format(lists.getRaisedAmount());
	                int progressPercentage = (lists.getRaisedAmount() * 100) / lists.getGoalAmount();
	                boolean isEnded = "종료됨".equals(lists.getStatus());
	                System.out.println("num = " + lists.getId() + " isEbded = " + isEnded + lists.getStatus());
					%>
		            <li>
		              <a href="./../fundrasing/sub/fundrasing_sub1.jsp?subnum=<%= lists.getId() %>&donation_type=후원">
		                <div class="thumb_container">
		                    <% if (isEnded) { %>
		                    <div class="ended_label">종료</div>
		                    <% } %>
		                    <p class="thumb">
		                        <img class="<%= isEnded ? "blurred" : "" %>" src="./images/<%= lists.getThumb() %>" alt="<%= lists.getTitle() %>">
		                    </p>
		                </div>
		                <div class="list_info">
		                  <h4 class="title">
		                    <%= lists.getTitle() %>
		                  </h4>
		                  <p class="org"><%= lists.getCompany() %></p>
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
			}
			%>

            
          </ul>
          <button type="button" class="more">더보기</button>
        </article>
        <div class="banner">
          <img src="./images/banner_001.jpg" alt="banner" />
        </div>
      </section>
    </div>
    <jsp:include page="/views/footer.jsp" />
    <script>
    	const $totalUser = document.querySelector(".total_together p:nth-of-type(4) strong");
    	const $totalAmount = document.querySelector(".total_together p:nth-of-type(5) strong");
    	
    	$totalUser.textContent = formatNumber(<%= getTotalUserAmount[0] %>) + "명";
    	$totalAmount.textContent = formatNumber(<%= getTotalUserAmount[1] %>) + "원";
    	
        function formatNumber(num) {
        	const numStr = String(num);
            return numStr.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
         }
    	
    </script>
  </body>
</html>
