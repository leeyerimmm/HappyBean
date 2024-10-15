<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Controls.FundingMgr" %>
<%@ page import="Controls.FundingBean" %>
<%
    request.setCharacterEncoding("utf-8");
    FundingMgr fundingMgr = new FundingMgr();
    FundingBean funding = new FundingBean();

    try {
        // 폼에서 전달받은 데이터
        funding.setNum(Integer.parseInt(request.getParameter("num"))); // num 값 설정
        funding.setKategotie(request.getParameter("kategotie"));
        funding.setStatus(request.getParameter("status"));
        funding.setTitle(request.getParameter("title"));
        funding.setThumb(request.getParameter("thumb"));
        funding.setCompany(request.getParameter("company"));
        funding.setSlogan(request.getParameter("slogan"));
        funding.setOption(request.getParameter("option"));
        funding.setDelivery_amount(request.getParameter("delivery_amount"));
        funding.setDelivery_free(request.getParameter("delivery_free"));
        funding.setStart_date(request.getParameter("start_date"));
        funding.setEnd_date(request.getParameter("end_date"));
        funding.setGoal_amount(request.getParameter("goal_amount"));
        funding.setDescription(request.getParameter("description"));
        
  

        // 데이터베이스 업데이트
        boolean result = fundingMgr.updateFunding(funding);

        if (result) {
            out.println("<script>alert('수정 완료!'); location.href='manager_funding.jsp';</script>");
        } else {
            out.println("<script>alert('수정 실패!'); history.back();</script>");
        }
    } catch (Exception e) {
        e.printStackTrace(); // 자세한 에러 메시지 출력
        out.println("<script>alert('에러 발생: " + e.getMessage() + "'); history.back();</script>");
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>