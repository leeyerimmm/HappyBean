<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String user_id = (String)session.getAttribute("idKey");
	if(!user_id.equals("master")){
		%>
		<script>
			alert("잘못된 접근입니다.");
			location.href="./user_info.jsp";
		</script>
		<%
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" href="./../images/common/favicon.ico" type="image/x-icon" />
  <link rel="stylesheet" href="./../css/my/manager.css">
  <link rel="stylesheet" href="./../css/reset.css">
  <title>해피빈 관리자</title>
</head>
<body>
  <jsp:include page="/views/header.jsp" />
  <div id="wrap" class="w_max">
    <section id="user_info_list_wrap" class="w_max">
      <div class="user_name_box">
        <div class="icon manager"><span class="sr-only">해피빈 마스코트</span></div>
        <h2><span class="user_name">관리자</span>님</h2>
      </div>
      <div class="user_info_box">
        <ul class="info_list">
          <li>
            <a href="#">
              <p>진행중 기부</p>
              <p><strong class="hold_bean">0</strong> 건</p>
            </a>
          </li>
          <li>
            <a href="#">
              <p>진행중 펀딩</p>
              <p><strong class="payment">0</strong> 건</p>
            </a>
          </li>
          <li>
            <a href="#">
              <p>진행중 이벤트</p>
              <p><strong class="cash_box">0</strong> 건</p>
            </a>
          </li>
        </ul>
      </div>
      <nav class="user_menu_list_box">
        <ul id="user_menu_list">
          <li class="current"><a href="#">기부 아이템 관리</a></li>
          <li class=""><a href="#">펀딩 아이템 관리</a></li>
          <li class=""><a href="#">이벤트 아이템 관리</a></li>
        </ul>
      </nav>
    </section>
    <div style="align-self: flex-start; flex-grow: 2;">
      <section id="user_activity_view_wrap">
        <h2 class="sr-only">기부 아이템 관리 페이지</h2>
        <div class="user_activity">
          <div class="current_bean">
            <ul class="info_list">
              <li class="list_head">
                <h3>현재 진행중인 기부</h3>
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
                <h3>종료된 기부</h3>
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
      

      <section id="item_list_wrap">
        <h2>기부 아이템 리스트</h2>
        <table>
          <colgroup>
            <td style="width: 5%;"></td>
            <td style="width: 15%;"></td>
            <td style="width: 40%;"></td>
            <td style="width: 15%;"></td>
            <td style="width: 15%;"></td>
            <td style="width: 10%;"></td>
          </colgroup>
          <tr>
            <th scope="row"></th>
            <th>진행 기간</th>
            <th>제목</th>
            <th>목표금액</th>
            <th>모금된 금액</th>
            <th>진행률</th>
          </tr>
          <tr>
            <td><input type="checkbox" name="select" style="display: block; margin-left: 10px;"></td>
            <td>2024.12.11까지</td>
            <td>태풍으로 고통받는 베트남을 도와주세요</td>
            <td>9,900,000원</td>
            <td>1,183,400원</td>
            <td>11%</td>
          </tr>
          <tr>
            <td><input type="checkbox" name="select" style="display: block; margin-left: 10px;"></td>
            <td>2024.12.11까지</td>
            <td>태풍으로 고통받는 베트남을 도와주세요</td>
            <td>9,900,000원</td>
            <td>1,183,400원</td>
            <td>11%</td>
          </tr>
          <tr>
            <td><input type="checkbox" name="select" style="display: block; margin-left: 10px;"></td>
            <td>2024.12.11까지</td>
            <td>태풍으로 고통받는 베트남을 도와주세요</td>
            <td>9,900,000원</td>
            <td>1,183,400원</td>
            <td>11%</td>
          </tr>
          <tr>
            <td><input type="checkbox" name="select" style="display: block; margin-left: 10px;"></td>
            <td>2024.12.11까지</td>
            <td>태풍으로 고통받는 베트남을 도와주세요</td>
            <td>9,900,000원</td>
            <td>1,183,400원</td>
            <td>11%</td>
          </tr>
          <tr>
            <td><input type="checkbox" name="select" style="display: block; margin-left: 10px;"></td>
            <td>2024.12.11까지</td>
            <td>태풍으로 고통받는 베트남을 도와주세요</td>
            <td>9,900,000원</td>
            <td>1,183,400원</td>
            <td>11%</td>
          </tr>
          <tr>
            <td><input type="checkbox" name="select" style="display: block; margin-left: 10px;"></td>
            <td>2024.12.11까지</td>
            <td>태풍으로 고통받는 베트남을 도와주세요</td>
            <td>9,900,000원</td>
            <td>1,183,400원</td>
            <td>11%</td>
          </tr>
          <tr>
            <td><input type="checkbox" name="select" style="display: block; margin-left: 10px;"></td>
            <td>2024.12.11까지</td>
            <td>태풍으로 고통받는 베트남을 도와주세요</td>
            <td>9,900,000원</td>
            <td>1,183,400원</td>
            <td>11%</td>
          </tr>
          <tr>
            <td><input type="checkbox" name="select" style="display: block; margin-left: 10px;"></td>
            <td>2024.12.11까지</td>
            <td>태풍으로 고통받는 베트남을 도와주세요</td>
            <td>9,900,000원</td>
            <td>1,183,400원</td>
            <td>11%</td>
          </tr>
          <tr>
            <td><input type="checkbox" name="select" style="display: block; margin-left: 10px;"></td>
            <td>2024.12.11까지</td>
            <td>태풍으로 고통받는 베트남을 도와주세요</td>
            <td>9,900,000원</td>
            <td>1,183,400원</td>
            <td>11%</td>
          </tr>
          <tr>
            <td><input type="checkbox" name="select" style="display: block; margin-left: 10px;"></td>
            <td>2024.12.11까지</td>
            <td>태풍으로 고통받는 베트남을 도와주세요</td>
            <td>9,900,000원</td>
            <td>1,183,400원</td>
            <td>11%</td>
          </tr>
        </table>

        <nav class="page_index_wrap">
          <button type="button" class="deleteBtn">선택삭제</button>
          <a href="./donation_write.html" class="donation_write">기부 아이템 등록</a>
          <button type="button" class="pagePrev"><</button>
          <ul class="page_index">
            <li class="currnet"><span>1</span></li>
            <li><span>2</span></li>
            <li><span>3</span></li>
            <li><span>4</span></li>
            <li><span>5</span></li>
            <li><span>6</span></li>
            <li><span>7</span></li>
            <li><span>8</span></li>
            <li><span>9</span></li>
            <li><span>10</span></li>
          </ul>
          <button type="button" class="pageNext">></button>   
        </nav>
             
      </section>
    </div>
    
  </div>
</body>
</html>