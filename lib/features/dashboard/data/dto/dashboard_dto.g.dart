// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardDto _$DashboardDtoFromJson(Map<String, dynamic> json) => DashboardDto(
      success: json['success'] as bool,
      data: (json['products'] as List<dynamic>?)
              ?.map((e) => DashboardModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$DashboardDtoToJson(DashboardDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'products': instance.data,
    };
