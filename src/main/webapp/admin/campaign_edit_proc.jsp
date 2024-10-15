<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Controls.CampaignMgr" %>
<%@ page import="Controls.CampaignBean" %>
<%
    request.setCharacterEncoding("utf-8");
    CampaignMgr campaignMgr = new CampaignMgr();
    CampaignBean campaign = new CampaignBean();

    try {
        // 폼에서 전달받은 데이터
        campaign.setNum(Integer.parseInt(request.getParameter("num")));
        campaign.setStatus(request.getParameter("status"));
        campaign.setTitle(request.getParameter("title"));
        campaign.setHash_tag(request.getParameter("hash_tag"));
        campaign.setThumb(request.getParameter("thumb"));
        campaign.setStart_date(request.getParameter("start_date"));
        campaign.setEnd_date(request.getParameter("end_date"));
        campaign.setDescription(request.getParameter("description"));
        

        // 데이터베이스 업데이트
        boolean result = campaignMgr.updateCampaign(campaign);

        if (result) {
            out.println("<script>alert('수정 완료!'); location.href='manager_campaign.jsp';</script>");
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