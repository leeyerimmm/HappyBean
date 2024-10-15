<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="jMgr" class="Controls.joinMgr"></jsp:useBean>
<%
	request.setCharacterEncoding("UTF-8");
	String email = request.getParameter("email");
	boolean flag = jMgr.emailCheck(email);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일 중복체크</title>
<link rel="stylesheet" href="css/check.css">
<script>
	function use(){
		opener.document.joinFrm.email.readOnly = true;
		opener.document.joinFrm.email_Checking.value = "true";
		window.close();
	}
	
	function change(){
		opener.document.joinFrm.email.value = "";			
		opener.document.joinFrm.email.readOnly = false;
		opener.document.joinFrm.email_Checking.value = "false";
		opener.document.joinFrm.email.focus();	
		window.close();
	}
</script>
</head>
<body>
	<%
	if(flag != true){
		%>
		<div class="open_container">
			<p><strong><%= email %></strong> 는 사용 가능한 E-mail 입니다.</p>
			<a href="#" onClick="use()">사용하기</a>
			<a href="#" onClick="change()">변경하기</a>
	    </div>
		<%		
	}else{
		%>
		<div class="open_container">
			<p><strong><%= email %></strong> 는 존재하는 E-mail 입니다.</p>
			<a href="#" onClick="change()">닫기</a>
	    </div>
		<%
	}
	%>
</body>
</html>