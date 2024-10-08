document.addEventListener('DOMContentLoaded', function () {
    console.log("DOMContentLoaded event triggered");
  console.log("Public key:", gon.public_key);

  const payjp = Payjp(gon.public_key);
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const cvcElement = elements.create('cardCvc');
  const expiryElement = elements.create('cardExpiry');

  numberElement.mount('#number-form');
  cvcElement.mount('#cvc-form');
  expiryElement.mount('#expiry-form');

  const form = document.getElementById('charge-form');
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    console.log("submit event triggered");
  
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
        console.log(response.error.message); // エラーがある場合のログ出力
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type='hidden'>`;
  
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
        console.log("token:", token); // トークン生成時のログ出力
        form.submit(); // フォームを送信
      }
    });
  })});