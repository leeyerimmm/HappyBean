<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="./../css/reset.css" />
    <link rel="stylesheet" href="./../css/join/log_in.css" />
    <link
      rel="icon"
      href="./../images/common/favicon.ico"
      type="image/x-icon"
    />
    <script defer src="./../js/common/common.js"></script>
    <title>해피빈 : 로그인</title>
  </head>
  <body>
   <jsp:include page="/views/header.jsp"/>
    <div id="wrap">
      <section id="login_form_wrap">
        <h2 class="logo_frame">
          <img src="./../images/common/logo_en.svg" alt="HAPPY BEAN" />
        </h2>

        <form action="log_inProc.jsp" name="log_inFrm" method="post" autocomplete="off">
          <ul>
            <li>
              <button type="button" onclick="valueRemove(this)">
                <span class="sr-only">내용지우기</span>
              </button>
              <input
                type="text"
                maxlength="16"
                name="user_id"
                id="id"
                placeholder="아이디를 입력하세요."
              />
            </li>
            <li>
              <button type="button" onclick="valueRemove(this)">
                <span class="sr-only">내용지우기</span>
              </button>
              <input
                type="password"
                maxlength="20"
                name="pwd"
                id="pwd"
                placeholder="비밀번호를 입력하세요"
              />
              <input type="checkbox" name="pwd_show" id="pwd_show" class="sr-only" onclick="pwdShow(this)"/>
              <label for="pwd_show"
                ><span class="sr-only">비밀번호 보기</span></label
              >
            </li>
          </ul>
          <button type="button" id="log_inBtn" onClick="checkInfo(log_inFrm.user_id.value, log_inFrm.pwd.value)">로그인</button>
        </form>

        <ul class="user_find_list">
          <li><a href="#">비밀번호 찾기</a></li>
          <li><a href="#">아이디 찾기</a></li>
          <li><a href="./join.jsp">회원가입</a></li>
        </ul>

        <script>
          const $pwdShow = document.querySelector("#pwd_show");
          const $pwdInput = document.querySelector("#pwd");
          const $pwdLabel = document.querySelector('label[for="pwd_show"]');


          $pwdLabel.addEventListener('click',()=>{

            if($pwdShow.checked){
              $pwdInput.setAttribute('type', 'password');
            } else {
              $pwdInput.setAttribute('type', 'text');
            }

            
          });


          
        </script>
      </section>
    </div>
    <jsp:include page="/views/footer.jsp"/>
    <script>
    	function checkInfo(user_id, pwd){
    		const log_inFrm = document.forms['log_inFrm'];
    		
    		
    		if(user_id == ""){
    			alert("아이디를 입력해 주세요.");
    			log_inFrm.user_id.focus();
    			return;
    		}
    		if(pwd == ""){
    			alert("비밀번호를 입력해 주세요.");
    			log_inFrm.pwd.focus();
    			return;
    		}
    		log_inFrm.submit();
    	}
    	
    	function pwdShow(checked) {
    		const $pwdShow = document.querySelector("#pwd_show");
    		const nextInput = checked.nextElementSibling;

    		if (checked.checked) {
    			if (nextInput.getAttribute("type") === "password") {
    				nextInput.setAttribute("type", "text");
    			}
    		} else {
    			nextInput.setAttribute("type", "password");
    		}
    	}

    	function valueRemove(button) {
    		const nextInput = button.nextElementSibling;

    		if (nextInput && nextInput.tagName === "INPUT") {
    			nextInput.value = "";
    		}
    	}
    </script>
  </body>
</html>
