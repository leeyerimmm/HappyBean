<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>

<%
    request.setCharacterEncoding("UTF-8"); // 요청 인코딩 설정

    // 파라미터 가져오기
    String option = request.getParameter("option");
    System.out.println("option = " + option);
    String priceStr = request.getParameter("price");
    System.out.println("price = " + priceStr);
    long price = 0;

    // 가격 문자열을 long으로 변환
    if (priceStr != null && !priceStr.isEmpty()) {
        try {
            price = Long.parseLong(priceStr);
        } catch (NumberFormatException e) {
            out.println("유효하지 않은 가격입니다.");
            return;
        }
    }

    // 금액 포맷팅
    NumberFormat nFormat = NumberFormat.getInstance(Locale.KOREA);
%>

<div class="reward-option" id="<%= option %>">
    <p>선택한 리워드: <strong><%= option %></strong></p>
    <p>가격: <strong class="price"><%= nFormat.format(price) %></strong> 원</p>
    <button onclick="changeQuantity('<%= option %>', -1)">-</button>
    <input type="number" value="1" min="1" readonly />
    <button onclick="changeQuantity('<%= option %>', 1)">+</button>
    <button onclick="removeOption('<%= option %>')">삭제</button>
</div>