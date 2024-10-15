<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" href="${pageContext.request.contextPath}/images/common/favicon.ico" type="image/x-icon" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sub/donation/donation.css">
  <script defer src="${pageContext.request.contextPath}/js/common/common.js"></script>
  <title>해피빈  : 기부</title>
</head>
<body>
  <jsp:include page="/views/header.jsp"/>
  <div id="wrap">
    <section class="section1 w_max" style="padding-top: 70px;">
      <h2 class="list_title">해피빈 추천 모금함</h2>
      <ul class="item_list list_style_1">
        <li>
          <a href="#">
            <p class="thumb">
              <img src="./images/item_list1_01.jpg" alt="준우가 치료시기를 놓치지 않도록 도와주세요.">
            </p>
            <div class="list_info">
              <h4 class="title">
                준우가 치료시기를 놓치지 않도록 도와주세요.
              </h4>
              <p class="org">밀알복지재단</p>
              
            </div>
          </a>
        </li>

        <li>
          <a href="#">
            <p class="thumb">
              <img src="./images/item_list1_02.jpg" alt="우리의 소원, 가족들을 시설에 초대하고 싶어요.">
            </p>
            <div class="list_info">
              <h4 class="title">
                우리의 소원, 가족들을 시설에 초대하고 싶어요.
              </h4>
              <p class="org">사회복지법인승가원</p>
              
            </div>
          </a>
        </li>

        <li>
          <a href="#">
            <p class="thumb">
              <img src="./images/item_list1_03.jpg" alt="갑자기 잃어버린 소리, 찬영이는 다시 듣고 싶습니다.">
            </p>
            <div class="list_info">
              <h4 class="title">
                갑자기 잃어버린 소리, 찬영이는 다시 듣고 싶습니다.
              </h4>
              <p class="org">
                대한적십자사 전북특별자치도지사
              </p>
            </div>
          </a>
        </li>

        <li>
          <a href="#">
            <p class="thumb">
              <img src="./images/item_list1_04.png" alt="선생님 추석이 뭐가 특별해요? 어차피 혼자예요.">
            </p>
            <div class="list_info">
              <h4 class="title">
                선생님 추석이 뭐가 특별해요? 어차피 혼자예요.
              </h4>
              <p class="org">그루터기지역아동센터</p>
            </div>
          </a>
        </li>

        <li>
          <a href="#">
            <p class="thumb">
              <img src="./images/item_list1_05.jpg" alt="MBN 소나무 노래로 장애를 딛고 일어서려는 가족">
            </p>
            <div class="list_info">
              <h4 class="title">
                MBN 소나무 노래로 장애를 딛고 일어서려는 가족
              </h4>
              <p class="org">
                사회복지공동모금회
              </p>
            </div>
          </a>
        </li>
        
        <li>
          <a href="#">
            <p class="thumb">
              <img src="./images/item_list1_06.jpg" alt="KBS 동행 제471화 대박을 꿈꾸는 다슬기 소년">
            </p>
            <div class="list_info">
              <h4 class="title">
                KBS 동행 제471화 대박을 꿈꾸는 다슬기 소년
              </h4>
              <p class="org">초록우산</p>
            </div>
          </a>
        </li>

        <li>
          <a href="#">
            <p class="thumb">
              <img src="./images/item_list1_07.jpg" alt="독거 장애 어르신들에게 맛있는 반찬을 선물해주세요">
            </p>
            <div class="list_info">
              <h4 class="title">
                독거 장애 어르신들에게 맛있는 반찬을 선물해주세요.
              </h4>
              <p class="org">송파인성장애인복지관</p>
            </div>
          </a>
        </li>

        <li>
          <a href="#">
            <p class="thumb">
              <img src="./images/item_list1_08.jpg" alt="홀몸 어르신들에게 맛있는 반찬을 선물해 주세요.">
            </p>
            <div class="list_info">
              <h4 class="title">
                홀몸 어르신들에게 맛있는 반찬을 선물해 주세요.
              </h4>
              <p class="org">
                사단법인 미션앤컬쳐
              </p>
            </div>
          </a>
        </li>       
      </ul>
      <a href="sub2.html" class="button">더보기</a>
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
            <a href="#">
              <img src="images/art2_card.jpg" alt="기부특공대">
              <div class="card-text">
                <span>기부특공대</span>
                <p class="card-title">인구감소지역에 <br>우리의 응원을 보내요!</p>
              </div>
            </a>
          </div>
        </div>
      
        <ul class="item_list list_style_1">

          <li>
            <a href="#">
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
            <a href="#">
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
            <a href="#">
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
      <ul class="item_list list_style_1">
        <li>
          <a href="#">
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
          <a href="#">
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
        
        <li>
          <a href="#">
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

      </ul>
    </section>

    <section class="section3 w_max">     
      <h2 class="list_title">마음이 풍성해지는 파트너Pick</h2>
      <ul class="item_list list_style_1">

        <li>
          <a href="#">
            <p class="thumb">
              <img src="./images/item_list3_01.png" alt="혼자 사시는 어르신에게 풍요로운 추석을 선물해주세요.">
              <div class="badge">KGC인삼공사 효배달</div>
            </p>
            <div class="list_info">
              <h3 class="title">
                혼자 사시는 어르신에게 풍요로운 추석을 선물해주세요.
              </h3>
              <p class="org">따뜻한동행</p>
              <p class="prog_bar"><span class="sr-only">현재 진행률</span><strong></strong></p>
              <p class="prog_info">
                <span class="prog_num">94%</span>
                <span class="amount_num">23,838,400원</span>
              </p>
            </div>
          </a>
        </li>

        <li>
          <a href="#">
            <p class="thumb">
              <img src="./images/item_list3_02.jpg" alt="갑자기 잃어버린 소리, 찬영이는 다시 듣고 싶습니다.">
              <div class="badge">블루포션게임즈</div>
            </p>
            <div class="list_info">
              <h3 class="title">
                갑자기 잃어버린 소리, 찬영이는 다시 듣고 싶습니다.
              </h3>
              <p class="org">대한적십자사 전북특별자치도지사</p>
              <p class="prog_bar"><span class="sr-only">현재 진행률</span><strong></strong></p>
              <p class="prog_info">
                <span class="prog_num">99%</span>
                <span class="amount_num">8,550,000원</span>
              </p>
            </div>
          </a>
        </li>

        <li>
          <a href="#">
            <p class="thumb">
              <img src="./images/item_list3_03.png" alt="주현이의 미소를 지키고 싶은 엄마의 다짐">
              <div class="badge">유한킴벌리 굿나이트</div>
            </p>
            <div class="list_info">
              <h3 class="title">
                주현이의 미소를 지키고 싶은 엄마의 다짐
              </h3>
              <p class="org">초록우산</p>
              <p class="prog_bar"><span class="sr-only">현재 진행률</span><strong></strong></p>
              <p class="prog_info">
                <span class="prog_num">54%</span>
                <span class="amount_num">1,965,800원</span>
              </p>
            </div>
          </a>
        </li>  

        <li>
          <a href="#">
            <p class="thumb">
              <img src="./images/item_list3_04.jpg" alt="미혼모, 한부모 가족들의 행복한 명절나기">
              <div class="badge">LG전자</div>
            </p>
            <div class="list_info">
              <h3 class="title">
                미혼모, 한부모 가족들의 행복한 명절나기
              </h3>
              <p class="org">사단법인 여성인권 동감</p>
              <p class="prog_bar"><span class="sr-only">현재 진행률</span><strong></strong></p>
              <p class="prog_info">
                <span class="prog_num">14%</span>
                <span class="amount_num">1,416,700원</span>
              </p>
            </div>
          </a>
        </li>  
      </ul>
    </section>
    <section class="section4 w_max">
      <h2 class="list_title">모금함 후기</h2>
      <ul class="list4">
        <li class="item_list4">
          <a href="#">
          <div class="review-header">
            <img src="images/item_list4_01.jpg" alt="낡은 다회용 도시락(용기) 교체 사업">
            <h3 class="list_title">낡은 다회용 도시락(용기) 교체 사업</h3>
          </div>
          <div class="review-body">
            <p class="sub_title">사랑마루는 2010년부터 지금까지 14년째 노숙인 및 일용직근로자, 독거어르신을 위한 무료급식사업과 독거 어르신 대상 반찬나눔 사업을 진행해 오고 있습니다. 사랑마루는 매주 60여 명의 취약계층 독거 어르신들에 당일에 직접 만든 반찬을 나눠드립니다.</p>
          </div>
        </a>
        </li>
        <li class="item_list4">
          <a href="#">
          <div class="review-header">
            <img src="images/item_list4_02.jpg" alt="함께해주신 휴온스 임직원 분들과 해피빈 기부자님들께 감사드립니다">
            <h3 class="list_title">함께해주신 휴온스 임직원분들과 해피빈 기부자님들께 감사드립니다</h3>
          </div>
          <div class="review-body">
            <p class="sub_title">'멸균팩'이라는 명칭이 시민들에게 익숙하지 않을 텐데 관심을 많이 가져주실까 하고 걱정을 했었습니다. 그런데 많은 분이 멀균팩이 제대로 분리배출되지 않고 있는 상황에 대한 문제 제기에 공감해주셨고, 열심히 분리배출을 실천해도 재활용이 되지 않는 현실에 안타까워하시며 멸균팩 분리배출 활동에 함께해주셨습니다.</p>
          </div>
        </a>
        </li>
        <li class="item_list4">
          <a href="#">
          <div class="review-header">
            <img src="images/item_list4_03.jpg" alt="섬에도 행복한 웃음이 피어났습니다.">
            <h3 class="list_title">섬에도 행복한 웃음이 피어났습니다.</h3>
          </div>
          <div class="review-body">
            <p class="sub_title">늘 TV소리만 들리던 경로당에 오늘따라 어르신의 웃음 소리가 가득합니다. 섬이라는 지리적 한계로 복지관에서 진행하는 다양한 프로그램에 참여할 기회가 없던 어르신들. 항상 경로당에서 TV만 보시는 어르신들을 위한 프로그램을 진행하기 위해 모금을 기획했습니다.</p>
          </div>
        </a>
        </li>
      </ul>
    </section>
  </div>
  <jsp:include page="/views/footer.jsp"/>
</body>
</html>