import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/core/usecase/usecase.dart';
import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/features/dashboard/data/models/assignment_model.dart';
import 'package:indotech_teknisi_app/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateAssignmentStartedAt implements UseCase<Assignment, UpdateAssignmentStartedAtParams> {
  final DashboardRepository repository;

  UpdateAssignmentStartedAt(this.repository); 

  @override
  Future<Either<Failure, Assignment>> call(
    UpdateAssignmentStartedAtParams params,
  ) async {
    return await repository.updateTechnicianArrivedAt(
      assignment: params.assignment,
    );
  }
}

class UpdateAssignmentStartedAtParams {
  final AssignmentModel assignment;

  UpdateAssignmentStartedAtParams({required this.assignment});
}