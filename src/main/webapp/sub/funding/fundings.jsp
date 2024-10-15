<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
String stat = request.getParameter("stat");
String target = request.getParameter("target");

fMgr.updateFundingStatus(); // 펀딩 상태 업데이트

String selectKategorie = request.getParameter("kategorie") != null ? request.getParameter("kategorie") : "전체";
String selectStatus = request.getParameter("status") != null ? request.getParameter("status") : "전체";

Vector<FundingBean> fundingList;

 // 카테고리별 펀딩 리스트 가져오기
 if (selectKategorie.equals("전체")) {
     fundingList = fMgr.getFundingListByStatus(selectStatus); 
 } else {
     fundingList = fMgr.getKategorieList(stat, target);
     
     // 상태에 따라 필터링
     if (!selectStatus.equals("전체")) {
         fundingList = fMgr.getFundingListByStatus(fundingList, selectStatus);
     }
 }
%>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="icon" href="${pageContext.request.contextPath}/images/common/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sub/funding/funding.css" />
    <script defer src="${pageContext.request.contextPath}/js/common/common.js"></script>
    <title>해피빈 : 펀딩</title>
  </head>
  <body>
    <jsp:include page="/views/header.jsp"/>
    <div id="wrap">
      <section id="funding_list">       

        <div class="w_max">
        	<nav id="funding_kategorie">
						<form action="#" method="post" name="kategorieFrm">
              <input type="radio" name="kategorie" id="kategorieBtnAll" value="전체" class="sr-only" <%= selectKategorie.equals("전체") ? "checked" : "" %> onchange="changeSelect()" />
              <label for="kategorieBtnAll">전체</label>
              <input type="radio" name="kategorie" id="kategorieBtn1" value="일자리창출" class="sr-only" <%= selectKategorie.equals("일자리창출") ? "checked" : "" %> onchange="changeSelect()"/>
              <label for="kategorieBtn1">일자리창출</label>
              <input type="radio" name="kategorie" id="kategorieBtn2" value="공정무역" class="sr-only" <%= selectKategorie.equals("공정무역") ? "checked" : "" %> onchange="changeSelect()"/>
              <label for="kategorieBtn2">공정무역</label>
              <input type="radio" name="kategorie" id="kategorieBtn3" value="친환경" class="sr-only" <%= selectKategorie.equals("친환경") ? "checked" : "" %> onchange="changeSelect()"/>
              <label for="kategorieBtn3">친환경</label>
              <input type="radio" name="kategorie" id="kategorieBtn4" value="기부" class="sr-only" <%= selectKategorie.equals("기부") ? "checked" : "" %> onchange="changeSelect()"/>
              <label for="kategorieBtn4">기부</label>
              <input type="radio" name="kategorie" id="kategorieBtn5" value="작은가게" class="sr-only" <%= selectKategorie.equals("작은가게") ? "checked" : "" %> onchange="changeSelect()"/>
              <label for="kategorieBtn5">작은가게</label>
              <input type="radio" name="kategorie" id="kategorieBtn6" value="미디어" class="sr-only" <%= selectKategorie.equals("미디어") ? "checked" : "" %> onchange="changeSelect()"/>
              <label for="kategorieBtn6">미디어</label>
              <input type="radio" name="kategorie" id="kategorieBtn7" value="창작자" class="sr-only" <%= selectKategorie.equals("창작자") ? "checked" : "" %> onchange="changeSelect()"/>
              <label for="kategorieBtn7">창작자</label>
             </form>
						<form action="#" method="post" style="margin-top: 40px" name="currentFrm" onchange="changeSelect()">
							<select name="status" id="statusSelect">
								<option value="전체"  selected>전체</option>
								<option value="진행중" <%= selectStatus.equals("진행중") ? "selected" : "" %>>진행중</option>
								<option value="종료" <%= selectStatus.equals("종료") ? "selected" : "" %>>종료</option>
							</select>
						</form>
						<form action="#" method="post">
							<select name="current" id="currentSelect">
								<option value="최신">최신 순</option>
								<option value="참여금액">참여금액 순</option>
								<option value="종료임박">종료 임박 순</option>
							</select>
						</form>
					</nav>
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
              
              // 상태에 따른 li 클래스 지정 (펀딩종료)
              String ilClass = funding.getStatus().equals("종료") ? "off" : "";
          		
         	%>
         		
         		<li class="<%= ilClass %>">
              <a href="detail.jsp?num=<%= funding.getNum() %>">
                <p class="thumb">
                  <img src="./images/<%= funding.getThumb() %>.jpg" alt="<%= funding.getTitle()%>"/>
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
    <script>
	    function changeSelect(){
	    	let selectKategorie = document.querySelector('input[name="kategorie"]:checked').value;
        let selectStatus = document.querySelector('select[name="status"]').value;

        // 카테고리가 "전체"일 경우 상태에 따라 필터링된 데이터 요청
        if (selectKategorie === "전체") {
            let actionUrl = "fundings.jsp?stat=1&target=전체&status=" + selectStatus;
            document.kategorieFrm.action = actionUrl;
            document.kategorieFrm.submit();
        } else {
            let actionUrl = "fundings.jsp?stat=1&target=" + selectKategorie + "&status=" + selectStatus;
            document.kategorieFrm.action = actionUrl;
            document.kategorieFrm.submit();
        }
           
            
	    }
    </script>
  </body>
</html>
