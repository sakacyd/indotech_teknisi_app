import 'dart:io';

import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/core/common/entities/report.dart';
import 'package:indotech_teknisi_app/features/report/domain/entities/installation_report.dart';
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
  Future<Either<Failure, Assignment>> updateAssignmentStatus({
    required String assignmentId,
  });
  Future<Either<Failure, Report>> getReportByAssignmentId({
    required String assignmentId,
  });

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
  });
}
