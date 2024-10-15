<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="jMgr" class="join.joinMgr"></jsp:useBean>
<jsp:useBean id="jBean" class="join.joinBean"></jsp:useBean>
<jsp:setProperty property="*" name="jBean"/>
<%
	jBean.setUser_id((String)session.getAttribute("idKey"));
	boolean flag = jMgr.editUser(jBean);
	if(flag){
		%>
		<script>
			alert("회원 정보를 수정 했습니다.");
			location.href = "user_info.jsp";
		</script>
		<%
	}else{
		%>
		<script>
			alert("회원 정보 수정에 실패 했습니다.");
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