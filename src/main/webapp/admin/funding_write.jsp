<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Controls.FundingBean" %>
<%@ page import="java.util.Vector" %>   
<jsp:useBean id="fMgr" class="Controls.FundingMgr"/> 
<%
request.setCharacterEncoding("utf-8");
Vector<FundingBean> fundingList = fMgr.getFundingList();
int ongoingCount = 0; 
int offgoingCount = 0; 
int goalFailure = 0;
int goalSuccess = 0;

for (FundingBean funding : fundingList) {
    if ("진행중".equals(funding.getStatus())) {
        ongoingCount++;
        
        if(funding.getRased_amount().equals(funding.getGoal_amount())){
        	goalSuccess++;
        }
        
        
    }
    
    if ("종료".equals(funding.getStatus())) {
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
		<title>해피빈 관리자 : 펀딩 등록</title>		
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
                <p><strong class="total_sum"><%= ongoingCount %></strong>건</p>
              </li>
              <li>
                <a href="#">
                  <p>목표금액 달성</p>
                  <p><strong class="hold_bean"><%= goalSuccess %></strong>건</p>
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
                <p><strong class="donation_total"><%= offgoingCount %></strong>건</p>
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
					<form action="funding_write_proc.jsp" method="post" autocomplete="off" accept-charset="utf-8">
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
										<option>선택하세요</option>
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
										<option>선택하세요</option>
										<option value="진행중">진행중</option>
										<option value="종료">종료</option>										
									</select>
								</td>
							</tr>
							<tr>
								<th>제목</th>
								<td colspan="3">
									<input type="text" name="title" id="title"/>
								</td>
							</tr>
							<tr>
								<th>이미지명</th>
								<td>
									<input type="text" name="thumb" id="thumb" placeholder="ex : image01.jpg"/>
								</td>
								<th>상품 옵션</th>
								<td>
									<input type="text" name="option" id="option" placeholder="ex : 옵션명{가격}, 옵션명{가격}"/>
								</td>
							</tr>
							<tr>
								<th>주최자</th>
								<td>
									<input type="text" name="company" id="company"/>
								</td>
								<th>홍보문구</th>
								<td>
									<input type="text" name="slogan" id="slogan"/>
								</td>
							</tr>
							<tr>
								<th>배송비</th>
								<td>
									<input type="number" name="delivery_amount" id="delivery_amount"/>
								</td>
								<th>무료배송 금액</th>
								<td>
									<input type="number" name="delivery_free" id="delivery_free"/>
								</td>
							</tr>
							<tr>
								<th>시작일</th>
								<td>
									<input type="date" name="start_date" id="start_date">
								</td>
								<th>종료일</th>
								<td>
									<input type="date" name="end_date" id="end_date">
								</td>
							</tr>
							<tr>
								<th>목표금액</th>
								<td colspan="3">
									<input type="number" name="goal_amount" id="goal_amount"/>
								</td>
							</tr>
							
							<tr>
								<td colspan="4" style="height:500px;">
								<textarea name="description" id="description" style="width:100%; height:500px;"></textarea>
									
									
									
								</td>
							</tr>							
						</table>
						<div class="btn_box">
							<button type="submit">작성완료</button>
							<button type="reset">재 작성</button>
						</div>
					</form>			
				<script>
						ClassicEditor
							.create( document.querySelector( '#description' ))
							.catch( error => {
					 				console.error( error );
							} );
						
						window.onload = function() {
							const btn = document.querySelector('button[type="reset"]');
							const textbox = document.querySelector('div.ck-content p'); 
							
							btn.addEventListener('click',()=>{
								textbox.innerText = '';
							});
				     };	
						
				</script>
			</div>
		</div>
		<jsp:include page="/views/footer.jsp"/>
	</body>
</html>