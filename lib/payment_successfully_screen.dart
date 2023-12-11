import 'package:flutter/material.dart';

class PaymentSuccessFullyScreen extends StatelessWidget {
  final String? paymentId;
  final String? amount;
  final String? email;
  final String? contact;
  const PaymentSuccessFullyScreen(
      {super.key, this.paymentId, this.amount, this.email, this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text('Payment Id :- $paymentId'),
            const SizedBox(
              height: 10,
            ),
            Text('Amount :- $amount'),
            const SizedBox(
              height: 10,
            ),
            Text('Email  :- $email'),
            const SizedBox(
              height: 10,
            ),
            Text('Contact :- $contact'),
            const SizedBox(
              height: 10,
            ),
            const Text('Status :- Success')
          ],
        ),
      ),
    );
  }
}
