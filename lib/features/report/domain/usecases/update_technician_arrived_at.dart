import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/core/usecase/usecase.dart';
import 'package:indotech_teknisi_app/core/common/entities/report.dart';
import 'package:indotech_teknisi_app/features/report/data/models/report_model.dart';
import 'package:indotech_teknisi_app/features/report/domain/repository/report_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateTechnicianArrivedAt implements UseCase<Report, UpdateTechnicianArrivedAtParams> {
  final ReportRepository repository;

  UpdateTechnicianArrivedAt(this.repository); 

  @override
  Future<Either<Failure, Report>> call(
    UpdateTechnicianArrivedAtParams params,
  ) async {
    return await repository.updateTechnicianArrivedAt(
      report: params.report,
    );
  }
}

class UpdateTechnicianArrivedAtParams {
  final ReportModel report;

  UpdateTechnicianArrivedAtParams({required this.report});
}
