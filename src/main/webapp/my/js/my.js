function idCheck(id){
	if(id == ""){
		alert("아이디를 입력해 주세요.");
	    document.editFrm.user_id.focus();
		return;
	}
	
	const url = "idCheck.jsp?id=" + id;
	const screenWidth = window.screen.width;
	const screenHeight = window.screen.height;
	
	// 새 창의 가로와 세로 크기
	const left = (screenWidth - 500) / 2;
	const top = (screenHeight - 400) / 2;
	
	// 새 창의 특성
	const features = `width=500,height=300,left=${left},top=${top}`;
	
	window.open(url, "IDCheck", features);
}


function emailCheck(email, usedEmail){
	if(email == ""){
		alert("이메일을 입력해 주세요.");
	    document.editFrm.email.focus();
		return;
	}
	
	let str=document.editFrm.email.value;	   
    let atPos = str.indexOf('@');
    let atLastPos = str.lastIndexOf('@');
    let dotPos = str.indexOf('.'); 
    let spacePos = str.indexOf(' ');
    let commaPos = str.indexOf(',');
    let eMailSize = str.length;
    if (atPos > 1 && atPos == atLastPos && 
	   dotPos > 3 && spacePos == -1 && commaPos == -1 
	   && atPos + 1 < dotPos && dotPos + 1 < eMailSize);
    else {
          alert('E-mail주소 형식이 잘못되었습니다.\n다시 입력해 주세요.');
	      document.editFrm.email.value = "";
	      document.editFrm.email.focus();
		  return;
    }
	
	const url = "emailCheck.jsp?email=" + email + "&usedEmail=" + usedEmail;
	const screenWidth = window.screen.width;
	const screenHeight = window.screen.height;
	
	// 새 창의 가로와 세로 크기
	const left = (screenWidth - 500) / 2;
	const top = (screenHeight - 400) / 2;
	
	// 새 창의 특성
	const features = `width=500,height=300,left=${left},top=${top}`;
	
	window.open(url, "EmailCheck", features);
}

function phoneCheck(phone, usedPhone){
	if(phone == ""){
		alert("휴대폰 번호를 입력하세요.");
	    document.editFrm.phone.focus();
		return;
	}
	
	// 연락처 유효성 검사
	let flag = false; 
	const phoneArr = phone.split("");
	for(let i=0; i<phoneArr.length; i++){
		const trans = parseInt(phoneArr[i]);
		if(!Number.isInteger(trans))
			flag = true;	
	}
	
	if(flag || phoneArr.length != 11){
		alert("휴대폰 번호를 확인해주세요.");
	    document.editFrm.phone.value = "";
	    document.editFrm.phone.focus();
		return;
	}
	
	const url = "phoneCheck.jsp?phone=" + phone + "&usedPhone=" + usedPhone;
	const screenWidth = window.screen.width;
	const screenHeight = window.screen.height;
	
	// 새 창의 가로와 세로 크기
	const left = (screenWidth - 500) / 2;
	const top = (screenHeight - 400) / 2;
	
	// 새 창의 특성
	const features = `width=500,height=300,left=${left},top=${top}`;
	
	window.open(url, "PhoneCheck", features);
}

function addressSearch(){
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
            console.log(data);
            if(data.buildingName == ""){
            	document.editFrm.add1.value = data.address;
			}else{
            	document.editFrm.add1.value = data.address + ` (${data.buildingName})`;								
			}
            
        }
    }).open();	
} 

function edit(email_Checking, phone_Checking){
	
	if(document.editFrm.user_id.value==""){
		alert("아이디를 입력해 주세요.");
		document.editFrm.user_id.focus();
		return;
	}
	if(document.editFrm.pwd.value==""){
		alert("비밀번호를 입력해 주세요.");
		document.editFrm.pwd.focus();
		return;
	}
	if(document.editFrm.repwd.value==""){
		alert("비밀번호를 확인해 주세요");
		document.editFrm.repwd.focus();
		return;
	}
	if(document.editFrm.pwd.value != document.editFrm.repwd.value){
		alert("비밀번호가 일치하지 않습니다.");
		document.editFrm.repwd.value="";
		document.editFrm.repwd.focus();
		return;
	}
	if(document.editFrm.name.value==""){
		alert("이름을 입력해 주세요.");
		document.editFrm.name.focus();
		return;
	}

	if(document.editFrm.email.value==""){
		alert("이메일을 입력해 주세요.");
		document.editFrm.email.focus();
		return;
	}
	
	if(document.editFrm.phone.value==""){
		alert("휴대폰 번호를 입력해 주세요.");
		document.editFrm.phone.focus();
		return;
	}
	
    if(document.editFrm.add1.value==""){
		alert("주소를 검색해 주세요.");
		return;
	}
	
	if(email_Checking == "false"){
		alert("E-mail 중복확인을 해주세요.");
		return;
	}
	if(phone_Checking == "false"){
		alert("휴대폰 본인인증을 해주세요.");
		return;
	}

	document.editFrm.submit();
}