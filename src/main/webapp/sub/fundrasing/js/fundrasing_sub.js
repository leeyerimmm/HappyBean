document.addEventListener("DOMContentLoaded", () => {
    const $img_preview = document.querySelectorAll(".img_preview ul li div"); 
    const $img_slide = document.querySelectorAll(".img_slide ul li");
    const $comment_option = document.querySelectorAll(".comment_option span");
    const $comment_content = document.querySelectorAll(".comment div");

    // 이미지 클릭 시 이미지 && 테두리 설정
    let img_preview_index = 0;
    $img_preview.forEach((item, index) => {
        item.addEventListener("click", () => {
            $img_preview[img_preview_index].classList.remove("selected");
            item.classList.add("selected");
            $img_slide[img_preview_index].classList.remove("selected");
            $img_slide[index].classList.add("selected");
            img_preview_index = index;
        });
    });

    // 댓글 && 참여내역 클릭 시 UI 변경
    let comment_option_index = 0;
    $comment_option.forEach((item, index) => {
        item.addEventListener("click", () => {
            $comment_option[comment_option_index].classList.remove("selected");
            item.classList.add("selected");
            comment_option_index = index;
        });
    });
	
	//팝업닫기
	const popup = document.getElementById("popup");
	const closePopupBtn = document.querySelector(".close_popup_btn");
	closePopupBtn.addEventListener("click", () => {
	    popup.classList.add("popup_hide");
	});	
});

