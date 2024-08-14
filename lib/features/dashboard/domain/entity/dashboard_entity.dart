import 'package:equatable/equatable.dart';

class DashboardEntity extends Equatable {
  final String productId;
  final String productName;
  final int productPrice;
  final String productDescription;
  final String productCategory;
  final String productLocation;
  final String productImage;

  const DashboardEntity({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    required this.productCategory,
    required this.productLocation,
    required this.productImage,
  });
  @override
  List<Object?> get props => [
        productId,
        productName,
        productPrice,
        productDescription,
        productCategory,
        productLocation,
        productImage
      ];
}
