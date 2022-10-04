import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_braintree/flutter_braintree.dart';

class PaypalPay extends StatelessWidget {
  const PaypalPay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // paypal pay ui
    return Form(
      child: Column(
        children: <Widget>[
          // card number field
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Card Number',
              hintText: 'XXXX XXXX XXXX XXXX',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
          // expiry date field
          SizedBox(
            height: 100,
            child: Expanded(
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Expiry Month',
                        hintText: 'MM',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 100,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Expiry Year',
                        hintText: 'YY',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // cvv field
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'CVV',
              hintText: 'XXX',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),

          // pay button
          ElevatedButton(
            onPressed: () async {
// create Paypal request
//               final request = BraintreePayPalRequest(amount: '50.00');
// // launch Paypal Request

//               BraintreePaymentMethodNonce? result =
//                   await Braintree.requestPaypalNonce(
//                 "sandbox_hcngzgtw_ntsdn57j753h3cyx",
//                 request,
//               );

//               if (result != null) {
//                 log(result.nonce);
//               }

// paypal payment
              final request = BraintreeDropInRequest(
                tokenizationKey: 'sandbox_hcngzgtw_ntsdn57j753h3cyx',
                collectDeviceData: true,
                googlePaymentRequest: BraintreeGooglePaymentRequest(
                  totalPrice: '4.20',
                  currencyCode: 'USD',
                  billingAddressRequired: false,
                ),
                paypalRequest: BraintreePayPalRequest(
                  amount: '10.0',
                  currencyCode: "USD",
                  displayName: 'Example company',
                ),
                cardEnabled: true,
              );
              try {
                final result = await BraintreeDropIn.start(request);
                log('result => ${result?.paymentMethodNonce.nonce}');
              } on PlatformException catch (e) {
                log(e.message!);
              }
            },
            child: const Text('Pay with Paypal'),
          ),
        ],
      ),
    );
  }
}
