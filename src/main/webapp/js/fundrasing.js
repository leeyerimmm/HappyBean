const $list_li = document.querySelectorAll(".item_list2 li");
const $more_btn = document.querySelector(".more");
const $total_article = document.querySelector(".total_article span");

$total_article.textContent = $list_li.length-1;

for(let i = 8; i<$list_li.length; i++){
    $list_li[i].style.display="none";
}

$more_btn.addEventListener("click", ()=>{
    for(let i = 8; i<$list_li.length; i++){
        $list_li[i].style.display="block";
        $more_btn.style.display="none";
    }
});



