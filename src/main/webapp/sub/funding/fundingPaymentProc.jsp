<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="jMgr" class="join.joinMgr"/>
<jsp:useBean id="dMgr" class="donation.DonationMgr"/>
<%
	String user_id = (String)session.getAttribute("idKey");
	int amount_held = Integer.parseInt(request.getParameter("amount_held"));
	int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));
	int num = Integer.parseInt(request.getParameter("num"));
	String selectedOptions = request.getParameter("selectedOptions");
	String donation_type = "펀딩";
	out.println(user_id);
	out.println(amount_held);
	out.println(num);
	out.println(totalPrice);
	out.println(selectedOptions);
	boolean flag = jMgr.paymentAmount(num, user_id, totalPrice, donation_type);
	int raisedAmount = dMgr.raisedAmount(num, donation_type);
	if(raisedAmount != 0 && flag){
		%>
		<script>
			alert("정상적으로 펀딩 되었습니다.");
			location.href="./fundings.jsp";
		</script>
		<%
	}else{
		%>
		<script>
			alert("펀딩에 실패했습니다.");
			location.href="/fundings.jsp";
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