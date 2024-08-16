import 'package:flaviourfleet/widget/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import '../model/product_model.dart';

class PaymentForm extends StatefulWidget {
  final Products? product;

  const PaymentForm({super.key, this.product});

  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _amountController.text = widget.product!.productPrice.toString();
    super.initState();
  }

  void _payWithKhalti(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      final amount = int.parse(_amountController.text) * 100;
      KhaltiScope.of(context).pay(
        config: PaymentConfig(
          amount: amount,
          productIdentity: 'product_id_12345',
          productName: 'Sample Product',
        ),
        preferences: [
          PaymentPreference.khalti,
          // Add other preferences if you want (e.g., eBanking, mobile banking)
        ],
        onSuccess: (success) {
          showToast(
              title: 'Payment Successful: ${success.token}',
              color: Colors.green);
        },
        onFailure: (failure) {
          showToast(
              title: 'Payment Failed: ${failure.message}', color: Colors.red);

          // Handle payment failure here
        },
        onCancel: () {
          showToast(title: 'Payment Cancelled:', color: Colors.orange);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Khalti Payment'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount (in NPR)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _payWithKhalti(context),
                child: Text('Pay with Khalti'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
