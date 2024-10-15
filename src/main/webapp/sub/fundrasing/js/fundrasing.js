const $list_li = document.querySelectorAll(".item_list li");
const $more_btn = document.querySelector(".more");
const $total_article = document.querySelector(".total_article span");

$total_article.textContent = $list_li.length-1;

function $total_article_textContent(){	
	$total_article.textContent = 0;
}

if($list_li.length < 9){
    document.querySelector("button.more").style.display="none";
}

for(let i = 8; i<$list_li.length; i++){
    $list_li[i].style.display="none";
}

$more_btn.addEventListener("click", ()=>{
    for(let i = 8; i<$list_li.length; i++){
        $list_li[i].style.display="block";
        $more_btn.style.display="none";
    }
});



