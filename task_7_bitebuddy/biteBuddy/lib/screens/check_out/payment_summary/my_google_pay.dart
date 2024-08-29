import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class MyGooglePay extends StatefulWidget {
  final double total; // Ensure the type is consistent
  const MyGooglePay({super.key, required this.total});

  @override
  _MyGooglePayState createState() => _MyGooglePayState();
}

class _MyGooglePayState extends State<MyGooglePay> {
  PaymentConfiguration? _paymentConfiguration;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPaymentConfiguration();
  }

  void _loadPaymentConfiguration() async {
    _paymentConfiguration = await PaymentConfiguration.fromAsset(
        'sample_payment_configuration.json');
    setState(() {
      _isLoading = false;
    });
  }

  void onGooglePayResult(paymentResult) {
    // ignore: avoid_print
    print(paymentResult);
    // Send the resulting Google Pay token to your server or PSP
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return GooglePayButton(
      paymentConfiguration: _paymentConfiguration!,
      paymentItems: [
        PaymentItem(
          label: 'Total',
          amount: widget.total.toString(),
          status: PaymentItemStatus.final_price,
        ),
      ],
      //style: GooglePayButtonStyle.black,
      type: GooglePayButtonType.pay,
      onPaymentResult: onGooglePayResult,
    );
  }
}
