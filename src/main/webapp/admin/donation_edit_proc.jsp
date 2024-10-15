<%@ page import="java.sql.*, donation.DonationMgr, donation.DonationBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="dMgr" class="donation.DonationMgr" />
<jsp:useBean id="Bean" class="donation.DonationBean" />

<%
    request.setCharacterEncoding("UTF-8");

    // 폼에서 전달된 데이터 수집
    int num = Integer.parseInt(request.getParameter("num"));
    String category = request.getParameter("category");
    String status = request.getParameter("status");
    String title = request.getParameter("title");
    String thumb = request.getParameter("thumb");
    String subImages = request.getParameter("sub_images");
    String company = request.getParameter("company");
    String startDateString = request.getParameter("startDate");
    String endDateString = request.getParameter("endDate");
    int goalAmount = Integer.parseInt(request.getParameter("goal_amount"));
    String projectDuration = request.getParameter("project_duration");
    String targetGroup = request.getParameter("target_group");
    int targetCount = Integer.parseInt(request.getParameter("target_count"));
    String costDetails = request.getParameter("cost_details");
    String costDescriptions = request.getParameter("cost_descriptions");
    String costAmounts = request.getParameter("cost_amounts");
    String expectedEffect = request.getParameter("expected_effect");
    String description = request.getParameter("description");

    // 날짜 변환
    java.sql.Date startDate = java.sql.Date.valueOf(startDateString);
    java.sql.Date endDate = java.sql.Date.valueOf(endDateString);

    // 수정된 값을 Bean에 설정
    Bean.setId(num);
    Bean.setCategory(category);
    Bean.setStatus(status);
    Bean.setTitle(title);
    Bean.setThumb(thumb);
    Bean.setSubImages(subImages);
    Bean.setCompany(company);
    Bean.setStartDate(startDate);
    Bean.setEndDate(endDate);
    Bean.setGoalAmount(goalAmount);
    Bean.setProjectDuration(projectDuration);
    Bean.setTargetGroup(targetGroup);
    Bean.setTargetCount(targetCount);
    Bean.setCostDetails(costDetails);
    Bean.setCostDescriptions(costDescriptions);
    Bean.setCostAmounts(costAmounts);
    Bean.setExpectedEffect(expectedEffect);
    Bean.setDescription(description);

    // 데이터베이스에 업데이트
    boolean isSuccess = dMgr.updateDonation(Bean);

    // 결과에 따른 메시지와 이동할 URL 설정
    String msg, url;
    if (isSuccess) {
        msg = "기부 아이템이 성공적으로 수정되었습니다.";
        url = "manager_donation.jsp";  // 수정 완료 후 이동할 페이지
    } else {
        msg = "기부 아이템 수정에 실패했습니다.";
        url = "donation_edit.jsp?num=" + num;  // 수정 실패 시 다시 편집 페이지로 이동
    }
%>

<script>
    alert('<%= msg %>');
    location.href = '<%= url %>';
</script>
