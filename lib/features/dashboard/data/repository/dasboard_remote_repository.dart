import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/post_failure.dart';
import 'package:flaviourfleet/features/dashboard/data/data_source/remote/dashboard_remote_data_source.dart';
import 'package:flaviourfleet/features/dashboard/domain/entity/dashboard_entity.dart';
import 'package:flaviourfleet/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardRemoteRepositoryProvider = Provider<IDashboardRepository>(
  (ref) => DashboardRemoteRepository(
    dashboardRemoteDataSource: ref.read(dashboardRemoteDataSourceProvider),
  ),
);

class DashboardRemoteRepository implements IDashboardRepository {
  final DashboardRemoteDataSource dashboardRemoteDataSource;

  DashboardRemoteRepository({required this.dashboardRemoteDataSource});

  @override
  Future<Either<PostFailure, List<DashboardEntity>>> getAllPosts(int page) {
    return dashboardRemoteDataSource.getAllPosts(page);
  }
}
