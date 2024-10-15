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
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reset.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/sub/notice/list.css">
<link rel="icon" href="${pageContext.request.contextPath}/images/common/favicon.ico" type="image/x-icon" />	
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.css">
<title>해피빈: 공지사항</title>
<script>
    function list() {
        document.listFrm.action = "list.jsp";
        document.listFrm.submit();
    }

    function pageing(page) {
        document.readFrm.nowPage.value = page;
        document.readFrm.submit();
    }

    function block(value) {
        document.readFrm.nowPage.value = <%=pagePerBlock%> * (value - 1) + 1;
        document.readFrm.submit();
    }

    function read(num) {
        document.readFrm.num.value = num;
        document.readFrm.action = "read.jsp";
        document.readFrm.submit();
    }

    function check() {
        if (document.searchFrm.keyWord.value == "") {
            alert("검색어를 입력하세요.");
            document.searchFrm.keyWord.focus();
            return;
        }
        document.searchFrm.submit();
    }
</script>
</head>
<body>
    <jsp:include page="/views/header.jsp"/>
    <div id="wrap" class="w_max">
        <section>
<h2>공지 사항</h2>
            <ul class="notice-list">
                <%
                vlist = bMgr.getBoardList(keyField, keyWord, start, end);
                int listSize = vlist.size();

                if (listSize == 0) {
                    out.println("<li>등록된 게시물이 없습니다.</li>");
                } else {
                    for (int i = 0; i < listSize; i++) {
                        BoardBean bean = vlist.get(i);
                %>
                <li>
                    <span><%=(nowPage - 1) * numPerPage + i + 1%></span>
                    <a href="read_for_user.jsp?id=<%=bean.getId()%>"><%=bean.getTitle()%></a>
                    <span><%=new java.text.SimpleDateFormat("yyyy-MM-dd").format(bean.getCreatedAt())%></span>
                </li>
                <%
                    }
                }
                %>
            </ul>

            <div class="pagination">
                <%
                if (nowPage > 1) {
                %>
                <a href="list.jsp?nowPage=<%=nowPage - 1%>" class="prev">이전</a>
                <%
                } else {
                %>
                <a class="prev disabled">이전</a>
                <%
                }
                
                for (int i = 1; i <= totalPage; i++) {
                %>
                <a href="list.jsp?nowPage=<%=i%>" <%=i == nowPage ? "class='current'" : ""%>><%=i%></a>
                <%
                }
                
                if (nowPage < totalPage) {
                %>
                <a href="list.jsp?nowPage=<%=nowPage + 1%>" class="next">다음</a>
                <%
                } else {
                %>
                <a class="next disabled">다음</a>
                <%
                }
                %>
            </div>
        </section>
    </div>
    <jsp:include page="/views/footer.jsp"/>
</body>
</html>
