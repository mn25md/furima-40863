window.addEventListener('turbo:load', calculatePrice);
window.addEventListener('turbo:render', calculatePrice);
function calculatePrice() {
  const priceInput = document.getElementById("item-price");
  const taxOutput = document.getElementById("add-tax-price");
  const profitOutput = document.getElementById("profit");

  if (!priceInput) return;

  priceInput.addEventListener('input', () => {
    const price = parseInt(priceInput.value, 10);

    if (isNaN(price) || price < 300 || price > 9999999) {
      taxOutput.textContent = '';
      profitOutput.textContent = '';
    } else {
      const tax = Math.floor(price * 0.1);
      const profit = price - tax;

      taxOutput.textContent = tax;
      profitOutput.textContent = profit;
    }
  });
}