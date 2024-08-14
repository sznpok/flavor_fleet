import 'package:equatable/equatable.dart';
import 'package:flaviourfleet/features/dashboard/domain/entity/dashboard_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

final dashboardModelProvider = Provider((ref) {
  return DashboardModel.empty();
});

@JsonSerializable()
class DashboardModel extends Equatable {
  @JsonKey(name: '_id')
  final String productId;
  final String productName;
  final int productPrice;
  final String productDescription;
  final String productCategory;
  final String productLocation;
  final String productImage;

  const DashboardModel({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    required this.productCategory,
    required this.productLocation,
    required this.productImage,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      productId: json['_id'] ?? '',
      productName: json['productName'] ?? '',
      productPrice: json['productPrice'] ?? 0,
      productDescription: json['productDescription'] ?? '',
      productCategory: json['productCategory'] ?? '',
      productLocation: json['productLocation'] ?? '',
      productImage: json['productImage'] ?? '',
    );
  }

  DashboardEntity toEntity() => DashboardEntity(
      productId: productId,
      productName: productName,
      productDescription: productDescription,
      productCategory: productCategory,
      productPrice: productPrice,
      productLocation: productLocation,
      productImage: productImage);

  DashboardModel.empty()
      : productId = '',
        productName = '',
        productPrice = 0,
        productDescription = '',
        productCategory = '',
        productLocation = '',
        productImage = '';

  @override
  List<Object?> get props => [
        productId,
        productName,
        productPrice,
        productDescription,
        productCategory,
        productLocation,
        productImage,
      ];
}
