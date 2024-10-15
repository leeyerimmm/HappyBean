<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="javax.swing.text.Document"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>해피빈 : 회원가입</title>
  <link rel="icon" href="${pageContext.request.contextPath}/images/common/favicon.ico" type="image/x-icon" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/join/join.css">
  <script defer src="${pageContext.request.contextPath}/js/common/common.js"></script>
  <script defer src="js/join.js"></script>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
  <jsp:include page="/views/header.jsp"/>
  <section id="join_wrap">
    <h2>회원가입</h2>
    <p class="att"><span>*</span> 필수 입력 사항</p>
    <form action="joinProc.jsp" method="post" name="joinFrm" id="joinFrm" autocomplete="off">
      <fieldset>
        <legend class="sr-only">회원가입 입력 폼</legend>        
        <table>
          <colgroup>
            <col style="width: 20%;">
            <col style="width: 60%;">
            <col style="width: 20%;">
          </colgroup>

          <tr>
            <th scope="row"><label for="id">아이디</label></th>
            <td>
              <input type="text" name="user_id" id="id" maxlength="16" placeholder="아이디를 입력해주세요.">
            </td>
            <td><button type="button" class="btn style_1" onclick="idCheck(joinFrm.user_id.value)">중복확인</button></td>
          </tr>
          <tr>
            <th scope="row"><label for="pwd">비밀번호</label></th>
            <td colspan="2">
              <input type="password" name="pwd" id="pwd"  placeholder="비밀번호를 입력해주세요.">
            </td>

          </tr>
          <tr>
            <th scope="row"><label for="repwd">비밀번호 확인</label></th>
            <td colspan="2">
              <input type="password" name="repwd" id="repwd"  placeholder="비밀번호를 한번 더 입력해주세요.">
            </td>

          </tr>
          <tr>
            <th scope="row"><label for="name">이름</label></th>
            <td colspan="2">
              <input type="text" name="name" id="name" placeholder="이름을 입력해주세요.">
            </td>

          </tr>
          
          <tr>
            <th scope="row"><label for="email">이메일</label></th>
            <td>
              <input type="text" name="email" id="email" placeholder="이메일을 입력해주세요.">
            </td>
            <td><button type="button" class="btn style_1" onclick="emailCheck(joinFrm.email.value)">중복확인</button></td>
          </tr>
          
          <tr>
            <th scope="row"><label for="phone">연락처</label></th>
            <td>
              <input type="text" name="phone" id="phone" placeholder="휴대폰 번호를 '-'제외 입력해 주세요">
            </td>
            <td><button type="button" class="btn style_1" onclick="phoneCheck(joinFrm.phone.value)">본인인증</button></td>
          </tr>

          <tr>
            <th scope="row" rowspan="2"><label for="add_search">주소</label></th>
            <td><input type="text" name="add1" id="add1" placeholder="주소 검색을 이용해 주세요." readOnly></td>
            <td>
              <input type="button" name="add_search" id="add_search" value="주소검색" class="btn style_2" onclick="addressSearch()" style="cursor: pointer;">
            </td>
          </tr>
          <tr>
            <td colspan="2"><input type="text" name="add2" id="add2" placeholder="상세 주소를 입력해 주세요."></td>
          </tr>
          
          <tr>
            <th scope="row">성별</th>
            <td colspan="2">
              <input type="radio" name="gender" id="male" value="남자" checked>
              <label for="male">남자</label>
              <input type="radio" name="gender" id="female" value="여자">
              <label for="female">여자</label>
            </td>
          </tr>
        </table>
        <h3>이용약관동의</h3>
        <ul class="agree_list">
					<li class="list_head">
						<input type="checkbox" name="agree" id="all_agree" onclick="selectAll(this)" />
						<label for="all_agree">전체 동의</label>
					</li>
					<li>
						<input type="checkbox" name="agree" id="agree1" class="agree_check" />
						<label for="agree1">이용약관 동의<span>(필수)</span></label>
						<a href="#" class="trm_view">약관 보기</a>
					</li>
					<li>
						<input type="checkbox" name="agree" id="agree2" class="agree_check" />
						<label for="agree2">개인정보 수집 및 이용 동의<span>(필수)</span></label>
						<a href="#" class="trm_view">약관 보기</a>
					</li>
					<li>
						<input type="checkbox" name="agree" id="agree3" class="agree_check" />
						<label for="agree3">광고정보 수신 동의</label>
						<input type="checkbox" name="agree" id="ad_email" class="agree_check" />
						<label for="ad_email">이메일 수신 동의</label>
						<input type="checkbox" name="agree" id="ad_phone" class="agree_check" />
						<label for="ad_phone">SMS 수신 동의</label>
					</li>
				</ul>
      	<input type="hidden" name="id_Checking" value="false"/>
      	<input type="hidden" name="email_Checking" value="false"/>
      	<input type="hidden" name="phone_Checking" value="false"/>
        <input type="button" name="memberJoin" id="memberJoin" value="가입하기" class="btn style_2" style="cursor: pointer;" 
        	onClick="join(joinFrm.id_Checking.value, joinFrm.email_Checking.value, joinFrm.phone_Checking.value)">
      </fieldset>
    </form>
  </section>  
  <jsp:include page="/views/footer.jsp"/> 


 
</body>
</html>