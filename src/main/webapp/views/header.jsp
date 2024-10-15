<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
	String user_id = (String)session.getAttribute("idKey");
  String serverName = request.getServerName(); // 호스트 이름 (localhost)
  int serverPort = request.getServerPort(); // 포트 번호
  String scheme = request.getScheme(); // 프로토콜 (http 또는 https)
	String contextPath = request.getContextPath();

  String fullUrl = scheme + "://" + serverName + ":" + serverPort + contextPath;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
</head>
<body>
    <header id="header_wrap">
      <div class="w_max">
        <h1 class="logo">
          <a href="<%= fullUrl %>/index.jsp">
          	<img src="<%= fullUrl %>/images/common/logo_kr.svg" alt="해피빈"/>
          </a>
        </h1>
        <nav>
          <ul id="gnb">
            <li>
              <a href="<%= fullUrl %>/sub/donation/donation.jsp">
                <span>기부</span>
              </a>
            </li>
            <li>
              <a href="<%= fullUrl %>/sub/fundrasing/fundrasing.jsp">
                <span>모금함</span>
              </a>
            </li>
            <li>
              <a href="<%= fullUrl %>/sub/funding/fundings.jsp">
                <span>펀딩</span>
              </a>
            </li>
            <li>
              <a href="<%= fullUrl %>/sub/campaign/campaigns.jsp">
                <span>캠페인</span>
              </a>
            </li>
            <li>
              <a href="<%= fullUrl %>/sub/notice/list.jsp">
                <span>공지사항</span>
              </a>
            </li>
          </ul>
        </nav>
        <div class="btn_container">
       		<%
       		try{
    	        if(user_id != null){
    	        	%>
    	        	<a href="<%= fullUrl %>/my/user_info.jsp"><span>내정보</span></a>&nbsp;&nbsp;
    	       		<a href="<%= fullUrl %>/join/log_outProc.jsp"><span>로그아웃</span></a>
    	       		<%
    	       	}else{
    	       		%>
    	       		<a href="<%= fullUrl %>/join/log_in.jsp" id="login_btn"><span>로그인</span></a>
    	       		<%
    	       	}
       		}catch(Exception e){
       			%>
        		<script>
	    			alert("잘못된 접근입니다.");
	    			location.href="./index.jsp";
    			</script>
    			<%
       		}

	        %>
          <div id="search">
            <span class="sr-only">검색</span>
          </div>
        </div>
      </div>
    </header>
</body>
</html>