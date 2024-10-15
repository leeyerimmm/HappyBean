<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  String selectStatus = request.getParameter("status") != null ? request.getParameter("status") : "전체";
  Vector<FundingBean> fundingList = fMgr.getFundingList();
  Vector<FundingBean> fundingStatusList = fMgr.getFundingListByStatus(selectStatus);  
  fMgr.updateFundingStatus();
  int ongoingCount = 0; // 진행 중인 게시물 개수
  int offgoingCount = 0; // 진행 중인 게시물 개수
   
   try {
	   
 	 	fundingList = fMgr.getFundingList(); // 상태에 따른 필터링
    
 		// 진행 중인 게시물 개수 세기
    for (FundingBean funding : fundingList) {
        if ("진행중".equals(funding.getStatus())) {
            ongoingCount++;
        }
        
        if ("종료".equals(funding.getStatus())) {
            offgoingCount++;
        }
    }
   } catch (Exception e) {
       e.printStackTrace(); 
   }
  
	 // 페이지네이션 변수
   int pageSize = 10; // 한 페이지에 보여줄 게시글 수
   int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1; // 현재 페이지
   int totalFundingCount = fundingList.size(); // 현재 상태에 따른 전체 펀딩 개수
   int totalPages = (int) Math.ceil((double) totalFundingCount / pageSize); // 총 페이지 수

   // 현재 페이지에 해당하는 펀딩 리스트 가져오기
   int startIndex = (currentPage - 1) * pageSize;
   int endIndex = Math.min(startIndex + pageSize, totalFundingCount);
   fundingList = new Vector<>(fundingList.subList(startIndex, endIndex)); // 페이지에 해당하는 리스트 생성
   
   
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" href="${pageContext.request.contextPath}/images/common/favicon.ico" type="image/x-icon" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/my/manager.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
  <title>해피빈 관리자</title>
</head>
<body>
	<jsp:include page="/views/header.jsp"/>
  <div id="wrap" class="w_max">
    <jsp:include page="/views/admin_nav.jsp"/>
    <div style="align-self: flex-start; flex-grow: 2;">
      <section id="user_activity_view_wrap">
        <h2 class="sr-only">펀딩 아이템 관리 페이지</h2>
        <div class="user_activity">
          <div class="current_bean">
            <ul class="info_list">
              <li class="list_head">
                <h3>현재 진행중인 펀딩</h3>
                <p><strong class="total_sum"><%= ongoingCount %></strong>건</p>
              </li>
              <li>
                <a href="#">
                  <p>목표금액 달성</p>
                  <p><strong class="hold_bean">0</strong>건</p>
                </a>
              </li>
              <li>
                <a href="#">
                  <p>목표금액 미달성</p>
                  <p><strong class="payment">0</strong>건</p>
                </a>
              </li>
            </ul>
          </div>
          <div class="total_donation">
            <ul class="info_list">
              <li class="list_head">
                <h3>종료된 펀딩</h3>
                <p><strong class="donation_total"><%= offgoingCount %></strong>건</p>
              </li>
              <li>
                <a href="#">
                  <p>목표금액 달성</p>
                  <p><strong class="donation_act">0</strong>건</p>
                </a>
              </li>
              <li>
                <a href="#">
                  <p>목표금액 미달성</p>
                  <p><strong class="funding_act">0</strong>건</p>
                </a>
              </li>
            </ul>
          </div>
        </div>       
      </section>
      

      <section id="item_list_wrap">
        <h2 class="funding_title">펀딩 아이템 리스트</h2>
        <div class="filter_box">
        	<form action="#" method="post" style="margin-top: 40px" name="currentFrm" onchange="changeSelect()">
		        <select name="status" id="statusSelect">
		            <option value="전체" selected>전체</option>
		            <option value="진행중" <%= selectStatus.equals("진행중") ? "selected" : "" %>>진행중</option>
		            <option value="종료" <%= selectStatus.equals("종료") ? "selected" : "" %>>종료</option>
		        </select>
		    	</form>
          <a href="./funding_write.jsp" class="funding_write writeBtn">펀딩 아이템 등록</a>
        </div>
        <form action="funding_delete.jsp" method="post">
	        <table>
	          <colgroup>
	            <td style="width: 5%;"></td>
	            <td style="width: 10%;"></td>
	            <td style="width: 40%;"></td>
	            <td style="width: 15%;"></td>
	            <td style="width: 10%;"></td>
	            <td style="width: 20%;"></td>
	          </colgroup>
	          
	          <tr class="table_header">
	            <th scope="row">
	              <input type="checkbox" name="selectAll">
	            </th>
	            <th>진행상황</th>
	            <th>제목</th>
	            <th>모금된 금액</th>
	            <th>진행률</th>
	            <th>아아템 관리</th>
	          </tr>
	          <%
	          SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        	Date today = new Date();
	        	
	        	NumberFormat nFormat = NumberFormat.getInstance(Locale.KOREA);
	        	
	        	for(FundingBean funding : fundingStatusList) {  
	        		Date endDate = sdf.parse(funding.getEnd_date());
	        		long diff = endDate.getTime() - today.getTime();
	        		long dDay = diff / (1000 * 60 * 60 * 24);
	        		
	        		// 진행률 환산
	        		long goalAmount = funding.getGoal_amount() != null ? Long.parseLong(funding.getGoal_amount()) : 0; 
							long rasedAmount = funding.getRased_amount() != null ? Long.parseLong(funding.getRased_amount()) : 0;
							double progressPercentage = goalAmount > 0 ? Math.round((double) rasedAmount / goalAmount * 100) : 0;
	          %>
	          <tr>
	            <td><input type="checkbox" name="select" value="<%= funding.getNum() %>"></td>
	            <td>
	            <%
	            	if(funding.getStatus().equals("진행중")){
	            		%>
	            		<p class="status on"><%= funding.getStatus() %></p>	            		
	            		<%
	            	}else {
	            		%>
	            		<p class="status off"><%= funding.getStatus() %></p>
	            		
	            		<%
	            	}
	            
	            %>            
	            
	            </td>
	            <td><a href="${pageContext.request.contextPath}/sub/funding/detail.jsp?num=<%= funding.getNum() %>"><%= funding.getTitle() %></a></td>
	            <td><%= nFormat.format(Long.parseLong(funding.getRased_amount())) %></td>
	            <td><%= (int)progressPercentage + "%" %></td>
	            <td>
	              <a href="funding_edit.jsp?num=<%= funding.getNum() %>" class="btn edit">수정</a>
	              <form action="funding_delete.jsp" method="post" style="display: inline;"/>
	              	<input type="hidden" name="select" value="<%= funding.getNum() %>">
                  <button type="submit" class="btn delete" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
	              </form>
	            </td>
	          </tr>
	          <% } %>
	        </table>    
				  <button type="submit" class="deleteBtn" onclick="return confirm('정말 삭제하시겠습니까?');">선택 삭제</button>
	        

	        <nav class="page_index_wrap">
				    <a href="?page=<%= currentPage - 1 %>" class="pagePrev" <%= currentPage == 1 ? "style='display:none;'" : "" %>></a>
				    <ul class="page_index" style="justify-content:center;">
				    <%
				        for (int i = 1; i <= totalPages; i++) {
				            if (i == currentPage) {
				    %>
				                <li class="current"><a href="?page=<%= i %>"><%= i %></a></li>
				    <%
				            } else {
				    %>
				                <li><a href="?page=<%= i %>"><%= i %></a></li>
				    <%
				            }
				        }
				    %>
				    </ul>
				    <a href="?page=<%= currentPage + 1 %>" class="pageNext" <%= currentPage == totalPages ? "style='display:none;'" : "" %>>다음</a>
				</nav>
      	</form>
      </section>
    </div>    
  </div>
  <jsp:include page="/views/footer.jsp"/>
  <script>
	  function changeSelect(){
	      let selectStatus = document.querySelector('select[name="status"]').value;
	      let actionUrl = "manager_funding.jsp?status=" + selectStatus; 
	      document.currentFrm.action = actionUrl;
	      document.currentFrm.submit();
	  }
  </script>
</body>
</html>