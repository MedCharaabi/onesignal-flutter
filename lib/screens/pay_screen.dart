import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:pay/pay.dart';

class PayScreen extends StatefulWidget {
  PayScreen({Key? key}) : super(key: key);

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  static final String tokenizationKey = 'sandbox_hcngzgtw_ntsdn57j753h3cyx';

  void showNonce(BraintreePaymentMethodNonce nonce) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Payment method nonce:'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Nonce: ${nonce.nonce}'),
            SizedBox(height: 16),
            Text('Type label: ${nonce.typeLabel}'),
            SizedBox(height: 16),
            Text('Description: ${nonce.description}'),
          ],
        ),
      ),
    );
  }

  void onGooglePayResult(paymentResult) {
    log(paymentResult);
    // Send the resulting Google Pay token to your server / PSP
  }

  Pay _payClient = Pay.withAssets(['payment_profile.json']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                var request = BraintreeDropInRequest(
                  tokenizationKey: tokenizationKey,
                  collectDeviceData: true,
                  // googlePaymentRequest: BraintreeGooglePaymentRequest(
                  //     totalPrice: '4.30',
                  //     currencyCode: 'USD',
                  //     billingAddressRequired: false,
                  //     googleMerchantID: 'BCR2DN4TZT6LRHSV'),
                  paypalRequest: BraintreePayPalRequest(
                    amount: '4.20',
                    displayName: 'Example company',
                  ),
                  cardEnabled: true,
                );
                final result = await BraintreeDropIn.start(request);
                if (result != null) {
                  showNonce(result.paymentMethodNonce);
                }
              },
              child: const Text('Pay with Paypal[ 4.30\$ ]'),
            ),

            const SizedBox(height: 16),
            // FutureBuilder<bool>(
            //   future: _payClient.userCanPay(PayProvider.google_pay),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.done) {
            //       if (snapshot.data == true) {
            //         return RawGooglePayButton(
            //             type: GooglePayButtonType.pay, onPressed: () {});
            //       } else {
            //         // userCanPay returned false
            //         // Consider showing an alternative payment method
            //       }
            //       return Container();
            //     }
            //     return const CircularProgressIndicator();
            //   },
            // ),
            // //  Google pay
            // GooglePayButton(
            //   paymentConfigurationAsset: 'payment_profile.json',
            //   paymentItems: const [
            //     PaymentItem(
            //       label: 'Total',
            //       amount: '99.99',
            //       status: PaymentItemStatus.final_price,
            //     )
            //   ],
            //   type: GooglePayButtonType.pay,
            //   margin: const EdgeInsets.only(top: 15.0),
            //   onPaymentResult: onGooglePayResult,
            //   loadingIndicator: const Center(
            //     child: CircularProgressIndicator(),
            //   ),
            //   onError: (error) {
            //     log('Error google pay: $error');
            //   },
            //   childOnError: const Text(
            //     'Google Pay is not available',
            //     style: TextStyle(color: Colors.black),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
