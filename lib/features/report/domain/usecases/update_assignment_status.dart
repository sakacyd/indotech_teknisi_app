import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/core/usecase/usecase.dart';
import 'package:indotech_teknisi_app/features/report/domain/repository/report_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateAssignmentStatus implements UseCase<Assignment, UpdateAssignmentStatusParams> {
  final ReportRepository repository;

  UpdateAssignmentStatus(this.repository); 

  @override
  Future<Either<Failure, Assignment>> call(
    UpdateAssignmentStatusParams params,
  ) async {
    return await repository.updateAssignmentStatus(
      assignmentId: params.assignmentId,
    );
  }
}

class UpdateAssignmentStatusParams {
  final String assignmentId;

  UpdateAssignmentStatusParams({required this.assignmentId});
}