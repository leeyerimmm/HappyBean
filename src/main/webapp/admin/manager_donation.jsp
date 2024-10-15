<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.List" %>
<%@ page import="donation.*" %>
<jsp:useBean id="dMgr" class="donation.DonationMgr" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" href="${pageContext.request.contextPath}/images/common/favicon.ico" type="image/x-icon" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/my/manager.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
  <title>해피빈 관리자 : 기부 아이템 관리</title>
</head>
<style>

.table_header th {
  padding: 15px 0;
  border-bottom: 1px solid #ddd;
}

</style>
<body>
	<jsp:include page="/views/header.jsp"/>
 <div id="wrap" class="w_max">
        <jsp:include page="/views/admin_nav.jsp"/>
        <div style="align-self: flex-start; flex-grow: 2">
        <section id="user_activity_view_wrap">
            <h2 class="sr-only">펀딩 아이템 관리 페이지</h2>
            <div class="user_activity">
                <div class="current_bean">
                    <ul class="info_list">
                        <li class="list_head">
                            <h3>현재 진행중인 기부</h3>
                            <p><strong class="total_sum"><%= dMgr.getOngoingDonationCount() %></strong>건</p>
                        </li>
                        <li>
                            <a href="#">
                                <p>목표금액 달성</p>
                                <p><strong class="hold_bean"><%= dMgr.getAchievedOngoingDonationCount() %></strong>건</p>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <p>목표금액 미달성</p>
                                <p><strong class="payment"><%= dMgr.getNotAchievedOngoingDonationCount() %></strong>건</p>
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="total_donation">
                    <ul class="info_list">
                        <li class="list_head">
                            <h3>종료된 기부</h3>
                            <p><strong class="donation_total"><%= dMgr.getCompletedDonationCount() %></strong>건</p>
                        </li>
                        <li>
                            <a href="#">
                                <p>목표금액 달성</p>
                                <p><strong class="donation_act"><%= dMgr.getAchievedCompletedDonationCount() %></strong>건</p>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <p>목표금액 미달성</p>
                                <p><strong class="funding_act"><%= dMgr.getNotAchievedCompletedDonationCount() %></strong>건</p>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </section>
<section id="item_list_wrap">
    <h2 class="donation_title">기부 아이템 리스트</h2>
    <div class="filter_box">
        <select name="status_option" id="status_option">
            <option value="all" <%= "all".equals(request.getParameter("status_option")) ? "selected" : "" %>>전체</option>
            <option value="1" <%= "1".equals(request.getParameter("status_option")) ? "selected" : "" %>>진행중</option>
            <option value="2" <%= "2".equals(request.getParameter("status_option")) ? "selected" : "" %>>종료됨</option>
        </select>
        <a href="./donation_write.jsp" class="funding_write writeBtn">기부 아이템 등록</a>
    </div>

    <form action="donation_delete.jsp" method="post">
        <table>
			<colgroup>
			  <col style="width: 5%;">
			  <col style="width: 10%;">
			  <col style="width: 40%;">
			  <col style="width: 15%;">
			  <col style="width: 10%;">
			  <col style="width: 20%;">
			</colgroup>


            <tr class="table_header">
                <th scope="row">
                    <input type="checkbox" name="selectAll" id="selectAll">
                </th>
                <th>진행상황</th>
                <th>제목</th>
                <th>모금된 금액</th>
                <th>진행률</th>
                <th>아이템 관리</th>
            </tr>

            <%
                String statusOption = request.getParameter("status_option");
                if (statusOption == null) statusOption = "all";  // 기본값은 '전체'

                List<DonationBean> donations = dMgr.getAllDonations();
                for (DonationBean donation : donations) {
                    boolean showRow = false;

                    if ("all".equals(statusOption)) {
                        showRow = true;
                    } else if ("1".equals(statusOption) && "진행중".equals(donation.getStatus())) {
                        showRow = true;
                    } else if ("2".equals(statusOption) && "종료됨".equals(donation.getStatus())) {
                        showRow = true;
                    }

                    if (showRow) {
                        int progressRate = (int) ((donation.getRaisedAmount() / (double) donation.getGoalAmount()) * 100);
            %>
            <tr>
                <td><input type="checkbox" name="select" value="<%= donation.getId() %>"></td>
                <td>
                    <p class="status <%= "진행중".equals(donation.getStatus()) ? "on" : "off" %>">
                        <%= donation.getStatus() %>
                    </p>
                </td>
                <td><a href="../sub/fundrasing/sub/fundrasing_sub1.jsp?subnum=<%= donation.getId() %>&donation_type=기부종류"> <%= donation.getTitle() %></a></td>
                <td><%= donation.getRaisedAmount() %></td>
                <td><%= progressRate %>%</td>
                <td>
                    <a href="donation_edit.jsp?num=<%= donation.getId() %>" class="btn edit">수정</a>
                    <form action="donation_delete.jsp" method="post" style="display:inline;">
                        <input type="hidden" name="select" value="<%= donation.getId() %>">
                        <button class="btn delete" type="submit" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                } // for 종료
            %>
        </table>

        <nav class="page_index_wrap">
            <button type="submit" class="deleteBtn" onclick="return confirm('정말 삭제하시겠습니까?');">선택 삭제</button>
            <button type="button" class="pagePrev"><</button>
            <ul class="page_index">
                <li class="currnet"><a href="#">1</a></li>
                <li><a href="#">2</a></li>
                <li><a href="#">3</a></li>
                <li><a href="#">4</a></li>
                <li><a href="#">5</a></li>
                <li><a href="#">6</a></li>
                <li><a href="#">7</a></li>
                <li><a href="#">8</a></li>
                <li><a href="#">9</a></li>
                <li><a href="#">10</a></li>
            </ul>
            <button type="button" class="pageNext">></button>   
        </nav>
    </form>
</section>

<script>
document.getElementById('selectAll').addEventListener('change', function() {
	 const checkboxes = document.querySelectorAll('input[name="select"]');
    checkboxes.forEach(function(checkbox) {
        checkbox.checked = document.getElementById('selectAll').checked;
    });
});

document.getElementById('status_option').addEventListener('change', function() {
	 const status = this.value;
	 const currentUrl = window.location.href.split('?')[0];
    window.location.href = currentUrl + "?status_option=" + status;
});
</script>


    </div>    
  </div>
  <jsp:include page="/views/footer.jsp"/>
</body>
</html>