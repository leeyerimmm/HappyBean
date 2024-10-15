<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="jMgr" class="join.joinMgr"></jsp:useBean>
<%
	request.setCharacterEncoding("UTF-8");
	String phone = request.getParameter("phone");
	String usedPhone = request.getParameter("usedPhone");
	boolean flag = jMgr.phoneCheck(phone);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일 중복체크</title>
<link rel="stylesheet" href="css/check.css">
<script>
	function use(){
		opener.document.editFrm.phone.readOnly = true;
		opener.document.editFrm.phone_Checking.value = "true";
		window.close();
	}
	
	function change(edit){
		if(edit != null){
			opener.document.editFrm.phoneBtn.textContent = "본인확인";			
		}
		opener.document.editFrm.phone.value = "";		
		opener.document.editFrm.phone.readOnly = false;
		opener.document.editFrm.phone_Checking.value = "false";
		opener.document.editFrm.phone.focus();	
		window.close();
	}
</script>
</head>
<body>
	<%
	if(phone.equals(usedPhone)){
		%>
		<div class="open_container">
			<p>사용중인 휴대폰 번호는 <strong><%= phone %></strong>입니다. <br />수정하시겠습니까?</p>
			<a href="#" onClick="change('<%= usedPhone %>')">수정</a>
			<a href="#" onClick="window.close()">닫기</a>
	    </div>
		<%
	}else{
		if(flag != true){
			%>
			<div class="open_container">
				<p><strong><%= phone %></strong> 는 사용 가능한 휴대폰 번호 입니다.</p>
				<a href="#" onClick="use()">사용하기</a>
				<a href="#" onClick="change()">변경하기</a>
		    </div>
			<%		
		}else{
			%>
			<div class="open_container">
				<p><strong><%= phone %></strong> 는 존재하는 휴대폰 번호 입니다.</p>
				<a href="#" onClick="change()">닫기</a>
		    </div>
			<%
		}
	}
	%>
</body>
</html>