<%@ page import="java.sql.*, donation.DonationMgr, donation.DonationBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="dMgr" class="donation.DonationMgr" />
<jsp:useBean id="Bean" class="donation.DonationBean" />

<%
    // URL에서 전달된 'num' 값을 가져옴 (수정할 항목의 고유 ID)
    int num = Integer.parseInt(request.getParameter("num"));

    // 해당 항목의 데이터를 가져옴
    DonationBean donation = dMgr.getDonationById(num);

    if (donation == null) {
        out.println("해당 항목을 찾을 수 없습니다.");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="icon" href="${pageContext.request.contextPath}/images/common/favicon.ico" type="image/x-icon" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/my/manager.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css" />
		<script src="https://cdn.ckeditor.com/ckeditor5/29.1.0/classic/ckeditor.js"></script>
		<title>해피빈 관리자 : 상품 수정</title>	
			
		<style>
			.ck.ck-editor {
		    	max-width: 100%;
			}
			.ck-editor__editable {
			    min-height: 500px;
			}
			section#item_write_wrap table.write tr select{
				padding: 10px 10px;
			}
			section#item_write_wrap table.write tr:first-child{
				border: 1px solid #ddd;
			}
			
	</style>
	</head>
	<body>
	<jsp:include page="/views/header.jsp"/> 
		<div id="wrap" class="w_max">
			<jsp:include page="/views/admin_nav.jsp"/>
			<div style="align-self: flex-start; flex-grow: 2">
				        <section id="user_activity_view_wrap">
            <h2 class="sr-only">기부 아이템 관리 페이지</h2>
            <div class="user_activity">
                <div class="current_bean">
                    <ul class="info_list">
                        <li class="list_head">
                            <h3>현재 진행중인 기부</h3>
                            <p><strong class="total_sum"><%= dMgr.getOngoingDonationCount() %></strong>건</p>
                        </li>
                        <li>
                            <a href="#">
                                <p>목표금액 달성</p>
                                <p><strong class="hold_bean"><%= dMgr.getAchievedOngoingDonationCount() %></strong>건</p>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <p>목표금액 미달성</p>
                                <p><strong class="payment"><%= dMgr.getNotAchievedOngoingDonationCount() %></strong>건</p>
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="total_donation">
                    <ul class="info_list">
                        <li class="list_head">
                            <h3>종료된 기부</h3>
                            <p><strong class="donation_total"><%= dMgr.getCompletedDonationCount() %></strong>건</p>
                        </li>
                        <li>
                            <a href="#">
                                <p>목표금액 달성</p>
                                <p><strong class="donation_act"><%= dMgr.getAchievedCompletedDonationCount() %></strong>건</p>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <p>목표금액 미달성</p>
                                <p><strong class="funding_act"><%= dMgr.getNotAchievedCompletedDonationCount() %></strong>건</p>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </section>

<section id="item_write_wrap">
					<h2 class="funding_title">기부 아이템 등록</h2>
<form action="donation_edit_proc.jsp" method="POST" autocomplete="off" accept-charset="utf-8">
    <input type="hidden" name="num" value="<%= donation.getId() %>">
    
    <table class="write" style="width: 100%;">
        <tr>
            <th>카테고리</th>
            <td>
                <select name="category" id="category">
                    <option value="">선택하세요</option>
                    <option value="가족·여성" <%= "가족·여성".equals(donation.getCategory()) ? "selected" : "" %>>가족·여성</option>
                    <option value="시민사회" <%= "시민사회".equals(donation.getCategory()) ? "selected" : "" %>>시민사회</option>
                    <option value="환경" <%= "환경".equals(donation.getCategory()) ? "selected" : "" %>>환경</option>
                    <option value="어르신" <%= "어르신".equals(donation.getCategory()) ? "selected" : "" %>>어르신</option>
                    <option value="다문화" <%= "다문화".equals(donation.getCategory()) ? "selected" : "" %>>다문화</option>
                    <option value="아동·청소년" <%= "아동·청소년".equals(donation.getCategory()) ? "selected" : "" %>>아동·청소년</option>
                    <option value="동물" <%= "동물".equals(donation.getCategory()) ? "selected" : "" %>>동물</option>
                    <option value="장애인" <%= "장애인".equals(donation.getCategory()) ? "selected" : "" %>>장애인</option>
                    <option value="기타" <%= "기타".equals(donation.getCategory()) ? "selected" : "" %>>기타</option>
                </select>
            </td>
        </tr>
        <tr>
            <th>진행 유무</th>
            <td>
                <select name="status" id="status">
                    <option value="">선택하세요</option>
                    <option value="진행중" <%= "진행중".equals(donation.getStatus()) ? "selected" : "" %>>진행중</option>
                    <option value="종료됨" <%= "종료됨".equals(donation.getStatus()) ? "selected" : "" %>>종료됨</option>
                </select>
            </td>
        </tr>
        <tr>
            <th>제목</th>
            <td><input type="text" name="title" value="<%= donation.getTitle() %>" required></td>
        </tr>
        <tr>
            <th>이미지명</th>
            <td><input type="text" name="thumb" value="<%= donation.getThumb() %>" required></td>
        </tr>
        <tr>
            <th>서브 이미지</th>
            <td><input type="text" name="sub_images" value="<%= donation.getSubImages() %>" required></td>
        </tr>
        <tr>
            <th>주최자</th>
            <td><input type="text" name="company" value="<%= donation.getCompany() %>" required></td>
        </tr>
        <tr>
            <th>시작일</th>
            <td><input type="date" name="startDate" value="<%= donation.getStartDate() %>" required></td>
        </tr>
        <tr>
            <th>종료일</th>
            <td><input type="date" name="endDate" value="<%= donation.getEndDate() %>" required></td>
        </tr>
        <tr>
            <th>목표 금액</th>
            <td><input type="number" name="goal_amount" value="<%= donation.getGoalAmount() %>" required></td>
        </tr>
        <tr>
            <th>사업 기간</th>
            <td><input type="text" name="project_duration" value="<%= donation.getProjectDuration() %>" required></td>
        </tr>
        <tr>
            <th>사업 대상</th>
            <td><input type="text" name="target_group" value="<%= donation.getTargetGroup() %>" required></td>
        </tr>
        <tr>
            <th>사업 대상 수</th>
            <td><input type="number" name="target_count" value="<%= donation.getTargetCount() %>" required></td>
        </tr>
        <tr>
            <th>세부 항목 목록</th>
            <td><input type="text" name="cost_details" value="<%= donation.getCostDetails() %>" required></td>
        </tr>
        <tr>
            <th>세부 항목 내용</th>
            <td><input type="text" name="cost_descriptions" value="<%= donation.getCostDescriptions() %>" required></td>
        </tr>
        <tr>
            <th>세부 항목 금액</th>
            <td><input type="text" name="cost_amounts" value="<%= donation.getCostAmounts() %>" required></td>
        </tr>
        <tr>
            <th>기대 효과</th>
            <td><input type="text" name="expected_effect" value="<%= donation.getExpectedEffect() %>" required></td>
        </tr>
        <tr>
            <th>본문 설명</th>
            <td colspan="4"><textarea name="description" style="width:100%; height:500px;" required><%= donation.getDescription() %></textarea></td>
        </tr>
    </table>

    <div class="btn_box">
        <button type="submit">수정 완료</button>
        <button type="reset">재 작성</button>
    </div>
</form>
