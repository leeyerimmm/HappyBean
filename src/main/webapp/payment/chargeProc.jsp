<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	int charge = Integer.parseInt(request.getParameter("payBean"));
	String user_id = (String)session.getAttribute("idKey");
	//int amount_held = Integer.parseInt(request.getParameter("amount_held"));
%>
<jsp:useBean id="jMgr" class="join.joinMgr"></jsp:useBean>
<%
	boolean flag = jMgr.chargeAmount(user_id, charge);
	if(flag){
		%>
		<script>
			alert("정상적으로 충전되었습니다.");
			location.href="../my/user_info.jsp";
		</script>
		<%
	}else{
		%>
		<script>
			alert("충전되지 않았습니다. 다시 시도해 주세요.");
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