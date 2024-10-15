<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="donation.DonationMgr, donation.DonationBean" %>
<%
   request.setCharacterEncoding("UTF-8");
   String user_id = (String)session.getAttribute("idKey");
%>
<jsp:useBean id="dMgr" class="donation.DonationMgr" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" href="./../../images/common/favicon.ico" type="image/x-icon" />
  <link rel="stylesheet" href="./../../css/reset.css">
  <link rel="stylesheet" href="./../../css/header.css">
  <link rel="stylesheet" href="./css/donation.css">
  <script defer src="./../../js/common/common.js"></script>
  <title>기부 : 해피빈</title>
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
      .list_title{
        margin-bottom:30px;
     }
     
     .section1 .button {
        margin-top:0px;
     }
  </style>
</head>
<body>
  <div id="wrap">
  <jsp:include page="/views/header.jsp" />
<section class="section1 w_max" style="padding-top: 70px;">
    <h2 class="list_title">해피빈 추천 모금함</h2>
    <ul class="item_list list_style_1" style="justify-content: flex-start; gap: 26px;">
<%
    DonationMgr donationMgr = new DonationMgr();
    List<DonationBean> donations = donationMgr.getPreviewDonations();

    for (int i = 0; i < donations.size(); i++) { 
        DonationBean donation = donations.get(i);
        boolean isEnded = "종료됨".equals(donation.getStatus());
%>
        <li>
            <a href="./../fundrasing/sub/fundrasing_sub1.jsp?subnum=<%= donation.getId() %>&donation_type=후원">
                <div class="thumb_container">
                    <% if (isEnded) { %>
                    <div class="ended_label">종료</div>
                    <% } %>
                    <p class="thumb">
                        <img class="<%= isEnded ? "blurred" : "" %>" src="images/<%= donation.getThumb() %>" alt="<%= donation.getTitle() %>">
                    </p>
                </div>
                <div class="list_info">
                    <h4 class="title"><%= donation.getTitle() %></h4>
                    <p class="org"><%= donation.getCompany() %></p>
                </div>
            </a>
        </li>
        <%
            }
        %>
    </ul>
    <a href="./../fundrasing/fundrasing.jsp" class="button">더보기</a>
</section>


    <article class="article1 w_max">
      <h3>오늘 함께한 기부금 이만큼 모였어요!</h3>
      <div class="stats">
        <div class="count">
          <span>😊</span> 6,798명
        </div>
        <div class="amount">
          <span>❤️</span> 29,345,800원
        </div>
      </div>
    </article>
<article class="article2 w_max">
      <h2 class="list_title">빈자리가 늘어나도, 희망을 심는 사람들</h2>
      <p class="article2-subtitle"><strong>690명</strong>이 <strong>2,542,200원</strong> 기부했어요</p>
      <div class="donation-cards">
        <div class="donation-card">
          <div class="card-image">
            <a href="../campaign/campaigns.jsp">
              <img src="images/art2_card.jpg" alt="기부특공대">
              <div class="card-text">
                <span>기부특공대</span>
                <p class="card-title">인구감소지역에 <br>우리의 응원을 보내요!</p>
              </div>
            </a>
          </div>
        </div>
      
        <ul class="item_list list_style_1" style="flex-flow: row nowrap;">

          <li>
            <a href="../fundrasing/fundrasing.jsp">
              <p class="thumb">
                <img src="./images/art2_item_list_01.jpg" alt="까맣게 타 버린 어르신의 냄비밥, 따뜻한 식사를 선물주세요.">
              </p>
              <div class="list_info">
                <h3 class="title">
                  까맣게 타 버린 어르신의 냄비밥, 따뜻한 식사를 선물주세요.
                </h3>
                <p class="org">진도군노인복지관</p>
              </div>
            </a>
          </li>

          <li>
             <a href="../fundrasing/fundrasing.jsp">
              <p class="thumb">
                <img src="./images/art2_item_list_02.jpg" alt="잿빛 추석이 아닌 달빛 추석을 안겨 주고 싶어요!">
              </p>
              <div class="list_info">
                <h3 class="title">
                  잿빛 추석이 아닌 달빛 추석을 안겨 주고 싶어요!
                </h3>
                <p class="org">목포우리집</p>
              </div>
            </a>
          </li>

          <li>
             <a href="../fundrasing/fundrasing.jsp">
              <p class="thumb">
                <img src="./images/art2_item_list_03.jpg" alt='"꽃길만 걸으세요~" 어르신의 친구, 보행보조기' />
              </p>
              <div class="list_info">
                <h3 class="title">
                  "꽃길만 걸으세요~" 어르신의 친구, 보행보조기
                </h3>
                <p class="org">목포우리집</p>
              </div>
            </a>
          </li>          
        </ul>
      </div>
    </article>

    <section class="section2 w_max">
      <h2 class="list_title">파트너와 함께하는 나눔스토리</h2>
      <ul class="item_list list_style_1" style="flex-flow: row nowrap;">
        <li>
          <a href="../campaign/yuhan.html">
            <p class="thumb">
              <img src="./images/item_list2_01.jpg" alt="아이들의 모든 밤이 행복하도록, 굿나이트">
            </p>
            <div class="list_info">
              <h3 class="title">
                아이들의 모든 밤이 행복하도록, 굿나이트
              </h3>
              <p class="org">밀알복지재단</p>
              
            </div>
          </a>
        </li>
        <li>
          <a href="../campaign/jungkwanjang.html">
            <p class="thumb">
              <img src="./images/item_list2_03.jpg" alt="효심 가득, 효배달로 무한한 사랑에 보답해요">
            </p>
            <div class="list_info">
              <h3 class="title">
                효심 가득, 효배달로 무한한 사랑에 보답해요
              </h3>
              <p class="org">KGC인삼공사</p>
            </div>
          </a>
        </li>  
        <li>
          <a href="../campaign/campaigns.jsp">
            <p class="thumb">
              <img src="./images/item_list2_02.jpg" alt="매출의 N%를 기부하는 착한기업, 굿브랜드">
            </p>
            <div class="list_info">
              <h3 class="title">
                매출의 N%를 기부하는 착한기업, 굿브랜드
              </h3>
              <p class="org">해피빈</p>
              
            </div>
          </a>
        </li>  
        

      </ul>
    </section>

    <jsp:include page="/views/article_funding.jsp"/>
    
  </div>
  <jsp:include page="/views/footer.jsp" />
</body>
</html>