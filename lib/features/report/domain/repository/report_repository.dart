import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/core/common/entities/report.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ReportRepository {
  Future<Either<Failure, Report>> updateTechnicianArrivedAt({
    required String assignmentId,
  });
  Future<Either<Failure, Report>> updateAssignmentStartedAt({
    required String assignmentId,
  });
  Future<Either<Failure, Report>> updateAssignmentFinishedAt({
    required String assignmentId,
  });
}
