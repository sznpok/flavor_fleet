
import 'package:flaviourfleet/features/dashboard/domain/entity/dashboard_entity.dart';

class DashboardState {
  final List<DashboardEntity> lstposts;
  final bool hasReachedMax;
  final int page;
  final bool isLoading;

  DashboardState({
    required this.lstposts,
    required this.hasReachedMax,
    required this.page,
    required this.isLoading,
  });

  factory DashboardState.initial() {
    return DashboardState(
      lstposts: [],
      hasReachedMax: false,
      page: 0,
      isLoading: false,
    );
  }

  DashboardState copyWith({
    List<DashboardEntity>? lstposts,
    bool? hasReachedMax,
    int? page,
    bool? isLoading,
  }) {
    return DashboardState(
      lstposts: lstposts ?? this.lstposts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
