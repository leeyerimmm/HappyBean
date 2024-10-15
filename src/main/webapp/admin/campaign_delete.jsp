<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="Controls.CampaignMgr" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
    String[] campaignIds = request.getParameterValues("select");

    CampaignMgr campaignMgr = new CampaignMgr();
    int deletedCount = 0; 

    if (campaignIds != null) {
        int[] nums = new int[campaignIds.length];
        for (int i = 0; i < campaignIds.length; i++) {
            nums[i] = Integer.parseInt(campaignIds[i]);
        }

        campaignMgr.deleteCampaign(nums); 
        deletedCount = nums.length; 
    }

%>

<script>
    // 삭제된 개수를 알리는 alert 창
    var deletedCount = <%= deletedCount %>;
    if (deletedCount > 0) {
        alert(deletedCount + '개의 캠페인이 삭제되었습니다.');
        // 확인 버튼 클릭 시 manager_funding.jsp로 이동
        window.location.href = 'manager_campaign.jsp';
    } else {
        alert('삭제할 캠페인을 선택해 주세요.');
        window.location.href = 'manager_campaign.jsp';
    }
</script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>