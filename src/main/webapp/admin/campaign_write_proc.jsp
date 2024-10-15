<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="cMgr" class="Controls.CampaignMgr"/>
<jsp:useBean id="Bean" class="Controls.CampaignBean"/>
<jsp:setProperty property="*" name="Bean" />
<%
	request.setCharacterEncoding("UTF-8");

boolean flag = cMgr.insertCampaign(Bean);
String msg = null, url = null;

if(flag){
	msg = "켐페인이 등록되었습니다.";
	url = "manager_campaign.jsp";
}else{
	msg="켐페인 등록에 실패했습니다.";
	url = "campaign_write.jsp";
}
%>

<script>
	alert('<%=msg%>');
	location.href='<%=url%>';
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