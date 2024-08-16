import 'package:cached_network_image/cached_network_image.dart';
import 'package:flaviourfleet/features/auth/presentation/view/login_view.dart';
import 'package:flaviourfleet/screen/product_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/fetch_product_bloc/fetch_product_bloc.dart';
import '../utils/constant.dart';
import '../utils/custom_storage.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductView> {
  @override
  void initState() {
    BlocProvider.of<FetchProductBloc>(context).add(FetchProduct());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocProvider(
        create: (context) => FetchProductBloc()..add(FetchProduct()),
        child: BlocConsumer<FetchProductBloc, FetchProductState>(
          listener: (context, state) {
            if (state is FetchProductAuthError) {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                await deleteTokenAccess();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginView()),
                  (route) => false,
                );
              });
            }
          },
          builder: (context, state) {
            if (state is FetchProductError) {
              return const Center(
                child: Text("No data found"),
              );
            }
            if (state is FetchProductLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is FetchProductLoaded) {
              return state.products.isNotEmpty
                  ? RefreshIndicator(
                      onRefresh: () async {
                        BlocProvider.of<FetchProductBloc>(context)
                            .add(FetchProduct());
                      },
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          print(
                              "http:192.168.31.128:4000/images/${product.productImage}");
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailPage(
                                    product: product,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "${ApiUrl.imageUrl}/${product.productImage}",
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Icon(
                                          Icons.image,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          color: Colors.grey,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(
                                          Icons.image,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          color: Colors.grey,
                                        ),
                                        width: double.infinity,
                                      ),
                                    ),
                                    Text(
                                      "Product: ${product.productName ?? ""}",
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01),
                                    Text(
                                        'Price:\$${product.productPrice != null ? product.productPrice!.toStringAsFixed(2) : ""}'),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : const Center(
                      child: Text("No data"),
                    );
            }
            return const Center(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
