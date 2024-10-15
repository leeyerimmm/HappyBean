<%@ page import="java.sql.*, donation.DonationMgr" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="dMgr" class="donation.DonationMgr" />

<%
    request.setCharacterEncoding("UTF-8");

    String selectParam = request.getParameter("select");

    if (selectParam == null || selectParam.isEmpty()) {
        out.println("삭제할 기부 항목의 ID가 제공되지 않았습니다.");
        return;
    }

    int donationId = Integer.parseInt(selectParam);

    boolean isDeleted = dMgr.deleteDonation(donationId);

    String msg, url;
    if (isDeleted) {
        msg = "기부 항목이 성공적으로 삭제되었습니다.";
        url = "manager_donation.jsp"; 
    } else {
        msg = "기부 항목 삭제에 실패했습니다.";
        url = "manager_donation.jsp"; 
    }
%>

<script>
    alert('<%= msg %>');
    location.href = '<%= url %>';
</script>

