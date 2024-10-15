<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="Controls.FundingMgr" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
    String[] fundingIds = request.getParameterValues("select");

    FundingMgr fundingMgr = new FundingMgr();
    int deletedCount = 0; 

    if (fundingIds != null) {
        int[] nums = new int[fundingIds.length];
        for (int i = 0; i < fundingIds.length; i++) {
            nums[i] = Integer.parseInt(fundingIds[i]);
        }

        fundingMgr.deleteFunding(nums); 
        deletedCount = nums.length; 
    }

%>

<script>
    // 삭제된 개수를 알리는 alert 창
    var deletedCount = <%= deletedCount %>;
    if (deletedCount > 0) {
        alert(deletedCount + '개의 펀딩이 삭제되었습니다.');
        // 확인 버튼 클릭 시 manager_funding.jsp로 이동
        window.location.href = 'manager_funding.jsp';
    } else {
        alert('삭제할 펀딩을 선택해 주세요.');
        window.location.href = 'manager_funding.jsp';
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