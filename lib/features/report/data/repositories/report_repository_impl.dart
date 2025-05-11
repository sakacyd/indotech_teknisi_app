// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:indotech_teknisi_app/core/common/entities/report.dart';
import 'package:indotech_teknisi_app/core/constants/constants.dart';
import 'package:indotech_teknisi_app/core/error/exceptions.dart';
import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/core/network/connection_checker.dart';
import 'package:indotech_teknisi_app/features/report/data/datasources/report_remote_data_source.dart';
import 'package:indotech_teknisi_app/features/report/data/models/report_model.dart';
import 'package:indotech_teknisi_app/features/report/domain/repository/report_repository.dart';
import 'package:fpdart/fpdart.dart';

class ReportRepositoryImpl implements ReportRepository {
  final ReportRemoteDataSource reportRemoteDataSource;
  final ConnectionChecker connectionChecker;
  const ReportRepositoryImpl(
    this.reportRemoteDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, Report>> updateTechnicianArrivedAt({
    required ReportModel report,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(Constants.noConnectionMessage));
      }
      final updatedReport = await reportRemoteDataSource
          .updateTechnicianArrivedAt(report);
      return right(updatedReport);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Report>> updateAssignmentStartedAt({
    required ReportModel report,
  }) async {
    try {
      final updatedReport = await reportRemoteDataSource
          .updateAssignmentStartedAt(report);
      return right(updatedReport);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Report>> updateAssignmentFinishedAt({
    required ReportModel report,
  }) async {
    try {
      final updatedReport = await reportRemoteDataSource
          .updateAssignmentFinishedAt(report);
      return right(updatedReport);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
