import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/features/report/data/models/report_model.dart';
import 'package:indotech_teknisi_app/core/common/entities/report.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ReportRepository {
  Future<Either<Failure, Report>> updateTechnicianArrivedAt({
    required ReportModel report,
  });
  Future<Either<Failure, Report>> updateAssignmentStartedAt({
    required ReportModel report,
  });
  Future<Either<Failure, Report>> updateAssignmentFinishedAt({
    required ReportModel report,
  });
}
