import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/core/usecase/usecase.dart';
import 'package:indotech_teknisi_app/core/common/entities/report.dart';
import 'package:indotech_teknisi_app/features/report/domain/repository/report_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateTechnicianArrivedAt
    implements UseCase<Report, UpdateTechnicianArrivedAtParams> {
  final ReportRepository repository;

  UpdateTechnicianArrivedAt(this.repository);

  @override
  Future<Either<Failure, Report>> call(
    UpdateTechnicianArrivedAtParams params,
  ) async {
    return await repository.updateTechnicianArrivedAt(
      assignmentId: params.assignmentId,
    );
  }
}

class UpdateTechnicianArrivedAtParams {
  final String assignmentId;

  UpdateTechnicianArrivedAtParams({required this.assignmentId});
}
