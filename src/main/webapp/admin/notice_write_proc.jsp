<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="board.BoardMgr"%>

<%
request.setCharacterEncoding("UTF-8");

// 폼 데이터 받기
String title = request.getParameter("title");
String description = request.getParameter("description");

// 새로운 공지사항 레코드 추가
BoardMgr bMgr = new BoardMgr();
boolean success = bMgr.insertBoard(title, description); // 새로운 메서드를 통해 DB에 삽입

// 데이터베이스 삽입 성공 시 리스트 페이지로 리다이렉트
if (success) {
	response.sendRedirect("manager_notice.jsp");
} else {
	out.println("<script>alert('공지사항 등록에 실패했습니다. 다시 시도해주세요.'); history.back();</script>");
}
%>
