import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:subscription/HomePage/homePage.dart';
import 'package:subscription/PaymentGateway/payment/paymentFailure.dart';
import 'package:subscription/PaymentGateway/payment/razorpay_payment.dart';

class CheckRazor extends StatefulWidget {
  var price;
  CheckRazor({this.price});

  @override
  _CheckRazorState createState() => _CheckRazorState();
}

class _CheckRazorState extends State<CheckRazor> {
  var id;

  Razorpay _razorpay = Razorpay();
  var options;
  Future payData() async {
    try {
      _razorpay.open(options);
    } catch (e) {
      print("errror occured here is ......................./:$e");
    }

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    //success
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => MyHomePage()),
      (Route<dynamic> route) => false,
    );

    _razorpay.clear();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("payment has error00000000000000000000000000000000000000");
    // Do something when payment fails
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => FailedPage(
          response: response,
        ),
      ),
      (Route<dynamic> route) => false,
    );
    _razorpay.clear();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("payment has externalWallet33333333333333333333333333");

    _razorpay.clear();
    // Do something when an external wallet is selected
  }

  @override
  void initState() {
    super.initState();

    options = {
      'key':
          "rzp_test_mVuuEwHOsSVXSP", // Enter the Key ID generated from the Dashboard

      'amount': (widget.price * 100.roundToDouble())
          .toString(), //in the smallest currency sub-unit.
      'name': 'Business Tracker',

      'currency': "INR",
      'buttontext': "Pay with Razorpay",
      'description': 'Your business Partner',
      'prefill': {
        'contact': '7907657869',
        'email': 'demo@gmail.com',
      }
    };
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  /* void addAddress() async {
    final addressModel = addressBox.getAt(0) as AddressModel;

    await Firestore.instance
        .collection(locality[0])
        .document(id)
        .collection('address')
        .add({
      'name': addressModel.name,
      'address': addressModel.address,
      'phone': addressModel.phone
    });

    print('try adress to database-----------------------');
  }*/

  @override
  Widget build(BuildContext context) {
    print("razor runtime --------: ${_razorpay.runtimeType}");
    return Scaffold(
      body: FutureBuilder(
          future: payData(),
          builder: (context, snapshot) {
            return Container(
              child: Center(
                child: Text(
                  "Loading...",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
