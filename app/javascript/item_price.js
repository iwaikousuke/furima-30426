window.addEventListener("DOMContentLoaded", () => {
  const path = location.pathname
  const pathRegex = /^(?=.*item)(?=.*edit)/
  if (path === "/items/new" || path === "/items") {
      const priceInput = document.getElementById("item-price");
      priceInput.addEventListener("input", () => {
      const inputValue = priceInput.value;
      const profitDom = document.getElementById("profit");
      const addTaxDom = document.getElementById("add-tax-price");
      addTaxDom.innerHTML = Math.floor(inputValue * 0.1).toLocaleString();
      profitDom.innerHTML = Math.floor(inputValue * 0.9).toLocaleString();
    })
  }
});
