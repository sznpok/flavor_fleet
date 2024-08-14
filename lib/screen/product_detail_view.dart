import 'package:cached_network_image/cached_network_image.dart';
import 'package:flaviourfleet/screen/payment_form.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';
import '../utils/constant.dart';
import 'cash_delivery_view.dart';

class ProductDetailPage extends StatelessWidget {
  final Products product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: Colors.orangeAccent,
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentForm(),
            ),
          );
        },
        label: const Text("Pay"),
        icon: const Icon(Icons.payment),
      ),
      appBar: AppBar(
        title: Text(product.productName!),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl:
                    "${ApiUrl.basUrl}public/products/${product.productImage}",
                fit: BoxFit.cover,
                placeholder: (context, url) => Icon(
                  Icons.image,
                  size: MediaQuery.of(context).size.width / 4,
                  color: Colors.grey,
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.image,
                  size: MediaQuery.of(context).size.width / 4,
                  color: Colors.grey,
                ),
                width: double.infinity,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productName ?? "",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Text(
                        'Price:\$${product.productPrice != null ? product.productPrice!.toStringAsFixed(2) : ""}',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.orangeAccent,
                                ),
                      ),
                    ],
                  ),
                  Chip(
                    label: Text(product.productCategory ?? ""),
                    backgroundColor: Colors.white,
                    labelStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Colors.orangeAccent,
                            ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                'Location: ${product.productLocation ?? ""}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                product.productDescription ?? "",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text('Cash Delivery'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CashOnDeliveryForm(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
