import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/core/usecase/usecase.dart';
import 'package:indotech_teknisi_app/core/common/entities/report.dart';
import 'package:indotech_teknisi_app/features/report/domain/repository/report_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetReportByAssignmentId
    implements UseCase<Report, GetReportByAssignmentIdParams> {
  final ReportRepository repository;

  GetReportByAssignmentId(this.repository);

  @override
  Future<Either<Failure, Report>> call(
    GetReportByAssignmentIdParams params,
  ) async {
    return await repository.getReportByAssignmentId(
      assignmentId: params.assignmentId,
    );
  }
}

class GetReportByAssignmentIdParams {
  final String assignmentId;

  GetReportByAssignmentIdParams({required this.assignmentId});
}
