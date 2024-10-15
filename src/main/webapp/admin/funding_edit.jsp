<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Controls.FundingMgr" %>
<%@ page import="Controls.FundingBean" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Vector" %> 
<jsp:useBean id="fMgr" class="Controls.FundingMgr"/>
<%
	request.setCharacterEncoding("utf-8");
	Vector<FundingBean> fundingList = fMgr.getFundingList();
	FundingMgr fundingMgr = new FundingMgr();
	FundingBean funding = null;	
	String numStr = request.getParameter("num"); // num 파라미터 가져오기
	int num = 0;
	
	if (numStr != null && !numStr.isEmpty()) {
	    try {
	        num = Integer.parseInt(numStr);
	        funding = fMgr.getFundingById(num); // 펀딩 정보 조회
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
			
			for (FundingBean bean : fundingList) {
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
		<title>해피빈 관리자 : 상품 수정</title>		
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
        <h2 class="sr-only">펀딩 아이템 관리 페이지</h2>
        <div class="user_activity">
          <div class="current_bean">
            <ul class="info_list">
              <li class="list_head">
                <h3>현재 진행중인 펀딩</h3>
                <p><strong class="total_sum">0</strong>건</p>
              </li>
              <li>
                <a href="#">
                  <p>목표금액 달성</p>
                  <p><strong class="hold_bean">0</strong>건</p>
                </a>
              </li>
              <li>
                <a href="#">
                  <p>목표금액 미달성</p>
                  <p><strong class="payment">0</strong>건</p>
                </a>
              </li>
            </ul>
          </div>
          <div class="total_donation">
            <ul class="info_list">
              <li class="list_head">
                <h3>종료된 펀딩</h3>
                <p><strong class="donation_total">0</strong>건</p>
              </li>
              <li>
                <a href="#">
                  <p>목표금액 달성</p>
                  <p><strong class="donation_act">0</strong>건</p>
                </a>
              </li>
              <li>
                <a href="#">
                  <p>목표금액 미달성</p>
                  <p><strong class="funding_act">0</strong>건</p>
                </a>
              </li>
            </ul>
          </div>
        </div>       
      </section>

				<section id="item_write_wrap">
					<h2 class="funding_title">펀딩 아이템 등록</h2>
					<form action="funding_edit_proc.jsp" method="post" autocomplete="off" accept-charset="utf-8">
						<input type="hidden" name="num" value="<%= numStr %>"/>
						<table class="write" style="width: 100%;">
							<colgroup>
								<td style="width: 15%"></td>
								<td style="width: 35%"></td>
								<td style="width: 15%"></td>
								<td style="width: 35%"></td>
							</colgroup>
							<tr>
								<th>구분</th>
								<td>
									<select name="kategotie" id="kategotie">
										<option value="<%= funding != null ? funding.getKategotie() : "" %>"><%= funding != null ? funding.getKategotie() : "선택하세요" %></option>
										<option value="일자리창출">일자리 창줄</option>
										<option value="공정무역">공정무역</option>
										<option value="친환경">친환경</option>
										<option value="기부">기부</option>
										<option value="작은가게">작은가게</option>
										<option value="미디어">미디어</option>
										<option value="창작자">창작자</option>
									</select>
								</td>
								<th>진행유무</th>
								<td>
									<select name="status" id="status">
										<option value="<%= funding != null ? funding.getStatus() : "" %>"><%= funding != null ? funding.getStatus() : "선택하세요" %></option>
										<option value="진행중">진행중</option>
										<option value="종료">종료</option>										
									</select>
								</td>
							</tr>
							<tr>
								<th>제목</th>
								<td colspan="3">
									<input type="text" name="title" id="title" value="<%= funding != null ? funding.getTitle() : "" %>"/>
								</td>
							</tr>
							<tr>
								<th>이미지명</th>
								<td>
									<input type="text" name="thumb" id="thumb" placeholder="ex : image01.jpg" value="<%= funding != null ? funding.getThumb() : "" %>"/>
								</td>
								<th>상품 옵션</th>
								<td>
									<input type="text" name="option" id="option" placeholder="ex : 옵션명{가격}, 옵션명{가격}" value="<%= funding != null ? funding.getOption() : "" %>"/>
								</td>
							</tr>
							<tr>
								<th>주최자</th>
								<td>
									<input type="text" name="company" id="company" value="<%= funding != null ? funding.getCompany() : "" %>"/>
								</td>
								<th>홍보문구</th>
								<td>
									<input type="text" name="slogan" id="slogan" value="<%= funding != null ? funding.getSlogan() : "" %>"/>
								</td>
							</tr>
							<tr>
								<th>배송비</th>
								<td>
									<input type="number" name="delivery_amount" id="delivery_amount" value="<%= funding != null ? funding.getDelivery_amount() : "" %>"/>
								</td>
								<th>무료배송 금액</th>
								<td>
									<input type="number" name="delivery_free" id="delivery_free" <%= funding != null ? funding.getDelivery_free() : "" %>/>
								</td>
							</tr>
							<tr>
								<th>시작일</th>
								<td>
									<input type="date" name="start_date" id="start_date" value="<%= funding != null ? funding.getStart_date() : "" %>">
								</td>
								<th>종료일</th>
								<td>
									 <input type="date" name="end_date" id="end_date" value="<%= funding != null ? funding.getEnd_date() : "" %>">
								</td>
							</tr>
							<tr>
								<th>목표금액</th>
								<td colspan="3">
									<input type="number" name="goal_amount" id="goal_amount" value="<%= funding != null ? funding.getGoal_amount() : 0 %>"/>
								</td>
							</tr>
							
							<tr>
								<td colspan="4" style="height:500px;">
									<textarea name="description" id="description" style="width:100%; height:500px;"><%= funding != null ? funding.getDescription() : "" %></textarea>
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
							<button type="submit">수정완료</button>
							<button type="reset">재 작성</button>
						</div>
					</form>			
			</div>
		</div>
		<jsp:include page="/views/footer.jsp"/>
	</body>
</html>