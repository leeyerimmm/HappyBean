<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="join.joinBean" %>
<%
	request.setCharacterEncoding("UTF-8");
	String user_id = (String)session.getAttribute("idKey");
	if(user_id == null){
		%>
		<script>
			alert("잘못된 접근입니다.");
			location.href="./../index.jsp";
		</script>
		<%
	}
%>
<jsp:useBean id="jMgr" class="join.joinMgr"></jsp:useBean>
<jsp:useBean id="jBean" class="join.joinBean"></jsp:useBean>
<%
	joinBean reBean = jMgr.callInfo(user_id);
	String pwd = reBean.getPwd();
	String name = reBean.getName();
	String email = reBean.getEmail();
	String phone = reBean.getPhone();
	String add1 = reBean.getAdd1();
	String add2 = reBean.getAdd2();
	if(add2 == null){
		add2 = "";
	}
	String gender = reBean.getGender();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>해피빈 : 회원정보 수정</title>
  <link rel="icon" href="./../images/common/favicon.ico" type="image/x-icon" />
  <link rel="stylesheet" href="./../css/reset.css">
  <link rel="stylesheet" href="./../css/join/join.css">
  <script defer src="./../js/common/common.js"></script>
  <script defer src="js/my.js"></script>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
  <jsp:include page="/views/header.jsp" />
  <section id="join_wrap">
    <h2>회원정보 수정</h2>
    <p class="att"><span>*</span> 필수 입력 사항</p>
    <form action="user_info_editProc.jsp" method="post" name="editFrm" id="editFrm" autocomplete="off">
      <fieldset>
        <legend class="sr-only">회원정보 수정 폼</legend>        
        <table>
          <colgroup>
            <col style="width: 20%;">
            <col style="width: 60%;">
            <col style="width: 20%;">
          </colgroup>

          <tr>
            <th scope="row"><label for="id">아이디</label></th>
            <td colspan="2">
              <input type="text" name="user_id" id="id" maxlength="16" placeholder="아이디를 입력해주세요." readOnly value="<%= user_id %>">
            </td>
          </tr>
          <tr>
            <th scope="row"><label for="pwd">비밀번호</label></th>
            <td colspan="2">
              <input type="password" name="pwd" id="pwd" maxlength="30" placeholder="비밀번호를 입력해주세요." value="<%= pwd %>">
            </td>

          </tr>
          <tr>
            <th scope="row"><label for="repwd">비밀번호 확인</label></th>
            <td colspan="2">
              <input type="password" name="repwd" id="repwd" maxlength="30" placeholder="비밀번호를 한번 더 입력해주세요." value="<%= pwd %>">
            </td>

          </tr>
          <tr>
            <th scope="row"><label for="name">이름</label></th>
            <td colspan="2">
              <input type="text" name="name" id="name" placeholder="이름을 입력해주세요." value="<%= name %>">
            </td>

          </tr>
          
          <tr>
            <th scope="row"><label for="email">이메일</label></th>
            <td>
              <input type="text" name="email" id="email" maxlength="30" placeholder="이메일을 입력해주세요." readOnly value="<%= email %>">
            </td>
            <td><button type="button" name="emailBtn" class="btn style_1" onclick="emailCheck(editFrm.email.value, '<%= email %>')">수정하기</button></td>
          </tr>
          
          <tr>
            <th scope="row"><label for="phone">연락처</label></th>
            <td>
              <input type="text" name="phone" id="phone" maxlength="11" placeholder="휴대폰 번호를 '-'제외 입력해 주세요" readOnly value="<%= phone %>">
            </td>
            <td><button type="button" name="phoneBtn" class="btn style_1" onclick="phoneCheck(editFrm.phone.value, '<%= phone %>')">수정하기</button></td>
          </tr>

          <tr>
            <th scope="row" rowspan="2"><label for="add_search">주소</label></th>
            <td><input type="text" name="add1" id="add1" placeholder="주소 검색을 이용해 주세요." readOnly value="<%= add1 %>"></td>
            <td>
              <input type="button" name="add_search" id="add_search" value="주소검색" class="btn style_2" onclick="addressSearch()" style="cursor: pointer;">
            </td>
          </tr>
          <tr>
            <td colspan="2"><input type="text" name="add2" id="add2" placeholder="상세 주소를 입력해 주세요." value="<%= add2 %>"></td>
          </tr>
          
          <tr>
            <th scope="row">성별</th>
            <td colspan="2">
              <input type="radio" name="gender" id="male" value="남자">
              <label for="male">남자</label>
              <input type="radio" name="gender" id="female" value="여자">
              <label for="female">여자</label>
               <%
               try{
               	if(gender.equals("남자")){
            		%>
            		<script>
            			document.getElementById('male').checked = true;
            		</script>
            		<%
            	}else{
            		%>
            		<script>
            			document.getElementById('female').checked = true;
            		</script>
            		<%
            	}
               }catch(Exception e){
           		%>
        		<script>
        			alert("잘못된 접근입니다.");
        			location.href="./../index.jsp";
        		</script>
        		<%
               }
               %>
            </td>
          </tr>
        </table>
        <h3>이용약관동의</h3>
        <ul class="agree_list">
          <li class="list_head">
            <input type="checkbox" name="agree" id="all_agree" onclick="selectAll(this)">
            <label for="all_agree">전체 동의</label>
          </li>
          <li>
            <input type="checkbox" name="agree" id="ad_email">
            <label for="ad_email">이메일 수신 동의</label>
            <input type="checkbox" name="agree" id="ad_phone">
            <label for="ad_phone">SMS 수신 동의</label>
          </li>
        </ul>
      	<input type="hidden" name="email_Checking" value="true"/>
      	<input type="hidden" name="phone_Checking" value="true"/>
        <input type="button" name="add_search" id="add_search" value="수정하기" class="btn style_2" style="cursor: pointer;" 
        	onClick="edit(editFrm.email_Checking.value, editFrm.phone_Checking.value)">
      </fieldset>
    </form>
  </section>
  <jsp:include page="/views/footer.jsp" />


 
</body>
</html>
