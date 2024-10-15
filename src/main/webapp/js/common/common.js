(function progBar() {
	const $progBar = document.querySelectorAll(".prog_bar");
	const $progValue = document.querySelectorAll(".prog_bar strong");
	const $progNum = document.querySelectorAll(".prog_num");
	

	for (let i = 0; i < $progValue.length; i++) {
		$progValue[i].style.width = $progNum[i].innerText + '%';
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

function formatNumber(num) {
	return num.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function formatInput() {
	const rawValue = textInput.value.replace(/,/g, "");
	const formattedValue = formatNumber(rawValue);
	$payBean.value = formattedValue;
}

function updateValue() {
	const $payBean = document.querySelector("input#payBean");
	const $selectedRadio = document.querySelector('input[name="choose_amount"]:checked');
	const $selectedRadios = document.querySelectorAll('input[name="choose_amount"]');
	const $selectedCheckBox = document.querySelector('input[name="fullAmount"]');
	const $conBeanValue = document.querySelector("li.bean_info_frame strong.conversion_bean").innerText;

	if ($selectedCheckBox.checked) {
		$selectedRadios.forEach((radio) => {
			radio.checked = false;
			$payBean.value = formatNumber($conBeanValue);
		});
	}

	if ($selectedRadio) {
		$payBean.value = formatNumber($selectedRadio.value);
		$selectedCheckBox.checked = false;
	}
}

function payBeanInputValue() {
	const $payBean = document.querySelector("input#payBean");

	$payBean.addEventListener("focus", () => {
		$payBean.setAttribute("placeholder", "");
		$payBean.value = "";
	});

	$payBean.addEventListener("blur", () => {
		$payBean.setAttribute("placeholder", "0");
	});
}

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
