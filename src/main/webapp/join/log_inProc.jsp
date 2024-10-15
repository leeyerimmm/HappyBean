<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="jMgr" class="Controls.joinMgr"></jsp:useBean>
<%
	String user_id = request.getParameter("user_id");
	String pwd = request.getParameter("pwd");
	boolean flag = jMgr.login(user_id, pwd);
	if(flag){
		%>
		<script>
			alert("로그인 되었습니다.");
		</script>
		<%
		session.setAttribute("idKey", user_id);
		response.sendRedirect("../index.jsp");
	} else{
		%>
		<script>
			alert("아이디 또는 비밀번호를 확인해 주세요.");
			location.href="log_in.jsp";
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
	log_inProc
</body>
</html>