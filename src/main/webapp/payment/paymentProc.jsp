<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="donation.DonationMgr, donation.DonationBean" %>

<%
	request.setCharacterEncoding("UTF-8");
	int payment = Integer.parseInt(request.getParameter("payBean"));
	int subnum = Integer.parseInt(request.getParameter("subnum")); 
	String donation_type = request.getParameter("donation_type");
	String user_id = (String)session.getAttribute("idKey");
%>
<jsp:useBean id="jMgr" class="join.joinMgr" />
<jsp:useBean id="dMgr" class="donation.DonationMgr" />
<%
	boolean flag = jMgr.paymentAmount(subnum, user_id, payment, donation_type);
	int raisedAmount = dMgr.raisedAmount(subnum, donation_type);
	DonationBean donation = new DonationBean();
	donation = dMgr.getDonationById(subnum);
	if(raisedAmount != 0 && flag){
		dMgr.raisedAmount(subnum, donation_type);
		dMgr.updateDonation(donation);
		%>
		<script>
			alert("정상적으로 기부되었습니다.");
			location.href="../my/user_info.jsp";
		</script>
		<%
	}else{
		%>
		<script>
			alert("기부되지 않았습니다. 다시 시도해 주세요.");
			history.back();
		</script>
		<%
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