//창닫기
//document.querySelector('.close').addEventListener('click', function() {
//  window.close(); 
//});


// 주문상품
document.querySelectorAll('.order-header').forEach(header => {
  header.addEventListener('click', function() {
    const orderDetails = this.nextElementSibling; 
    const orderArrow = this.querySelector('.arrow'); 

    if (orderDetails.style.display === 'none' || orderDetails.style.display === '') {
      orderDetails.style.display = 'block';
      orderArrow.innerHTML = '&#9650;';
    } else {
      orderDetails.style.display = 'none';
      orderArrow.innerHTML = '&#9660;';
    }
  });
});

document.querySelectorAll('.delivery-header').forEach(header => {
  header.addEventListener('click', function() {
    const deliveryDetails = this.nextElementSibling; 
    const deliveryArrow = this.querySelector('.arrow'); 

    if (deliveryDetails.style.display === 'none' || deliveryDetails.style.display === '') {
      deliveryDetails.style.display = 'block';
      deliveryArrow.innerHTML = '&#9650;'; 
    } else {
      deliveryDetails.style.display = 'none';
      deliveryArrow.innerHTML = '&#9660;';
    }
  });
});


  //결제예정금액
document.querySelectorAll('.payment-amount-header').forEach(header => {
  header.addEventListener('click', function() {
    const paymentDetails = this.nextElementSibling; 
    const paymentTotal = this.querySelector('.payment-total');
    const paymentArrow = this.querySelector('.arrow'); 

    if (paymentDetails.style.display === 'none' || paymentDetails.style.display === '') {
      paymentDetails.style.display = 'block';
      paymentTotal.style.display = 'none'; 
      paymentArrow.innerHTML = '&#9650;';
    } else {
      paymentDetails.style.display = 'none';
      paymentTotal.style.display = 'block'; 
      paymentArrow.innerHTML = '&#9660;';
    }
  });
});

  
// 이용약관 동의
document.querySelector('form').addEventListener('submit', function(event) {
  const isChecked = document.querySelector('#consent-checkbox').checked; 

  if (!isChecked) {
    event.preventDefault(); 
    alert('펀딩결제 이용안내에 동의하셔야 합니다.');
  }
});