<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="Controls.FundingBean" %>
<%@ page import="join.joinBean" %>
<%@ page import="java.text.DecimalFormat" %>
<%
  request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="fMgr" class="Controls.FundingMgr"/>
<jsp:useBean id="jMgr" class="join.joinMgr"/>
<%
	String user_id = (String)session.getAttribute("idKey");
	if(user_id == null){
		%>
		<script>
			alert("로그인 상태가 아닙니다.");
			location.href = "../../join/log_in.jsp";
		</script>
		<%
	}
	String selectedOptionsJson = request.getParameter("selectedOptions");
	int num = Integer.parseInt(request.getParameter("num"));
	String totalQuantity = request.getParameter("totalQuantity");
	int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));	  
	String title = request.getParameter("title");

	FundingBean bean = fMgr.getFundingById(num);
	joinBean jBean = jMgr.callInfo(user_id);
  // 수동으로 JSON 파싱 
  List<Map<String, String>> selectedOptions = new ArrayList<>();
  
  // JSON 문자열을 파싱하여 리스트에 추가
  if (selectedOptionsJson != null && !selectedOptionsJson.isEmpty()) {
      selectedOptionsJson = selectedOptionsJson.substring(1, selectedOptionsJson.length() - 1); // 대괄호 제거
      String[] optionsArray = selectedOptionsJson.split("\\},\\{"); // 각 옵션 객체 분리

      for (String option : optionsArray) {
          option = option.replace("{", "").replace("}", ""); // 중괄호 제거
          String[] keyValuePairs = option.split(","); // 키-값 쌍 분리

          Map<String, String> optionMap = new HashMap<>();
          for (String pair : keyValuePairs) {
              String[] keyValue = pair.split(":");
              optionMap.put(keyValue[0].replace("\"", "").trim(), keyValue[1].replace("\"", "").trim()); // 키와 값 추가
          }
          selectedOptions.add(optionMap);
      }
  }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="./css/reset.css">
  <link rel="stylesheet" href="./css/fundingPayment.css">
  <title>펀딩 결제 페이지</title>
  <script defer src="./js/fundingPayment.js"></script>
</head>
<body>
  <header>
    <div class="header-content">
      <div class="logo">
        <img src="./images/logo_kr.svg" alt="N Pay">
      </div>
      <h1 class="title">펀딩결제 신청하기</h1>
      <div class="close">
        &#x2715;
      </div>
    </div>
  </header>
  

  <form action="/submit" method="post">
    <section>
      <div class="payment-section">
        <div class="notice">
          <p>신청하신 상품 발송예정일은 <span class="highlight">9월 23일 (월)</span>입니다.</p>
        </div>
        <div class="payment-info">
          <div class="payment-date-label">결제일</div>
          <div class="payment-date">
            <strong>9월 20일 (금)</strong>
            <p class="sub-info">&nbsp;&nbsp; 결제실패 시 다음날 오전에 1회 재결제 시도</p>
          </div>
        </div>
      </div>
  
      <div class="order-section">
        <div class="order-header toggle">
          <h2>주문상품</h2>
          <span class="arrow">&#9660;</span>
        </div>
      
        <div class="order-details">
          <div class="order-item">
            <div class="product-info-container">
              <div class="product-image">
                <img src="./images/<%= bean.getThumb() %>" alt="상품 이미지">
              </div>
              <div class="product-info">
                <p><%= title %></p>
                <%
                for (Map<String, String> option : selectedOptions) {
                    DecimalFormat formatter = new DecimalFormat("#,###");
                    String formattedNumber = formatter.format(Integer.parseInt(option.get("option_price")));
                	%>
                	<p class="product-options">옵션 리워드: <%= option.get("name") %> 수량: <%= option.get("quantity") %></p>
                	<p class="product-price"><%= formattedNumber %>원</p>
                    <%
                }
                %>
              </div>
            </div>
          </div>
      
          <div class="order-total">
            <p>주문금액</p>
            <%
            DecimalFormat formatter = new DecimalFormat("#,###");
            String formattedNumber = formatter.format(totalPrice);
            %>
            <strong><%= formattedNumber %>원</strong>
          </div>
        </div>
      </div>
  
      <div class="delivery-section">
        <div class="delivery-header toggle">
          <h2>배송지</h2>
          <span class="arrow">&#9660;</span>
        </div>
        <div class="delivery-details" style="display: block;">
          <div class="recipient-info">
            <div class="recipient-text">
              <p><strong><%= jBean.getName() %></strong></p>
	            <% 
	            String takePhoneNumber = String.format("%s-%s-%s", 
	            		jBean.getPhone().substring(0, 3), 
	            		jBean.getPhone().substring(3, 7), 
	            		jBean.getPhone().substring(7, 11));
	            %>
              <p class="phone-number"><%= takePhoneNumber %></p>
              <% String result = (jBean.getAdd2() == null) ? "" : jBean.getAdd2(); %>
              <p><%= jBean.getAdd1() + result %></p>
            </div>
            <button class="edit-btn" type="button">변경</button>
          </div>
      
          <div class="safety-number">
            <input type="checkbox" id="use-safe-number" name="safe-number">
            <label for="use-safe-number">안심번호 사용하기</label>
          </div>
          
      
          <div class="delivery-memo">
            <select name="memo">
              <option value="none">선택 안 함</option>
              <option value="door">문 앞에 두고 가주세요</option>
              <option value="security">경비실에 맡겨주세요</option>
              <option value="call">배송 전 전화주세요</option>
            </select>
          </div>
        </div>
      </div>
      
  
      <div class="orderer-section">
        <div class="orderer-header">
          <h2>주문자</h2>
          <div class="orderer-info">
            <span><strong><%= jBean.getName() %></strong></span>
            <% 
            String PhoneNumber = String.format("%s-%s-%s", 
            		jBean.getPhone().substring(0, 3), 
            		jBean.getPhone().substring(3, 7), 
            		jBean.getPhone().substring(7, 11));
            %>
            <span class="orderer-phone">(<%= PhoneNumber %>)</span>
          </div>
        </div>
      </div>
  
      <div class="payment-method-section">
        <div class="payment-method-header">
          <h2>펀딩결제 결제수단</h2>
        </div>
      
        <div class="payment-method-content">
          <p class="register-text">결제수단을 등록해 주세요</p>
          <p class="register-subtext">설정한 수단으로 모든 펀딩 상품이 결제됩니다.</p>
          <button class="register-button" type="button">등록하기</button>
        </div>
      </div>
      
      <div class="payment-amount-section">
        <div class="payment-amount-header toggle">
          <h2>결제예정금액</h2>
          <%
          int delivery = 3500;
          if(totalPrice > 500000){
        	  delivery = 0;
          }
          int totalDelPrice = totalPrice + delivery;
          formattedNumber = formatter.format(totalDelPrice);
          %>
          <span class="payment-total"><%= formattedNumber %>원</span> 
          <span class="arrow">&#9660;</span> 
        </div>
      
        <div class="payment-details" style="display: none;">
          <div class="payment-content">
            <p class="payment-dates">9월 19일 (목) 결제예정</p>
            <p class="payment-subtext">등록된 결제 수단으로 자동결제 됩니다.</p>
          </div>
      
          <div class="payment-summary">
            <div class="payment-item">
              <span>상품금액</span>
              <span><%= formattedNumber %>원</span>
            </div>
            <div class="payment-item">
              <span>배송비</span>
              <%
              if(delivery == 3500){
            	%>
              	<span>+3,500원</span>
            	<%              
              }else{
            	%>
              	<span>0원</span>
            	<%              
              }
              %>
              
            </div>
          </div>
      
          <div class="payment-total">
            <span>합계</span>
            <strong><%= formattedNumber %>원</strong>
          </div>
        </div>
      </div>
  
      <div class="consent-section">
        <div class="consent-header">
          <input type="checkbox" id="consent-checkbox" class="check-icon">
          <h2>
            <label for="consent-checkbox">펀딩결제 이용안내 동의</label>
          </h2>
          <span class="arrow">›</span>
        </div>
        <div class="consent-details">
          <p>개인정보 제공 동의 : 달작업실</p>
          <p>구매안전 서비스 안내 <span class="info-icon">ⓘ</span></p>
        </div>
      </div>
      
      <div class="final-consent">
        <p class="consent-text">신청 내용을 확인하였으며, 정보 제공 등에 동의합니다.</p>
        <button type="submit" class="submit-button">펀딩결제 신청하기</button>
      </div>
    </section>
  </form>
  <script>
  	dayIndexArr = ['일', '월', '화', '수', '목', '금', '토'];
  	
  	let today = new Date();
  	today.setDate(today.getDate() + 3);
  	let year = today.getFullYear();
  	let month = today.getMonth() + 1;
  	let day = today.getDate();
  	let dayIndex = today.getDay();
  	document.querySelector(".highlight").textContent = month + "월 " + day + "일 " + "(" + dayIndexArr[dayIndex] + ")";
  	
  	today = new Date();
  	year = today.getFullYear();
  	month = today.getMonth() + 1;
  	day = today.getDate();
  	dayIndex = today.getDay();
  	document.querySelector(".payment-date strong").textContent = month + "월 " + day + "일 " + "(" + dayIndexArr[dayIndex] + ")";
  	document.querySelector(".payment-dates").textContent = month + "월 " + day + "일 " + "(" + dayIndexArr[dayIndex] + ")" + " 결제예정";
  	
  </script>
</body>
</html>

    