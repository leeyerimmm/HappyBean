<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Controls.CampaignBean" %>
<%@ page import="java.util.Vector" %> 
<jsp:useBean id="cMgr" class="Controls.CampaignMgr"/>
<%
	request.setCharacterEncoding("utf-8");
	Vector<CampaignBean> campaignList = cMgr.getCampaignList();
	CampaignBean campaign = null;	
	String numStr = request.getParameter("num"); 
	int num = 0;
	
	if (numStr != null && !numStr.isEmpty()) {
	    try {
	        num = Integer.parseInt(numStr);
	        campaign = cMgr.getCampaignById(num); 
	        System.out.println(numStr);
	    } catch (NumberFormatException e) {
	    	System.out.println("유효하지 않은 num 값입니다.");
	    }
	} else {
		System.out.println("num 파라미터가 제공되지 않았습니다.");
	}
	
	
	//캠페인 Status 구분 카운트
		int offgoingCount = 0; 
		int ongoingCount = 0; 
		
		for (CampaignBean bean : campaignList) {
		    if ("진행중".equals(bean.getStatus())) {
		        ongoingCount++;
		    }
		    
		    if ("종료".equals(bean.getStatus())) {
		        offgoingCount++;
		    }
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
		<title>해피빈 관리자 : 켐페인 등록</title>		
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
		<jsp:include page="/views/header.jsp"/> 
		<div id="wrap" class="w_max">
			<jsp:include page="/views/admin_nav.jsp"/>
			<div style="align-self: flex-start; flex-grow: 2">
				<section id="user_activity_view_wrap">
				<h2 class="sr-only">캠페인 아이템 관리 페이지</h2>
				<div class="user_activity">
					<div class="current_bean">
						<ul class="info_list">
							<li class="list_head" style="border: none; margin: 0; padding: 0">
								<h3>현재 진행중인 캠페인</h3>
								<p><strong class="total_sum"><%= ongoingCount %></strong>건</p>
							</li>
						</ul>
					</div>
					<div class="total_donation">
						<ul class="info_list">
							<li class="list_head" style="border: none; margin: 0; padding: 0">
								<h3>종료된 캠페인</h3>
								<p><strong class="donation_total"><%= offgoingCount %></strong>건</p>
							</li>
						</ul>
					</div>
				</div>
			</section>

				<section id="item_write_wrap">
					<h2 class="campaign_title">캠페인 수정</h2>
					<form action="campaign_edit_proc.jsp" method="post" autocomplete="off" accept-charset="utf-8">
						<input type="hidden" name="num" value="<%= numStr %>"/>
						<table class="write" style="width: 100%;">
							<colgroup>
								<td style="width: 15%"></td>
								<td style="width: 35%"></td>
								<td style="width: 15%"></td>
								<td style="width: 35%"></td>
							</colgroup>
							<tr>								
								<th>진행유무</th>
								<td>
									<select name="status" id="status">
										<option value="<%= campaign != null ? campaign.getStatus() : "" %>"><%= campaign != null ? campaign.getStatus() : "선택하세요" %></option>
										<option value="진행중">진행중</option>
										<option value="종료">종료</option>										
									</select>
								</td>
								<th>해시태그</th>
								<td>
									<input type="text" name="hash_tag" id="hash_tag" value="<%= campaign != null ? campaign.getHash_tag() : "" %>"/>
								</td>
							</tr>
							<tr>
								<th>이미지명</th>
								<td>
									<input type="text" name="thumb" id="thumb" placeholder="ex : image01.jpg" value="<%= campaign != null ? campaign.getThumb() : "" %>"/>
								</td>
								<th>주최자</th>
								<td>
									<input type="text" name="happybean" id="happybean" value="해피빈" readonly/>
								</td>
							</tr>
							<tr>
								<th>시작일</th>
								<td>
									<input type="date" name="start_date" id="start_date" value="<%= campaign != null ? campaign.getStart_date() : "" %>">
								</td>
								<th>종료일</th>
								<td>
									<input type="date" name="end_date" id="end_date" value="<%= campaign != null ? campaign.getEnd_date() : "" %>">
								</td>
							</tr>
							<tr>
								<th>제목</th>
								<td colspan="3">
									<input type="text" name="title" id="title" value="<%= campaign != null ? campaign.getTitle() : "" %>"/>
								</td>
							</tr>
							
							<tr>
								<td colspan="4" style="height:500px;">
								<textarea name="description" id="description" style="width:100%; height:500px;" value="<%= campaign != null ? campaign.getDescription() : "" %>"></textarea>
								</td>
										<script>
        							ClassicEditor
            					.create( document.querySelector( '#description' ))
            					.catch( error => {
                				console.error( error );
            					} );
    								</script>
							</tr>							
						</table>
						<div class="btn_box">
							<button type="submit">작성완료</button>
							<button type="reset">재 작성</button>
						</div>
					</form>			
			</div>
		</div>
		<jsp:include page="/views/footer.jsp"/>
	</body>
</html>