(function progBar() {
	const $progBar = document.querySelectorAll(".prog_bar");
	const $progValue = document.querySelectorAll(".prog_bar strong");
	const $progNum = document.querySelectorAll(".prog_num");

	for (let i = 0; i < $progValue.length; i++) {
		$progValue[i].style.width = $progNum[i].innerText;
	}
})();

//selectAll (알림수심 모두 동의)

function selectAll(selectAll) {
	const $chks = document.querySelectorAll(".agree_list input[name='agree']");

	$chks.forEach((chk) => {
		chk.checked = selectAll.checked;
	});
}

function toggleAllAgree() {
	const $allAgreeCheckbox = document.getElementById("all_agree");
	const $checkboxes = document.querySelectorAll('input[type="checkbox"].agree_check');
	let allChecked = true;

	$checkboxes.forEach((checkbox) => {
		if (!checkbox.checked) {
			allChecked = false;
		}
	});

	$allAgreeCheckbox.checked = allChecked;
}

document.addEventListener("DOMContentLoaded", () => {
	const $checkboxes = document.querySelectorAll('input[type="checkbox"].agree_check');
	$checkboxes.forEach((checkbox) => {
		checkbox.addEventListener("change", toggleAllAgree);
	});
});

// payment input value (기부/펀딩 결제화면)


// login Form

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

//회원정보수정
function readOnlyFalse(button) {
	const target = button.parentElement.previousElementSibling.firstChild.nextElementSibling;
	target.readOnly = false;
	target.focus();
	target.value = "";
}
