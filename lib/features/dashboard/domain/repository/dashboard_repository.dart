import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/core/common/entities/user.dart';
import 'package:fpdart/fpdart.dart';
import 'package:indotech_teknisi_app/features/dashboard/data/models/assignment_model.dart';

abstract interface class DashboardRepository {
  Future<Either<Failure, Assignment>> getNearestAssignment();

  Future<Either<Failure, User>> getCurrentUser();

 /*  Future<Either<Failure, Assignment>> updateTechnicianArrivedAt({
    required AssignmentModel assignment,
  });

  Future<Either<Failure, Assignment>> updateAssignmentStartedAt({
    required AssignmentModel assignment,
  });

  Future<Either<Failure, Assignment>> updateAssignmentFinishedAt({
    required AssignmentModel assignment,
  }); */
}
