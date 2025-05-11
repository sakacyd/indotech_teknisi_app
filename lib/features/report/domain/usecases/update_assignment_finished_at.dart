import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/core/usecase/usecase.dart';
import 'package:indotech_teknisi_app/core/common/entities/report.dart';
import 'package:indotech_teknisi_app/features/report/data/models/report_model.dart';
import 'package:indotech_teknisi_app/features/report/domain/repository/report_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateAssignmentFinishedAt implements UseCase<Report, UpdateAssignmentFinishedAtParams> {
  final ReportRepository repository;

  UpdateAssignmentFinishedAt(this.repository); 

  @override
  Future<Either<Failure, Report>> call(
    UpdateAssignmentFinishedAtParams params,
  ) async {
    return await repository.updateAssignmentFinishedAt(
      report: params.report,
    );
  }
}

class UpdateAssignmentFinishedAtParams {
  final ReportModel report;

  UpdateAssignmentFinishedAtParams({required this.report});
}