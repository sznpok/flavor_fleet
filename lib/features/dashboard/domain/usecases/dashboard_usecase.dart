import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/post_failure.dart';
import 'package:flaviourfleet/features/dashboard/domain/entity/dashboard_entity.dart';
import 'package:flaviourfleet/features/dashboard/domain/repository/dashboard_repository.dart';

class DashboardUsecase {
  final IDashboardRepository dashboardRepository;

  DashboardUsecase({required this.dashboardRepository});

  Future<Either<PostFailure, List<DashboardEntity>>> getAllPosts(int page) {
    return dashboardRepository.getAllPosts(page);
  }
}
