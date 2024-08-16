import 'package:flaviourfleet/screen/payment_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/fetch_product_bloc/fetch_product_bloc.dart';
import '../model/product_model.dart';
import 'cash_delivery_view.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, this.product});

  final Products? product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text("My Cart"), backgroundColor: Colors.orangeAccent),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<FetchProductBloc, FetchProductState>(
                builder: (context, state) {
                  if (state is CartUpdated) {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.cartItems.length,
                            itemBuilder: (context, index) {
                              final product = state.cartItems[index];
                              return ListTile(
                                title: Text(product.productName!),
                                subtitle:
                                    Text('Price:\$${product.productPrice}'),
                                trailing: IconButton(
                                  icon: Icon(Icons.remove_shopping_cart),
                                  onPressed: () {
                                    context
                                        .read<FetchProductBloc>()
                                        .add(RemoveFromCart(product: product));
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Total Price: \$${state.totalPrice!.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PaymentForm(
                                        product: product ??
                                            Products(
                                              productName: "not found",
                                              productPrice:
                                                  state.totalPrice!.toInt(),
                                              productCategory: "not found",
                                              productDescription: "not found",
                                              productLocation: "not found",
                                            ),
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Checkout',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.orangeAccent,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CashOnDeliveryForm(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Cash on Delivery',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                  return Center(child: Text('Your cart is empty'));
                },
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
