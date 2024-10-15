<%@ page import="java.sql.*, donation.DonationMgr, donation.DonationBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="dMgr" class="donation.DonationMgr" />
<jsp:useBean id="Bean" class="donation.DonationBean" />

<%
    request.setCharacterEncoding("UTF-8");

    // 폼 데이터 수동으로 받아오기
    String title = request.getParameter("title");
    String description = request.getParameter("description");
    String company = request.getParameter("company");
    String thumb = request.getParameter("thumb");
    String category = request.getParameter("category");
    int goalAmount = Integer.parseInt(request.getParameter("goal_amount"));
    String status = request.getParameter("status");
    String subImages = request.getParameter("sub_images");
    String costDetails = request.getParameter("cost_details");
    String costDescriptions = request.getParameter("cost_descriptions");
    String costAmounts = request.getParameter("cost_amounts");
    String projectDuration = request.getParameter("project_duration");
    String targetGroup = request.getParameter("target_group");
    String expectedEffect = request.getParameter("expected_effect");

    // 날짜는 수동으로 변환
    String startDateString = request.getParameter("startDate");
    String endDateString = request.getParameter("endDate");

    java.sql.Date startDate = null;
    java.sql.Date endDate = null;
    try {
        startDate = java.sql.Date.valueOf(startDateString);
        endDate = java.sql.Date.valueOf(endDateString);
    } catch (IllegalArgumentException e) {
        out.println("날짜 형식이 잘못되었습니다. (yyyy-MM-dd 형식으로 입력해 주세요)");
        e.printStackTrace();
    }

    // Bean 객체에 값 설정
    Bean.setTitle(title);
    Bean.setDescription(description);
    Bean.setCompany(company);
    Bean.setThumb(thumb);
    Bean.setCategory(category);
    Bean.setGoalAmount(goalAmount);
    Bean.setStatus(status);
    Bean.setSubImages(subImages);
    Bean.setCostDetails(costDetails);
    Bean.setCostDescriptions(costDescriptions);
    Bean.setCostAmounts(costAmounts);
    Bean.setProjectDuration(projectDuration);
    Bean.setTargetGroup(targetGroup);
    Bean.setExpectedEffect(expectedEffect);
    Bean.setStartDate(startDate);
    Bean.setEndDate(endDate);

    // 데이터베이스에 삽입
    boolean isSuccess = dMgr.insertDonation(Bean);

    // 결과에 따라 메시지와 이동할 URL 설정
    String msg, url;
    if (isSuccess) {
        msg = "기부 아이템이 성공적으로 등록되었습니다.";
        url = "manager_donation.jsp";  // 등록 완료 후 이동할 페이지
    } else {
        msg = "기부 아이템 등록에 실패했습니다.";
        url = "donation_write.jsp";  // 다시 작성 페이지로 이동
    }
%>

<script>
    alert('<%= msg %>');
    location.href = '<%= url %>';
</script>
