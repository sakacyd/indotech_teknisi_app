import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/core/common/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class DashboardRepository {
  Future<Either<Failure, Assignment>> getNearestAssignment();

  Future<Either<Failure, User>> getCurrentUser();

  Future<Either<Failure, Assignment>> updateTechnicianArrivedAt({
    required DateTime technicianArrivedAt,
  });

  Future<Either<Failure, Assignment>> updateAssignmentStartedAt();

  Future<Either<Failure, Assignment>> updateAssignmentFinishedAt();
}
