<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="jMgr" class="Controls.joinMgr"></jsp:useBean>
<jsp:useBean id="jBean" class="Controls.joinBean"></jsp:useBean>
<jsp:setProperty property="*" name="jBean"/>
<%
	boolean flag = jMgr.insertUser(jBean);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>joinProc.jsp</title>
</head>
<body>
	<%
	if(flag){
		%>
		<script>
		alert("회원가입을 성공적으로 마쳤습니다.");
		location.href="../index.jsp";
		</script>
		<%
	}else{
		%>
		<script>
		alert("회원가입에 실패했습니다.");
		location.href="join.jsp";
		</script>
		<%		
	}
	%>
</body>
</html>