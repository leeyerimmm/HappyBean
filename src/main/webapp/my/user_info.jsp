<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="join.joinBean, donation.DonationMgr, donation.DonationListBean , java.time.*, java.util.*" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
	request.setCharacterEncoding("UTF-8");
	String user_id = (String)session.getAttribute("idKey");
%>
<jsp:useBean id="jMgr" class="join.joinMgr" />
<jsp:useBean id="jBean" class="join.joinBean" />
<jsp:useBean id="dMgr" class="donation.DonationMgr" />
<jsp:useBean id="dlMgr" class="donation.DonationListBean" />
<%
	joinBean reBean = jMgr.userInfo(user_id);
	String name = reBean.getName();
	int amount_held = reBean.getAmount_held();
	int[] getDonaFundAmount = new int[2];
	getDonaFundAmount = dMgr.getDonaFundAmount(user_id);
%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="./../css/reset.css" />
    <link rel="stylesheet" href="./../css/my/user_info.css" />
    <link rel="icon" href="./../images/common/favicon.ico" type="image/x-icon" />
    <script defer src="./../js/common/common.js"></script>
    <title>해피빈 - 내 정보</title>
  </head>
  <body>
	<jsp:include page="/views/header.jsp" />
    <div id="wrap" class="w_max">
      <section id="user_info_list_wrap" class="w_max">
        <div class="user_name_box">
          <div class="icon"><span class="sr-only">해피빈 마스코트</span></div>
          <h2><span class="user_name"><%= name %></span> 님</h2>
          <p>당신의 기부가 <br />어느 누군가에겐 희망입니다.</p>
        </div>
        <div class="user_info_box">
          <ul class="info_list">
            <li>
              <a href="#">
                <p>보유콩</p>
                <p><strong class="hold_bean">0</strong>개</p>
              </a>
            </li>
            <li>
              <a href="#">
                <p>결제금액</p>
                <p><strong class="payment">0</strong>원</p>
              </a>
            </li>
            <li>
              <a href="#">
                <p>콩저금통</p>
                <p><strong class="cash_box">0</strong>원</p>
              </a>
            </li>
            <li class="total">
              <a href="#">
                <p>보유금액</p>
                <p><strong class="total_sum"><%= amount_held %></strong>원</p>
              </a>
            </li>
            <li class="recharge_bean">
              <form action=""></form>
              <a href="./../payment/charge.jsp?amount_held=<%= amount_held %>"><span>해피빈 충전</span></a>
            </li>
          </ul>
        </div>
        <nav class="user_menu_list_box">
          <ul id="user_menu_list">
            <li class="current"><a href="#">MY홈</a></li>
            <li class=""><a href="#">내 소식</a></li>
            <li class=""><a href="#">활동내역</a></li>
            <%

            try{
                if(user_id.equals("master")){
                	%>
                	<li class=""><a href="../admin/manager_donation.jsp">관리자 모드</a></li>
                	<%
                }else{
    	            %>
    	            <li class=""><a href="./user_info_edit.jsp">내 정보 수정</a></li>
                	<%
                }
            }catch(Exception e){
        		%>
        		<script>
        			alert("잘못된 접근입니다.");
        			location.href="../index.jsp";
        		</script>
        		<%
            }
            %>
            <!-- <li class="">
              <a href="#" class="sub_in">정기결제관리</a>
              <ul class="sub_menu_list">
                <li><a href="#">정기기부</a></li>
                <li><a href="#">정기적금</a></li>
              </ul>
            </li>
            <li class="">
              <a href="#" class="sub_in">연말정산</a>
              <ul class="sub_menu_list">
                <li><a href="#">2023 연말정산</a></li>
                <li><a href="#" class="new">전자기부금영수증</a></li> -->
              </ul>
            </li>
          </ul>
        </nav>
      </section>
      <div style="align-self: flex-start; flex-grow: 2;">
        <section id="user_activity_view_wrap">
          <h2 class="sr-only">사용자 활동내역</h2>
          <div class="user_activity">
            <div class="current_bean">
              <ul class="info_list">
                <li class="list_head">
                  <h3>나의 보유금액</h3>
                  <p><strong class="total_sum"><%= amount_held %></strong>원</p>
                  
                </li>
                <li>
                  <a href="#">
                    <p>보유콩</p>
                    <p><strong class="hold_bean">0</strong>개</p>
                  </a>
                </li>
                <li>
                  <a href="#">
                    <p>결제금액</p>
                    <p><strong class="payment">0</strong>원</p>
                  </a>
                </li>
                <li>
                  <a href="#">
                    <p>콩저금통</p>
                    <p><strong class="cash_box">0</strong>원</p>
                  </a>
                </li>
              </ul>
            </div>
            <div class="total_donation">
              <ul class="info_list">
                <li class="list_head">
                  <h3>총 후원금액</h3>
                  <p><strong class="donation_total"><%= getDonaFundAmount[0] + getDonaFundAmount[1] %></strong>원</p>
                </li>
                <li>
                  <a href="#">
                    <p>모금함 기부</p>
                    <p><strong class="donation_act"><%= getDonaFundAmount[0] %></strong>원</p>
                  </a>
                </li>
                <li>
                  <a href="#">
                    <p>펀딩 참여</p>
                    <p><strong class="funding_act"><%= getDonaFundAmount[1] %></strong>원</p>
                  </a>
                </li>
              </ul>
            </div>
          </div>       
        </section>
        <article class="event_ad_bar">
          <a href="#" class="ad_link">
            <h2>나의 정기저금 시작하고 <strong>매달 콩 10% 더 받기</strong></h2>
            <p class="ico_frame">
              <span class="sr-only">돼지저금통 아이콘</span>
            </p>
            <p class="more_btn">바로가기</p>
          </a>
        </article>

        <section class="act_history_wrap">
          <h2 class="sr-only">적립 및 사용내역</h2>
          <%
          LocalDate today = LocalDate.now();

          // 연도와 월을 원하는 형식으로 포맷
          DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM");
          String yearMonth = today.format(formatter);
          %>
          <ul class="hitory_list" data-text="최근 활동내역">
          <%
          // 사용자 후원 목록 불러오기
		  List<DonationListBean> donationLists = dMgr.getUserPreviewDonationList(user_id);
          if(donationLists.size() < 1){
        	  %>
        	  <li style="justify-content: center;">활동한 내역이 없습니다.</li>
        	  <%
          }else{
	          for(int i=0; i<donationLists.size(); i++){
	        	  DonationListBean donationList = donationLists.get(i);
	        	  if(donationList.getDonation_type().equals("후원")){
	        		  String donation_type = "후원";
	        		  String[] title = new String[2]; 
	        		  title = dMgr.getTitleCompany(donationList.getCampaign_num(), donation_type);
		        	  %>
			            <li>
			              <div class="ico_frame get">
			                <p class="ico_bg"></p>
			              </div>
			              <div class="user_history">
			                <p class="comp_date"><%= donationList.getDonation_date() %></p>
			                <h3 class="history_title">후원 참여</h3> 
			                <p class="desc"><%= title[0] %></p>
			              </div>
			              <p class="bean_num minus">
			              	<span><%= donationList.getAmount() %></span>원</p>
			            </li>
		        	  <%
	        	  } else {
	        		  String donation_type = "펀딩";
	        		  String[] title = new String[2]; 
	        		  title = dMgr.getTitleCompany(donationList.getCampaign_num(), donation_type);
		        	  %>
			            <li>
			              <div class="ico_frame use">
			                <p class="ico_bg"></p>
			              </div>
			              <div class="user_history">
			                <p class="comp_date"><%= donationList.getDonation_date() %></p>
			                <h3 class="history_title">펀딩 참여</h3> 
			                <p class="desc"><%= title[0] %></p>
			              </div>
			              <p class="bean_num minus"><span><%= donationList.getAmount() %></span>원</p>
			            </li>
				     <%
	        	  }
	        	}
          }
          %>
          </ul>

          <div class="history_more">
            <a href="#">활동내역 전체보기</a>
          </div>
        </section>
      </div>
      
    </div>
    <jsp:include page="/views/footer.jsp" />
    <script>
    	const $total_sum = document.querySelectorAll("strong.total_sum");
    	const $donation_total = document.querySelector("strong.donation_total");
    	const $donation_act = document.querySelector("strong.donation_act");
    	const $funding_act = document.querySelector("strong.funding_act");
  		const $bean_num_span = document.querySelectorAll(".bean_num span");
  		
  		$bean_num_span.forEach((item)=>{
  			item.textContent = formatNumber(item.textContent);
  		})
    	
    	const amount_held = <%= amount_held %>;
    	
    	$total_sum.forEach((item)=>{
    		item.textContent = formatNumber(amount_held);
    	});
    	
    	const getDonaAmount = <%= getDonaFundAmount[0] %>
    	const getFundAmount = <%= getDonaFundAmount[1] %>
    	$donation_act.textContent = formatNumber(getDonaAmount);
    	$funding_act.textContent = formatNumber(getFundAmount);
    	$donation_total.textContent = formatNumber(getDonaAmount + getFundAmount);
    	
    	
        function formatNumber(num) {
        	const numStr = String(num);
            return numStr.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
         }

        function formatInput() {
          const rawValue = $payBean.value.replace(/,/g, '');
          const formattedValue = formatNumber(rawValue); 
          $payBean.value = formattedValue; 
        }
         
    </script>
  </body>
</html>
