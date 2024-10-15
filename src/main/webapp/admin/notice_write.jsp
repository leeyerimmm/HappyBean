<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title>해피빈 관리자 : 공지 등록</title>
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
				<h2 class="notice_title">공지 등록</h2>
				<form action="notice_write_proc.jsp" method="post"
					autocomplete="off" accept-charset="utf-8">
					<input type="hidden" name="date" value="" />
					<table class="write" style="width: 100%;">
						<colgroup>
						<td style="width: 15%"></td>
						<td style="width: 35%"></td>
						<td style="width: 15%"></td>
						<td style="width: 35%"></td>
						</colgroup>
						<tr>
							<th>제목</th>
							<td colspan="3"><input type="text" name="title" id="title"
								required /></td>
						</tr>
						<tr>
							<td colspan="4" style="height: 500px;"><input type="text"
								name="description" id="description"
								style="width: 100%; height: 500px;" required /></td>
						</tr>
					</table>
					<div class="btn_box">
						<button type="submit">작성완료</button>
						<button type="reset">재 작성</button>
						<button type="button" value="리스트"
							onClick="javascript:location.href='manager_notice.jsp'">리스트</button>
					</div>
				</form>
		</div>
	</div>
	
	<jsp:include page="/views/footer.jsp" />
	<script>
		/*
		 ClassicEditor
		 .create(document.querySelector('#description'))
		 .catch(error => {
		 console.error(error);
		 });
		 function resetForm() {
		 const editorInstance = document.querySelector('#description').editor;
		 if (editorInstance) {
		 editorInstance.setData(''); // CKEditor 내용 초기화
		 }
		 document.getElementById('title').value = ''; // 제목 초기화
		 document.querySelector('form').reset(); // 나머지 폼 필드 초기화
		 }*/
	</script>
</body>
</html>