import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/post_failure.dart';
import 'package:flaviourfleet/features/dashboard/data/repository/dasboard_remote_repository.dart';
import 'package:flaviourfleet/features/dashboard/domain/entity/dashboard_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardRepositoryProvider = Provider<IDashboardRepository>(
  (ref) => ref.read(dashboardRemoteRepositoryProvider),
);

abstract class IDashboardRepository {
  Future<Either<PostFailure, List<DashboardEntity>>> getAllPosts(int page);
}
