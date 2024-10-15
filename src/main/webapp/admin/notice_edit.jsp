<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="board.BoardBean"%>
<%@ page import="board.BoardMgr"%>
<%
request.setCharacterEncoding("UTF-8");

int id = Integer.parseInt(request.getParameter("id")); // 수정할 게시글 ID
BoardMgr bMgr = new BoardMgr();
BoardBean bean = bMgr.getBoard(id); // 게시물 정보 가져오기
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="icon"
	href="${pageContext.request.contextPath}/images/common/favicon.ico"
	type="image/x-icon" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/my/manager.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reset.css" />
<script
	src="https://cdn.ckeditor.com/ckeditor5/29.1.0/classic/ckeditor.js"></script>
<title>해피빈 관리자 : 공지 수정</title>
<style>
.ck.ck-editor {
	max-width: 100%;
}

.ck-editor__editable {
	min-height: 500px;
}
</style>
</head>
<body>
	<jsp:include page="/views/header.jsp" />
	<div id="wrap" class="w_max">
		<jsp:include page="/views/admin_nav.jsp" />
		<div style="align-self: flex-start; flex-grow: 2">
			<section id="item_write_wrap">
				<h2 class="notice_title">공지 수정</h2>
				<form action="notice_update_action.jsp
				" method="post"
					autocomplete="off" accept-charset="utf-8">

					<%
					if (bean != null) {
					%>
					<input type="hidden" name="id" value="<%=bean.getId()%>" />
					<%
					} else {
					out.println("공지사항을 불러오는 중 오류가 발생했습니다.");
					}
					%>
					<!-- Notice ID hidden field for updating -->
					<table class="write" style="width: 100%;">
						<colgroup>
						<td style="width: 15%"></td>
						<td style="width: 35%"></td>
						<td style="width: 15%"></td>
						<td style="width: 35%"></td>
						</colgroup>
						<tr>
							<th>제목</th>
							<td colspan="3">
								<%
								if (bean != null) {
								%> <input type="text" name="title" id="title"
								value="<%=bean.getTitle()%>" required /> <%
 } else {
 out.println("공지사항을 불러오는 중 오류가 발생했습니다.");
 }
 %>
							</td>
						</tr>
						<tr>
							<td colspan="4" style="height: 500px;"><input type="text"
								name="description" id="description"
								style="width: 100%; height: 500px;"
								value="<%=bean.getContent()%>" required /></td>
						</tr>
					</table>
					<div class="btn_box">
						<button type="submit">수정 완료</button>
						<button type="button" onclick="history.back();">취소</button>
					</div>
				</form>
			</section>
		</div>
	</div>
	<jsp:include page="/views/footer.jsp" />
	<script>
		/*// Optional: Use CKEditor if necessary
		ClassicEditor
		    .create(document.querySelector('#description'))
		    .catch(error => {
		        console.error(error);
		    });*/
	</script>
</body>
</html>
