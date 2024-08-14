
import 'package:flaviourfleet/features/dashboard/data/model/dashboard_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'dashboard_dto.g.dart';

@JsonSerializable()
class DashboardDto {
  final bool success;
  @JsonKey(name: 'products', defaultValue: [])
  final List<DashboardModel> data;

  DashboardDto({
    required this.success,
    required this.data,
  });

  factory DashboardDto.fromJson(Map<String, dynamic> json) =>
      _$DashboardDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardDtoToJson(this);
}
