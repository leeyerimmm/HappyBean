<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="fMgr" class="Controls.FundingMgr"/>
<jsp:useBean id="Bean" class="Controls.FundingBean"/>
<jsp:setProperty property="*" name="Bean" />
<%
boolean flag = fMgr.insertFunding(Bean);
String msg = null, url = null;

if(flag){
	msg = "펀딩 상품이 등록되었습니다.";
	url = "manager_funding.jsp";
}else{
	msg="펀딩 상품 등록에 실패했습니다.";
	url = "funding_write.jsp";
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