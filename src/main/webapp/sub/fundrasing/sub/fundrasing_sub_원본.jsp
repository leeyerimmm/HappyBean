<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="donation.DonationMgr, donation.DonationBean, join.joinMgr" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="dMgr" class="donation.DonationMgr" />
<jsp:useBean id="dBean" class="donation.DonationBean" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>모금 상세페이지</title>
    <link rel="stylesheet" href="./../../../css/reset.css">
    <link rel="stylesheet" href="./../css/fundrasing_sub.css">
    <script defer src="./../js/fundrasing_sub.js"></script>
    <style>
		.item_list.list_style_2 li {
		  width: 33.3333333333%;
		}
		h3.list_title {
		  margin-top: 80px;
		  padding-bottom: 20px;
		}
		h3.list_title > a {
		  position: relative;
		  font-size: 1.5em;
		}
		h3.list_title > a::after {
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

    </style>
</head>
<body>
<body>
  <jsp:include page="/views/header.jsp" />
  <div id="wrap">
    <section>
      <h2 class="sr-only">모금 상세 페이지</h2>

      <%
	  String subnumParam = request.getParameter("subnum");
      String donation_type = request.getParameter("donation_type");
      if (subnumParam != null) {
          int subnum = Integer.parseInt(subnumParam);
	      int RaisedAmount = dMgr.raisedAmount(subnum, donation_type);
          DonationMgr donationMgr = new DonationMgr();
          DonationBean donation = donationMgr.getDonationById(subnum); 

          if (donation != null) {
            // 숫자 포맷
            NumberFormat nf = NumberFormat.getInstance();
            String formattedGoalAmount = nf.format(donation.getGoalAmount());
            String formattedRaisedAmount = nf.format(RaisedAmount);

            // 남은 날짜
            java.util.Date today = new java.util.Date();
            long diffInMillies = donation.getEndDate().getTime() - today.getTime();
            long diff = java.util.concurrent.TimeUnit.DAYS.convert(diffInMillies, java.util.concurrent.TimeUnit.MILLISECONDS);

            // 진행률
            int progressPercentage = (int)((RaisedAmount * 100) / donation.getGoalAmount());

            // description
            Vector<String> descriptionParts = donation.getDescriptionParts();

            // 기부금 사용계획
            Vector<String> costDetailsList = donation.getCostDetailsList();
            Vector<String> costDescriptionsList = donation.getCostDescriptionsList();
            Vector<String> costAmountsList = donation.getCostAmountsList();

            // 사업대상 및 기대효과
            String projectDuration = donation.getProjectDuration();
            String targetGroup = donation.getTargetGroup();
            int targetCount = donation.getTargetCount();
            String[] effects = donation.getExpectedEffect().split("\\|");
            
            // 종료된 기부 팝업 처리
            if (donation.getStatus().equals("종료됨")) {
				%>
		        <div id="popup-wrapper">
		            <div id="popup" class="popup_show">
		                <div class="popup_content">
		                    <h3><strong>모금이 종료되었습니다</strong></h3>
		                    <p>이 단체의 소중한 활동을 계속 응원해주세요!</p>
		                    <button class="close_popup_btn" onclick="closePopup()">X</button>
		                    <a href="../fundrasing.jsp" class="regular_donation_btn">다른 후원 보기</a>
		                </div>
		            </div>
		        </div>
		        <script>
			        document.addEventListener("DOMContentLoaded", ()=>{
			            document.querySelector(".plan_donate").style.display = "none";
			        	document.querySelector(".status_btn").style.display = "none";
			        });
				</script>
				<%
            }
      %>

      <article class="content_container">
        <div class="article_content">
          <div class="introduce">
            <h3><%= donation.getCategory() %></h3>
            <h4 style="line-height: 1.3;"><%= donation.getTitle() %></h4>
            <div class="introduce_btn">
              <a href="#" class="selected">모금함 소개</a>
              <a href="#">참여 내역</a>
              <a href="#">모금 소식</a>
            </div>

            <article class="fundrasing_sub1">
              <%
              for (int i = 0; i < descriptionParts.size(); i++) {
                  if (i % 2 == 0) {
              %>
              <h5><%= descriptionParts.get(i) %></h5>
              <%
                  } else {
              %>
              <p><%= descriptionParts.get(i) %></p>
              <%
                  }
              }
              %>
              
              <p>
                <a href="#" class="company">
                  <%= donation.getCompany() %> 홈페이지
                </a>  
              </p>

              <div class="img_slide">
                <ul>
                  <li class="selected">
                    <img class="selected" src="../images/<%= donation.getThumb() %>" alt="<%= donation.getTitle() %>">
                  </li>
                  <% 
                  List<String> subImagesList = donation.getSubImagesList();
                  for (int i = 0; i < subImagesList.size(); i++) {
                  %>
                  <li>
                    <img class="selected" src="../images/<%= subImagesList.get(i) %>" alt="<%= donation.getTitle() %>">
                  </li>
                  <% } %>
                </ul>
              </div>

              <div class="img_preview">
                <ul>
                  <li>
                    <div class="selected">
                      <img class="selected" src="../images/<%= donation.getThumb() %>" alt="<%= donation.getTitle() %>">
                    </div>
                  </li>
                  <% 
                  for (int i = 0; i < subImagesList.size(); i++) {
                  %>
                  <li>
                    <div>
                      <img class="selected" src="../images/<%= subImagesList.get(i) %>" alt="<%= donation.getTitle() %>">
                    </div>
                  </li>
                  <% } %>
                </ul>
              </div>

              <div class="plan">
                <p><strong>기부금 사용계획</strong> | 여러분들의 소중한 기부금 이렇게 사용됩니다.</p>
                <table>
                  <tr class="trtd_color">
                    <td><strong>총 집행금액</strong></td>
                    <td colspan="2"><strong><%= formattedGoalAmount %></strong> 원 (목표금액 <%= formattedGoalAmount %> 원)</td>
                  </tr>
                  <%
                  for (int i = 0; i < costDetailsList.size(); i++) {
                	  String formattedCostAmount = nf.format(Integer.parseInt(costAmountsList.get(i)));
                  %>
                  <tr>
                    <td><%= costDetailsList.get(i) %></td>
                    <td><%= costDescriptionsList.get(i) %></td>
                    <td><%= formattedCostAmount %> 원</td>
                  </tr>
                  <% } %>
                </table>
              </div>

              <div class="plan">
                <p><strong>사업대상 및 기대효과</strong></p>
                <table>
                  <tr>
                    <td class="trtd_color"><strong>사업 기간</strong></td>
                    <td colspan="2"><%= projectDuration %> </td>
                  </tr>
                  <tr>
                    <td class="trtd_color"><strong>사업 대상</strong></td>
                    <td colspan="2"><%= targetGroup %></td>
                  </tr>
                  <tr>
                    <td class="trtd_color"><strong>대상 수</strong></td>
                    <td colspan="2"><%= targetCount %> 명</td>
                  </tr>
                  <tr>
                    <td class="trtd_color"><strong>기대 효과</strong></td>
                    <td colspan="2">
                      <ul>
                        <% for (int i = 0; i < effects.length; i++) { %>
                        <li><%= effects[i] %></li>
                        <% } %>
                      </ul>
                    </td>
                  </tr>
                </table>
              </div>
							<form name="donateFrm" action="<%= request.getContextPath() %>/payment/payment.jsp?subnum=<%= subnumParam %>&donation_type=<%= donation_type %>">
								<input type="hidden" name="title" value="<%= donation.getTitle()%>"/>
							</form>
              <a class="plan_donate" href="<%= request.getContextPath() %>/payment/payment.jsp?subnum=<%= subnumParam %>&donation_type=<%= donation_type %>"><strong>모금함 기부하기</strong></a>
            </article>
          </div>
        </div>

        <div class="article_involved">
          <div class="status">
            <h2><span><%= progressPercentage %></span> %</h2>
            <div class="progress_container">
              <div class="progress_bar" style="width: <%= progressPercentage %>%;"></div>
            </div>
            <div class="duration">
              <p><%= donation.getStartDate() %> ~ <%= donation.getEndDate() %>까지</p>
              <p>D-<%= diff >= 0 ? diff : "종료됨" %></p>
            </div>
            <div class="goal">
              <p><span><%= formattedRaisedAmount %></span> 원</p>
              <p>네티즌 <%= formattedRaisedAmount %> 원</p>
              <p>기업 0 원</p>
              <p><%= formattedGoalAmount %> 원 목표</p>
            </div>
          </div>
          <p class="status_btn"><a href="<%= request.getContextPath() %>/payment/payment.jsp?subnum=<%= subnumParam %>&donation_type=<%= donation_type %>">모금함 기부하기</a></p>
          <div class="status_article">
            <p>기부하신 금액은 수수료 없이<br /> <span>100% 전달</span> 됩니다.</p>
          </div>
        </div>
      </article>
      <jsp:include page="/views/article_funding.jsp" />

      <%
        } else {
          out.println("데이터가 존재하지 않습니다.");
        }
      }
      %>
    </section>
  </div>
  <jsp:include page="/views/footer.jsp" />
</body>
</html>