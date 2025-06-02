import 'dart:io';

import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/core/common/entities/report.dart';
import 'package:indotech_teknisi_app/features/report/domain/entities/installation_report.dart';
import 'package:indotech_teknisi_app/features/report/domain/entities/inspection_report.dart';
import 'package:indotech_teknisi_app/features/report/domain/entities/inspection_item.dart';
import 'package:fpdart/fpdart.dart';
import 'package:indotech_teknisi_app/features/report/domain/entities/survey_report.dart';

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
    required File customerSignature,
    required File technicianSignature,
  });

  Future<Either<Failure, InspectionReport>> uploadInspectionReport({
    required int reportId,
    required DateTime date,
    required String tankSerialNumber,
    required String collectorSerialNumber,
    required String isUnderWarranty,
    required String remarks,
    String? notes,
    required File customerSignature,
    required File technicianSignature,
  });

  Future<Either<Failure, InspectionItem>> uploadInspectionItem({
    required String inspectionReportId,
    String? itemName,
    String? condition,
    int? quantity,
    String? notes,
  });

  Future<Either<Failure, SurveyReport>> uploadSurveyReport({
    required int reportId,
    required String installationLocation,
    required String roofFrameType,
    required String needsReinforcement,
    required String installationDirection,
    required String obstructedByShade,
    required String coldWaterLine,
    required String hotWaterLine,
    required String waterLineProvider,
    required String estimatedWaterLineInstallation,
    required String electricalCableLine,
    required String cableLineProvider,
    required String estimatedCableLineInstallation,
    required String voltage,
    required String amperage,
    required String hertz,
    required String watt,
    required String coldWaterSource,
    required String waterFromReservoir,
    required String boosterPump,
    required String pressureBar,
    String? poolVolume,
    String? poolLength,
    String? poolWidth,
    String? poolHeight,
    String? initialTemperature,
    String? targetTemperature,
    required DateTime visitDate,
    String? note,
    required File imageFile,
    required File surveyorSignature,
    required File customerSignature,
  });
}
