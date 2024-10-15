<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="board.BoardBean"%>
<jsp:useBean id="bMgr" class="board.BoardMgr" />
<%
// 데이터베이스에서 게시물 정보 불러오기
request.setCharacterEncoding("UTF-8");

String idParam = request.getParameter("id");
int id = 0;
try {
	if (idParam != null) {
		id = Integer.parseInt(idParam); // 파라미터로 전달된 id 값을 정수로 변환
	}
} catch (NumberFormatException e) {
	System.out.println("Invalid id format: " + idParam); // 에러 로그 출력
}

BoardBean bean = bMgr.getBoard(id); // 게시물 ID로 데이터 가져오기
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/reset.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/sub/notice/read.css?v=<%=System.currentTimeMillis()%>" />
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico"
	type="image/x-icon" />
<title>해피빈: 공지사항</title>
</head>
<body>
<jsp:include page="/views/header.jsp" />
	<header>
		
	</header>

	<div id="wrap">
		<section class="w_max">
			<h2>공지 사항</h2>
			<ul>
				<li><strong><%=bean != null ? bean.getTitle() : "제목 정보 없음"%></strong>
					<p>
						작성일:
						<%=bean != null ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(bean.getCreatedAt()) : "등록일 정보 없음"%></p>
				</li>
			</ul>
			<div class="main">
				<%=bean != null ? bean.getContent() : "내용 정보 없음"%>
			</div>
			<p>
				<a href="./list.jsp" class="button">목록</a>
			</p>

		</section>
	
<jsp:include page="/views/footer.jsp" />
</body>
</html>
