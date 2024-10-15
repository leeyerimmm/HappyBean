<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="board.BoardMgr"%>
<%@ page import="board.BoardBean"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<%
request.setCharacterEncoding("UTF-8");

// 수정할 게시글 ID와 내용 가져오기
int id = Integer.parseInt(request.getParameter("id")); // 게시글 ID
String title = request.getParameter("title"); // 수정된 제목
String description = request.getParameter("description"); // 수정된 내용

// BoardMgr 객체 생성
BoardMgr bMgr = new BoardMgr();

// BoardBean 객체 생성 및 데이터 설정
BoardBean bean = new BoardBean();
bean.setId(id);
bean.setTitle(title);
bean.setContent(description);

// 게시물 수정
boolean isUpdated = bMgr.updateBoard(bean);

// 수정 완료 후 리다이렉션
if (isUpdated) {
	response.sendRedirect("manager_notice.jsp"); // 수정 성공 시 페이지 이동
} else {
	out.println("<script>alert('수정에 실패했습니다.'); history.back();</script>"); // 수정 실패 시 경고 후 이전 페이지로 돌아가기
}
%>
