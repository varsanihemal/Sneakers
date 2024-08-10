// // app/javascript/packs/stripe.js

// document.addEventListener('DOMContentLoaded', function() {
//     // Initialize Stripe with your publishable key
//     var stripe = Stripe('<%= Rails.application.credentials.dig(:stripe, :publishable_key) %>');
//     var elements = stripe.elements();
  
//     var card = elements.create('card');
//     card.mount('#card-element');
  
//     var form = document.getElementById('payment-form');
//     form.addEventListener('submit', function(event) {
//       event.preventDefault();
//       stripe.createPaymentMethod('card', card).then(function(result) {
//         if (result.error) {
//           // Display error.message in your UI
//           console.error(result.error.message);
//         } else {
//           // Send paymentMethod.id to your server
//           var paymentMethodInput = document.createElement('input');
//           paymentMethodInput.setAttribute('type', 'hidden');
//           paymentMethodInput.setAttribute('name', 'payment_method_id');
//           paymentMethodInput.setAttribute('value', result.paymentMethod.id);
//           form.appendChild(paymentMethodInput);
//           form.submit();
//         }
//       });
//     });
//   });
  