<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.BoardMgr"%>
<%
request.setCharacterEncoding("UTF-8");

int id = Integer.parseInt(request.getParameter("id")); // 삭제할 게시글 ID

BoardMgr bMgr = new BoardMgr();
boolean result = bMgr.deleteBoard(id); // 게시글 삭제

if (result) {
    // 성공적으로 삭제되면 리스트 페이지로 리다이렉트
    response.sendRedirect(request.getContextPath() + "/admin/manager_notice.jsp");
} else {
    // 삭제에 실패했을 경우 에러 메시지 표시
    out.println("<script>alert('삭제에 실패했습니다. 다시 시도해주세요.'); history.back();</script>");
}
%>
