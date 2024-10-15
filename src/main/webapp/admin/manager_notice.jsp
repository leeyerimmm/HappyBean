<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.Vector"%>
<jsp:useBean id="bMgr" class="board.BoardMgr" />
<%
request.setCharacterEncoding("UTF-8");

int totalRecord = 0; // 전체 레코드 수
int numPerPage = 10; // 페이지당 레코드 수 
int pagePerBlock = 10; // 블록당 페이지 수 

int totalPage = 0; // 전체 페이지 수
int totalBlock = 0; // 전체 블록 수 

int nowPage = 1; // 현재 페이지
int nowBlock = 1; // 현재 블록

int start = 0; // 디비의 select 시작번호
int end = numPerPage; // 시작번호로부터 가져올 select 갯수

String keyField = "", keyWord = "";
Vector<BoardBean> vlist = null;

if (request.getParameter("keyField") != null && request.getParameter("keyWord") != null) {
	keyField = request.getParameter("keyField");
	keyWord = request.getParameter("keyWord");
}

if (request.getParameter("nowPage") != null) {
	nowPage = Integer.parseInt(request.getParameter("nowPage"));
}

start = (nowPage - 1) * numPerPage;

totalRecord = bMgr.getTotalCount(keyField, keyWord);
totalPage = (int) Math.ceil((double) totalRecord / numPerPage);
nowBlock = (int) Math.ceil((double) nowPage / pagePerBlock);
totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock);
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
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon"
	href="${pageContext.request.contextPath}/images/common/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/my/manager.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
<title>해피빈 관리자 : 공지 관리</title>
<style>
ol:last-of-type {
	overflow-x: hidden;
	width: 800px;
	font-size: 0.7em;

	/* border: 10px solid #000; */
}

ol:last-of-type li {
	display: flex;
	justify-content: center;
	align-items: center;
	/* padding: -15px; */
	width: 100%;
	text-align: center;
	background-color: transparent;
}

ol:last-of-type li>a {
	display: inline-block;
	overflow: hidden;
	position: relative;
	width: 39px;
	height: 39px;
	margin: 0 30px;
	text-indent: -9999px;
	border: 1px solid #d2d2d2;
}

ol:last-of-type li>a span {
	display: inline-block;
	position: absolute;
	top: 50%;
	width: 1em;
	height: 1em;
	margin: 0;
	color: transparent;
	border: 1px solid;
	border-color: #d2d2d2 #d2d2d2 transparent transparent;
	border-radius: 0%;
}

.page {
	display: flex;
	flex-flow: row nowrap;
	color: #828282;
	font-weight: 900;
}

.prev {
	left: calc(( 50% + 1.4142135623731em)/2);
	transform: translateY(-50%) rotate(-135deg);
}

.next {
	right: calc(( 50% + 1.4142135623731em)/2);
	transform: translateY(-50%) rotate(45deg);
}

ol:last-of-type form:last-of-type input {
	display: block;
	float: right;
	position: relative;
	width: 100px;
	height: 40px;
	margin: 30px;
	font-size: 1em;
	text-align: center;
	background-color: greenyellow;
	border: 1px solid #000;
	cursor: pointer;
}

.page a {
	display: inline-block;
	/* float: left; */
	width: 1.5em;
	height: 1.5em;
	margin: 0 auto;
	padding: 2px;
	line-height: 1.5em;
	font-size: 2em;
	text-align: center;
	border: 1px solid #d2d2d2;
}

.page a:first-of-type ~ a {
	border-left: none;
}
</style>
</head>
<body>
	<jsp:include page="/views/header.jsp" />
	<div id="wrap" class="w_max">
		<jsp:include page="/views/admin_nav.jsp" />
		<div style="align-self: flex-start; flex-grow: 2;">
			<section id="item_list_wrap">
				<h2 class="donation_title">공지 리스트</h2>
				<div class="filter_box">
					<a href="./notice_write.jsp" class="funding_write writeBtn">공지
						등록</a>
				</div>

				<form action="list.jsp" method="get">
				</form>

				<script>
					function selectAllCheckboxes() {
						let checkboxes = document.getElementsByName("select");
						let selectAllCheckbox = document.getElementById("selectAll");
						let checked = selectAllCheckbox.checked;

						for (let i = 0; i < checkboxes.length; i++) {
							checkboxes[i].checked = checked;
						}
					}

					// 각 체크박스의 상태가 변경될 때 selectAllCheckbox의 상태를 업데이트
					function updateSelectAllCheckbox() {
						let checkboxes = document.getElementsByName("select");
						let selectAllCheckbox = document.getElementById("selectAll");
						selectAllCheckbox.checked = Array.from(checkboxes).every(checkbox => checkbox.checked);
					}
				</script>

				<form action="deleteBoards" method="post">
					<!-- 서블릿 URL을 action에 지정 -->
					<table>
						<colgroup>
							<col style="width: 5%;">
							<col style="width: 60%;">
							<col style="width: 15%;">
							<col style="width: 20%;">
						</colgroup>

						<tr class="table_header" style="height:50px;">
							<th scope="row"><input type="checkbox" id="selectAll" onclick="selectAllCheckboxes()"></th>
							<th>제목</th>
							<th>작성일</th>
							<th>관리</th>
						</tr>

						<%
						vlist = bMgr.getBoardList(keyField, keyWord, start, end);
						int listSize = vlist.size();

						if (listSize == 0) {
							out.println("<tr><td colspan='4' align='center'>등록된 게시물이 없습니다.</td></tr>");
						} else {
							for (int i = 0; i < listSize; i++) {
								bean = vlist.get(i);
						%>
						<tr>
							<td><input type="checkbox" name="select"
								value="<%=bean.getId()%>" onclick="updateSelectAllCheckbox()"></td>
							<td><a
								href='<%=request.getContextPath()%>/admin/notice_read.jsp?id=<%=bean.getId()%>'><%=bean.getTitle()%></a></td>
							<td><%=new java.text.SimpleDateFormat("yyyy-MM-dd").format(bean.getCreatedAt())%></td>
							<td><a
								href='<%=request.getContextPath()%>/admin/notice_edit.jsp?id=<%=bean.getId()%>'
								class="btn edit">수정</a> <a href="javascript:void(0);"
								onclick="confirmAndDelete(<%=bean.getId()%>);"
								class="btn delete">삭제</a></td>
						</tr>

						<script>
    function confirmAndDelete(id) {
        if (confirm("정말 삭제하시겠습니까?")) {
            // 동적으로 폼 생성
            var form = document.createElement("form");
            form.method = "POST";
            form.action = "<%=request.getContextPath()%>/admin/notice_delete_action.jsp";

            // ID를 폼에 추가 (hidden input)
            var hiddenField = document.createElement("input");
            hiddenField.type = "hidden";
            hiddenField.name = "id";
            hiddenField.value = id;
            form.appendChild(hiddenField);

            // 동적으로 생성한 폼을 body에 추가하고 제출
            document.body.appendChild(form);
            form.submit();
        }
    }
</script>


						<%
						}
						}
						%>
					</table>

				</form>

			</section>
		</div>
	</div>
	<jsp:include page="/views/footer.jsp" />
</body>
</html>
