import 'package:flutter/material.dart';
import 'package:flutter_payment_app/payment_successfully_screen.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
// ignore: depend_on_referenced_packages
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    super.key,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobilenoCntroller = TextEditingController();
  final _amountController = TextEditingController();
  final Razorpay _razorpay = Razorpay();
  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.to(() => PaymentSuccessFullyScreen(
          paymentId: response.paymentId,
          amount: _amountController.text,
          email: _emailController.text,
          contact: _mobilenoCntroller.text,
        ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint("payment fail ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint("payment wallet ${response.walletName}");
  }

  Future<void> _makePayment() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      _razorpay.open({
        'key': 'rzp_test_oYAMT2F5C5cFkF',
        'amount':
            (int.parse(_amountController.text))*100,
        'name': _nameController.text,
        'description': 'Fine T-Shirt',
        'prefill': {
          'contact': _mobilenoCntroller.text,
          'email': _emailController.text
        }
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobilenoCntroller.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Email',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _mobilenoCntroller,
                      decoration: const InputDecoration(
                        hintText: 'Enter Mobile no.',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Mobile no.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _amountController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Amount',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Amount';
                        }
                        if (int.parse(value) <= 0) {
                          return 'Please Enter Valid Amount';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              MaterialButton(
                color: Colors.deepPurple,
                onPressed: () => _makePayment(),
                child: const Text(
                  'Pay',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
