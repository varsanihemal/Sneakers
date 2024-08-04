// app/javascript/packs/product.js
import './product';

document.addEventListener('DOMContentLoaded', function() {
    const minusBtn = document.querySelector('.minus-btn');
    const plusBtn = document.querySelector('.plus-btn');
    const quantityField = document.querySelector('#quantity-field');
    
    if (minusBtn && plusBtn && quantityField) {
      minusBtn.addEventListener('click', function() {
        let currentValue = parseInt(quantityField.value, 10);
        if (currentValue > 1) {
          quantityField.value = currentValue - 1;
        }
      });
      
      plusBtn.addEventListener('click', function() {
        let currentValue = parseInt(quantityField.value, 10);
        quantityField.value = currentValue + 1;
      });
    }
  });
  