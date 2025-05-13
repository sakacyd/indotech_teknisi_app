import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/core/usecase/usecase.dart';
import 'package:indotech_teknisi_app/core/common/entities/report.dart';
import 'package:indotech_teknisi_app/features/report/domain/repository/report_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateAssignmentStartedAt implements UseCase<Report, UpdateAssignmentStartedAtParams> {
  final ReportRepository repository;

  UpdateAssignmentStartedAt(this.repository); 

  @override
  Future<Either<Failure, Report>> call(
    UpdateAssignmentStartedAtParams params,
  ) async {
    return await repository.updateAssignmentStartedAt(
      assignmentId: params.assignmentId,
    );
  }
}

class UpdateAssignmentStartedAtParams {
  final String assignmentId;

  UpdateAssignmentStartedAtParams({required this.assignmentId});
}