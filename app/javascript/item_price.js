window.addEventListener('turbo:load', calculatePrice);
window.addEventListener('turbo:render', calculatePrice);

function calculatePrice() {
  const priceInput = document.getElementById("item-price");
  const taxOutput = document.getElementById("add-tax-price");
  const profitOutput = document.getElementById("profit");

  if (priceInput) {
    priceInput.addEventListener('input', () => {
      const inputValue = priceInput.value;

      if (inputValue) {
        const tax = Math.floor(inputValue * 0.1); // 販売手数料(10%)
        const profit = inputValue - tax; // 販売利益
        taxOutput.innerHTML = tax;
        profitOutput.innerHTML = profit;
      } else {
        taxOutput.innerHTML = ''; // 入力が空の場合は手数料や利益をクリア
        profitOutput.innerHTML = '';
      }
    });
  }
}
