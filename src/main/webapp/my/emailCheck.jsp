<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="jMgr" class="join.joinMgr"></jsp:useBean>
<%
	request.setCharacterEncoding("UTF-8");
	String email = request.getParameter("email");
	String usedEmail = request.getParameter("usedEmail");
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
		opener.document.editFrm.email.readOnly = true;
		opener.document.editFrm.email_Checking.value = "true";
		window.close();
	}
	
	function change(edit){
		if(edit != null){
			opener.document.editFrm.emailBtn.textContent = "중복확인";			
		}
		opener.document.editFrm.email.value = "";		
		opener.document.editFrm.email.readOnly = false;
		opener.document.editFrm.email_Checking.value = "false";
		opener.document.editFrm.email.focus();	
		window.close();
	}
</script>
</head>
<body>
	<%
	if(email.equals(usedEmail)){
		%>
		<div class="open_container">
			<p>사용중인 E-mail은 <strong><%= email %></strong>입니다. <br />수정하시겠습니까?</p>
			<a href="#" onClick="change('<%= usedEmail %>')">수정</a>
			<a href="#" onClick="window.close()">닫기</a>
	    </div>
		<%
	}else{
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
	}
	%>
</body>
</html>