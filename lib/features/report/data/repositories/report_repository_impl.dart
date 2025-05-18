// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/core/common/entities/report.dart';
import 'package:indotech_teknisi_app/core/constants/constants.dart';
import 'package:indotech_teknisi_app/core/error/exceptions.dart';
import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/core/network/connection_checker.dart';
import 'package:indotech_teknisi_app/features/report/data/datasources/report_remote_data_source.dart';
import 'package:indotech_teknisi_app/features/report/data/models/installation_report_model.dart';
import 'package:indotech_teknisi_app/features/report/domain/entities/installation_report.dart';
import 'package:indotech_teknisi_app/features/report/domain/repository/report_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class ReportRepositoryImpl implements ReportRepository {
  final ReportRemoteDataSource reportRemoteDataSource;
  final ConnectionChecker connectionChecker;
  const ReportRepositoryImpl(
    this.reportRemoteDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, Report>> updateTechnicianArrivedAt({
    required String assignmentId,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(Constants.noConnectionMessage));
      }

      final updatedReport = await reportRemoteDataSource
          .updateTechnicianArrivedAt(assignmentId);

      return right(updatedReport);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Report>> updateAssignmentStartedAt({
    required String assignmentId,
  }) async {
    try {
      final updatedReport = await reportRemoteDataSource
          .updateAssignmentStartedAt(assignmentId);
      return right(updatedReport);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Report>> updateAssignmentFinishedAt({
    required String assignmentId,
  }) async {
    try {
      final updatedReport = await reportRemoteDataSource
          .updateAssignmentFinishedAt(assignmentId);
      return right(updatedReport);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Assignment>> updateAssignmentStatus({
    required String assignmentId,
  }) async {
    try {
      final updatedAssignment = await reportRemoteDataSource
          .updateAssignmentStatus(assignmentId);
      return right(updatedAssignment);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Report>> getReportByAssignmentId({
    required String assignmentId,
  }) async {
    try {
      final report = await reportRemoteDataSource.getReportByAssignmentId(
        assignmentId,
      );
      return right(report);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, InstallationReport>> uploadInstallationReport({
    required int reportId,
    required String nomorSeriTangki,
    required String nomorSeriKolektor,
    required String pemasangan,
    required String tangki,
    required String collector,
    required String elementHeating,
    required String thermostat,
    required String safetyValve,
    required String kabelListrik,
    required String pipa,
    required String dinabolt,
    required String? alasan,
    required DateTime tanggal,
    required String materialDari,
    required String instalasiOleh,
    required String? note,
    required File technicianSignature,
    required File customerSignature,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(Constants.noConnectionMessage));
      }
      InstallationReportModel installationReportModel = InstallationReportModel(
        id: const Uuid().v1(),
        reportId: reportId,
        nomorSeriTangki: nomorSeriTangki,
        nomorSeriKolektor: nomorSeriKolektor,
        pemasangan: pemasangan,
        tangki: tangki,
        collector: collector,
        elementHeating: elementHeating,
        thermostat: thermostat,
        safetyValve: safetyValve,
        kabelListrik: kabelListrik,
        pipa: pipa,
        dinabolt: dinabolt,
        alasan: alasan,
        tanggal: DateTime.now(),
        materialDari: materialDari,
        instalasiOleh: instalasiOleh,
        note: note,
        ttdTeknisi: '',
        ttdCustomer: '',
      );

      final ttdTeknisi = await reportRemoteDataSource
          .uploadInstallationReportImages(
            image: technicianSignature,
            installationReport: installationReportModel,
          );

      installationReportModel = installationReportModel.copyWith(
        ttdTeknisi: ttdTeknisi,
      );

      final ttdCustomer = await reportRemoteDataSource
          .uploadInstallationReportImages(
            image: customerSignature,
            installationReport: installationReportModel,
          );

      installationReportModel = installationReportModel.copyWith(
        ttdCustomer: ttdCustomer,
      );

      final uploadedReport = await reportRemoteDataSource
          .uploadInstallationReport(installationReportModel);
      return right(uploadedReport);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
