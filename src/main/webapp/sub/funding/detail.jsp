<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Controls.FundingMgr" %>
<%@ page import="Controls.FundingBean" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.text.NumberFormat" %>
<jsp:useBean id="fMgr" class="Controls.FundingMgr"/>
<%
  request.setCharacterEncoding("utf-8");
	FundingMgr fundingMgr = new FundingMgr();
	FundingBean funding = null;	
	Vector<FundingBean> fundingArticleList = null;
	String numStr = request.getParameter("num"); // num 파라미터 가져오기
	int num = 0;
	
	if (numStr != null && !numStr.isEmpty()) {
	    try {
	        num = Integer.parseInt(numStr);
	        funding = fundingMgr.getFundingById(num); // 펀딩 정보 조회
	        fundingArticleList = fMgr.getFundingArticleList(num);
	    } catch (NumberFormatException e) {
	        out.println("유효하지 않은 num 값입니다.");
	    }
	} else {
	    out.println("num 파라미터가 제공되지 않았습니다.");
	}
	
	int dDay = 0;
	
  if (funding != null) {
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      try {
          Date endDate = sdf.parse(funding.getEnd_date());
          Date startDate = sdf.parse(funding.getStart_date());
          long diff = endDate.getTime() - startDate.getTime(); // 시작일과 종료일의 차이 계산
          dDay = (int) (diff / (1000 * 60 * 60 * 24)); // 밀리초를 일로 변환
      } catch (Exception e) {
          e.printStackTrace();
      }
    }
  
  //id 유효성 검사
  String user_id = (String)session.getAttribute("idKey");
  if(user_id == null){
		%>
		<script>
			const user_id = null;
		</script>
		<%
	}else{
		%>
		<script>
			const user_id = "<%= user_id %>";
		</script>
		<%		
	}
  
  // funding이 null일 경우 처리
  if (funding == null) {
      out.println("<h2>해당 펀딩 정보를 찾을 수 없습니다.</h2>");
      return; // funding이 null일 경우, 이후 코드를 실행하지 않도록 종료
  }
    
    NumberFormat nFormat = NumberFormat.getInstance(Locale.KOREA);  
    
%>


<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="icon" href="${pageContext.request.contextPath}/images/common/favicon.ico" type="image/x-icon" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sub/funding/funding_detail.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css" />
		<title>해피빈 : <%= funding != null ? funding.getTitle() : "펀딩 상세보기" %></title>
		<script defer src="${pageContext.request.contextPath}/js/common/common.js"></script>
	</head>
	<body>
		<jsp:include page="/views/header.jsp"></jsp:include>
		<div id="wrap">
			<section id="detail_header_box" class="w_max">
				<h2 class="sr-only">아이템</h2>
				<%
         	if(funding.getStatus().equals("진행중")){
         		%>
         		<div class="thumb_box">	           		
         		<%
         	}else {
         		%>
         		<div class="thumb_box off">	        		
         		<%
         	}
         
         %>  			
					<img src="./images/<%= funding.getThumb() %>_1.jpg" alt="<%=funding.getTitle() %>" />
				</div>
				<%
         	if(funding.getStatus().equals("진행중")){
         		%>
         		<div class="info_box">           		
         		<%
         	}else {
         		%>
         		<div class="info_box off">         		
         		<%
         	}
         
         %>  
				
					<ul class="item_info_list">
						<li class="d_day">
						<%
            	if(funding.getStatus().equals("진행중")){
            		%>
            		<p><strong><%= dDay %></strong>일 남음</p>	            		
            		<%
            	}else {
            		%>
            		<p style="color:#fff; background-color:#ddd;"><strong>종료</strong></p>
            		
            		<%
            	}
            
            %>  
						
							
						</li>
						<li class="title">
							<h3><%= funding != null ? funding.getTitle() : "정보 없음" %></h3>
						</li>
						<li class="goal_info">
							<h4>
								<span class="prog_num">
								<%= funding != null ? (Integer.parseInt(funding.getRased_amount()) * 100 /Integer.parseInt(funding.getGoal_amount())) : 0 %>
								</span>%
							</h4>
							<div class="prog_bar">
								<strong style="display: block"></strong>
							</div>
							<div class="amount_wrap">
								<p class="goal_amount">
									<span><%= nFormat.format(Long.parseLong(funding.getGoal_amount())) %></span>원 목표
								</p>
								<p class="rased_amount">
									<strong><%= nFormat.format(Long.parseLong(funding.getRased_amount())) %></strong>원
								</p>
							</div>
						</li>
						<li class="company_info">
							<p class="company_icon"></p>
							<div class="name_wrap">
								<p class="company"><strong><%= funding != null ? funding.getCompany() : "정보 없음" %></strong></p>
								<p class="company_slo"><%= funding != null ? funding.getSlogan() : "정보 없음" %></p>
							</div>
						</li>
						<li class="reward_choose">
							<form id="fundingForm" name="fundingFrm" action="fundingPayment.jsp" method="POST" onsubmit="return submitFunding();">
								<input type="hidden" name="num" value="<%= numStr %>"/>
								<input type="hidden" name="thumb" value="<%= funding.getThumb()%>"/>
								<input type="hidden" name="title" value="<%= funding.getTitle()%>"/>
								<select name="reward" id="reward" onchange="addOption()">
									<option value="">리워드 선택하기</option>
								</select>
								<div class="option_list_wrap">
									<div id="option_container"></div>								
								</div>
								<div class="reward_total">
									<p class="total_count">총 수량 <span id="totalQuantity">0</span>개</p>
									<p class="total_amount">
										총 금액 <span><strong id="totalPrice">0</strong>원</span>
									</p>
								</div>
								<div class="delivery_info">
									<p class="title">배송비</p>
									<p>
										<strong><%= nFormat.format(Long.parseLong(funding.getDelivery_amount())) %>원</strong>(<%=
										nFormat.format(Long.parseLong(funding.getDelivery_free())) %>원 이상 구매 시 무료)<br />
										제주 5,000원, 도서산간 3,000원 추가
									</p>
								</div>
								<div class="button_wrap">
									<%
			            	if(funding.getStatus().equals("진행중")){
			            		%>
			            		<button type="button" onclick="submitFunding()">펀딩 참여하기</button>	            		
			            		<%
			            	}else {
			            		%>
			            		<button type="submit" style="color: #fff; background-color: #ddd;">펀딩 종료</button>
			            		
			            		<%
			            	}
			            
			            %>  
									
									<label for="share"><span class="sr-only">공유하기</span></label>
									<input type="checkbox" id="share" class="sr-only" />
									<div class="share_url_box">
										<p class="page_URL">
											<span></span>
											<button type="button" id="urlCopyBtn">복사</button>
										</p>
									</div>
								</div>
							</form>
						</li>
					</ul>
				</div>
			</section>

			<hr class="border" />

			<section id="detail_content_box" class="w_max">
				<div class="content_wrap" style="width: 70%"><%= funding.getDescription() %></div>

				<article id="funidng_list_wrap">

					<ul class="item_list list_style_2">
					
					<%
					 if (fundingArticleList != null && !fundingArticleList.isEmpty()) {
						for(FundingBean bean : fundingArticleList){	
							SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
							
							Date endDate = sdf.parse(bean.getEnd_date());
		          Date startDate = sdf.parse(bean.getStart_date());
		          long diff = endDate.getTime() - startDate.getTime(); // 시작일과 종료일의 차이 계산
		          dDay = (int) (diff / (1000 * 60 * 60 * 24)); // 밀리
							// 진행률 환산
          		long goalAmount = Long.parseLong(bean.getGoal_amount()); 
              long rasedAmount = Long.parseLong(bean.getRased_amount());
              double progressPercentage = goalAmount > 0 ? Math.round((double) rasedAmount / goalAmount * 100) : 0;
					%>
						<li class="off">
							<a href="detail.jsp?num=<%= bean.getNum() %>">
								<div class="list_info">
									<div class="title_wrap">
										<h4 class="title"><%= bean.getTitle() %></h4>
										<p class="org"><%= bean.getCompany() %></p>
									</div>
									<div class="prog_circle">
										<p class="prog_num2"><span><%= (int)progressPercentage + "%" %></span></p>
									</div>
								</div>
								<div class="d_day_wrap">
									<p><span class="day"><%= dDay %></span>일 남음</p>
									<p><strong class="total"><%= bean.getRased_amount() %></strong>원</p>
								</div>
							</a>
						</li>

					<%
                }
            } else {
        %>
                <li>펀딩 항목이 없습니다.</li>
        <%
            }
        %>
					</ul>
				</article>
			</section>
			<article id="donation_list_wrap" class="w_max">
				<p>기부 목록</p>
			</article>
			<jsp:include page="/views/footer.jsp"/>
		</div>
		
		<script>
    // funding.getOption() 값을 가져와서 JavaScript 변수에 저장
    const optionsString = "<%= funding.getOption() != null ? funding.getOption() : "" %>";
    
    // ','를 기준으로 잘라서 배열에 저장
    const optionsArray = optionsString.split(',');

    // reward 셀렉트 박스에 옵션 추가
    const rewardSelect = document.getElementById("reward");
    
    optionsArray.forEach(option => {
        const optionName = option.substring(0, option.indexOf('{')).trim(); // 옵션명
        const priceString = option.substring(option.indexOf('{') + 1 , option.indexOf('}')); // 가격 문자열
        
        const newOption = document.createElement("option");
        newOption.value = optionName; // 옵션의 value 설정
        newOption.setAttribute("data-price", priceString); // data-price 속성 설정
        newOption.textContent = optionName; // 표시할 텍스트 설정

        // 옵션을 셀렉트 박스에 추가
        rewardSelect.appendChild(newOption);
    });
    
    
    function updateTotal() {
        let totalQuantity = 0;
        let totalPrice = 0;

        const optionDivs = document.querySelectorAll("#option_container > div");
        optionDivs.forEach(optionDiv => {
            const quantity = parseInt(optionDiv.querySelector("input").value);
            const price = parseInt(optionDiv.querySelector(".price").innerText) || 0; // 기본값 설정
            totalQuantity += quantity;
            totalPrice += price * quantity;
        });

        document.getElementById("totalQuantity").innerText = totalQuantity;
        document.getElementById("totalPrice").innerText = totalPrice.toLocaleString();
    }

    
    function removeOption(optionId) {
        const optionDiv = document.getElementById(optionId);
        if (optionDiv) {
            optionDiv.remove();
            updateTotal();
        }
    }

    

    function increaseQuantity(optionId) {
        const optionDiv = document.getElementById(optionId);
        const quantityInput = optionDiv.querySelector("input");
        let currentQuantity = parseInt(quantityInput.value);
        currentQuantity += 1; // 수량 1 증가
        quantityInput.value = currentQuantity; // 업데이트
        updateTotal(); // 총합 업데이트
    }

    function decreaseQuantity(optionId) {
        const optionDiv = document.getElementById(optionId);
        const quantityInput = optionDiv.querySelector("input");
        let currentQuantity = parseInt(quantityInput.value);
        currentQuantity -= 1; // 수량 1 감소

        // 수량이 1보다 작아지지 않도록 처리
        if (currentQuantity < 1) {
            currentQuantity = 1;
        }

        quantityInput.value = currentQuantity; // 업데이트
        updateTotal(); // 총합 업데이트
    }
    
    
    function addOption() {
        const selectBox = document.getElementById("reward");
        const selectedOption = selectBox.options[selectBox.selectedIndex];

        if (selectedOption.value) {
            const container = document.getElementById("option_container");
            const selectedValue = selectedOption.value;
            const selectedPrice = selectedOption.getAttribute("data-price");
            //const selectedPriceFormat = parseInt(selectedOption.getAttribute("data-price")).toLocaleString();

            // 이미 추가된 옵션인지 확인
            const existingOption = document.getElementById(selectedValue);
            if (!existingOption) {
                // 새로운 옵션 추가
                const newOptionDiv = document.createElement("div");
                newOptionDiv.id = selectedValue;
                newOptionDiv.classList.add("option_selected_info");

                newOptionDiv.innerHTML = 
                    '<p class="option_title"><strong>' + selectedValue + '</strong></p>' +
                    '<p class="option_price"><strong class="price">' + selectedPrice + '</strong> 원</p>' +
                    '<button class="minus" type="button" onclick="decreaseQuantity(\'' + selectedValue + '\')"></button>' +
                    '<input class="option_volume" type="number" value="1" min="1"  readonly/>' +
                    '<button class="plus" type="button" onclick="increaseQuantity(\'' + selectedValue + '\')"></button>' +
                    '<button class="delete" type="button" onclick="removeOption(\'' + selectedValue + '\')"></button>' + 
                    '<input type="hidden" name="option_price" value="' + selectedPrice + '" />'; //
                container.appendChild(newOptionDiv);
                updateTotal();
            }
        }
    }
    
    function submitFunding() {
        const $totalPrice = document.querySelector("#totalPrice");
    	if(user_id == null){
    		alert("로그인 후 이용해 주세요.");
    		return;
    	}
    	
        if($totalPrice.innerText == 0){
       		alert("리워드를 선택해 주세요.");
       		return;
        }
        
	        const optionDivs = document.querySelectorAll("#option_container > div");
	        const selectedOptions = [];
	
	        optionDivs.forEach(optionDiv => {
	            const optionName = optionDiv.querySelector(".option_title strong").innerText;
	            const quantity = optionDiv.querySelector("input[type=number]").value;
	            const option_price = optionDiv.querySelector("input[type=hidden]").value;
	            selectedOptions.push({ name: optionName, quantity: quantity, option_price: option_price });
	        });
	
	        const totalQuantity = document.getElementById("totalQuantity").innerText;
	        const totalPrice = document.getElementById("totalPrice").innerText.replace(/,/g, ''); // 숫자만 가져오기
	
	        // 폼에 데이터 추가
	        const form = document.getElementById("fundingForm");
	        const optionsInput = document.createElement("input");
	        optionsInput.type = "hidden";
	        optionsInput.name = "selectedOptions";
	        optionsInput.value = JSON.stringify(selectedOptions); // JSON 문자열로 변환
	        form.appendChild(optionsInput);
	
	        const quantityInput = document.createElement("input");
	        quantityInput.type = "hidden";
	        quantityInput.name = "totalQuantity";
	        quantityInput.value = totalQuantity;
	        form.appendChild(quantityInput);
	
	        const priceInput = document.createElement("input");
	        priceInput.type = "hidden";
	        priceInput.name = "totalPrice";
	        priceInput.value = totalPrice;
	        form.appendChild(priceInput);
	       
	
	        
	        document.fundingFrm.submit();
        
    }
    
  	window.onpageshow = function(event) {
		// Back Forward Cache로 브라우저가 로딩될 경우 혹은 브라우저 뒤로가기 했을 경우
		    if ( event.persisted || (window.performance && window.performance.navigation.type == 2)) {
		    	//페이지 내용이 다시 계산 될 수 있도록 이벤트를 호출 한다.
		    	location.href="detail.jsp?num=<%= num %>";
		    	
		    }
		}

  	
  	//prog_bar
  	(function progBar() {
			const $progBar = document.querySelector(".prog_bar");
			const $progValue = document.querySelector(".prog_bar strong");
			const $progNum = document.querySelector(".prog_num");	
			
				$progValue[i].style.width = $progNum[i].innerText + '%';
			
		})();
    
    
</script>
	
	</body>
</html>