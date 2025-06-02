// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/core/common/entities/report.dart';
import 'package:indotech_teknisi_app/core/constants/constants.dart';
import 'package:indotech_teknisi_app/core/error/exceptions.dart';
import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/core/network/connection_checker.dart';
import 'package:indotech_teknisi_app/features/report/data/datasources/report_remote_data_source.dart';
import 'package:indotech_teknisi_app/features/report/data/models/inspection_item_model.dart';
import 'package:indotech_teknisi_app/features/report/data/models/installation_report_model.dart';
import 'package:indotech_teknisi_app/features/report/data/models/inspection_report_model.dart';
import 'package:indotech_teknisi_app/features/report/data/models/survey_report_model.dart';
import 'package:indotech_teknisi_app/features/report/domain/entities/inspection_item.dart';
import 'package:indotech_teknisi_app/features/report/domain/entities/installation_report.dart';
import 'package:indotech_teknisi_app/features/report/domain/entities/inspection_report.dart';
import 'package:indotech_teknisi_app/features/report/domain/entities/survey_report.dart';
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
    required File customerSignature,
    required File technicianSignature,
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
        ttdCustomer: '',
        ttdTeknisi: '',
      );

      final ttdCustomer = await reportRemoteDataSource
          .uploadInstallationReportImages(
            image: customerSignature,
            installationReport: installationReportModel,
            type: 'customer',
          );

      installationReportModel = installationReportModel.copyWith(
        ttdCustomer: ttdCustomer,
      );

      final ttdTeknisi = await reportRemoteDataSource
          .uploadInstallationReportImages(
            image: technicianSignature,
            installationReport: installationReportModel,
            type: 'technician',
          );

      installationReportModel = installationReportModel.copyWith(
        ttdTeknisi: ttdTeknisi,
      );

      final uploadedReport = await reportRemoteDataSource
          .uploadInstallationReport(installationReportModel);
      return right(uploadedReport);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
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
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(Constants.noConnectionMessage));
      }
      InspectionReportModel inspectionReportModel = InspectionReportModel(
        id: const Uuid().v1(),
        reportId: reportId,
        date: date,
        tankSerialNumber: tankSerialNumber,
        collectorSerialNumber: collectorSerialNumber,
        isUnderWarranty: isUnderWarranty,
        remarks: remarks,
        notes: notes,
        technicianSignatureUrl: '',
        customerSignatureUrl: '',
      );

      final customerSignatureUrl = await reportRemoteDataSource
          .uploadInspectionReportImages(
            image: customerSignature,
            inspectionReport: inspectionReportModel,
            type: 'customer',
          );

      inspectionReportModel = inspectionReportModel.copyWith(
        customerSignatureUrl: customerSignatureUrl,
      );

      final technicianSignatureUrl = await reportRemoteDataSource
          .uploadInspectionReportImages(
            image: technicianSignature,
            inspectionReport: inspectionReportModel,
            type: 'technician',
          );

      inspectionReportModel = inspectionReportModel.copyWith(
        technicianSignatureUrl: technicianSignatureUrl,
      );

      final uploadedReport = await reportRemoteDataSource
          .uploadInspectionReport(inspectionReportModel);

      return right(uploadedReport);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, InspectionItem>> uploadInspectionItem({
    required String inspectionReportId,
    String? itemName,
    String? condition,
    int? quantity,
    String? notes,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(Constants.noConnectionMessage));
      }
      InspectionItemModel inspectionItemModel = InspectionItemModel(
        id: const Uuid().v1(),
        inspectionReportId: inspectionReportId,
        itemName: itemName,
        condition: condition,
        quantity: quantity,
        notes: notes,
      );

      final uploadedItem = await reportRemoteDataSource.uploadInspectionItem(
        inspectionItemModel,
      );

      return right(uploadedItem);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
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
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(Constants.noConnectionMessage));
      }
      SurveyReportModel surveyReportModel = SurveyReportModel(
        id: const Uuid().v1(),
        reportId: reportId,
        installationLocation: installationLocation,
        roofFrameType: roofFrameType,
        needsReinforcement: needsReinforcement,
        installationDirection: installationDirection,
        obstructedByShade: obstructedByShade,
        coldWaterLine: coldWaterLine,
        hotWaterLine: hotWaterLine,
        waterLineProvider: waterLineProvider,
        estimatedWaterLineInstallation: estimatedWaterLineInstallation,
        electricalCableLine: electricalCableLine,
        cableLineProvider: cableLineProvider,
        estimatedCableLineInstallation: estimatedCableLineInstallation,
        voltage: voltage,
        amperage: amperage,
        hertz: hertz,
        watt: watt,
        coldWaterSource: coldWaterSource,
        waterFromReservoir: waterFromReservoir,
        boosterPump: boosterPump,
        pressureBar: pressureBar,
        poolVolume: poolVolume,
        poolLength: poolLength,
        poolWidth: poolWidth,
        poolHeight: poolHeight,
        initialTemperature: initialTemperature,
        targetTemperature: targetTemperature,
        visitDate: visitDate,
        note: note,
        imageUrl: '',
        surveyorSignatureUrl: '',
        customerSignatureUrl: '',
      );

      final imageUrl = await reportRemoteDataSource.uploadSurveyReportImages(
        image: imageFile,
        surveyReport: surveyReportModel,
        type: 'image',
      );

      surveyReportModel = surveyReportModel.copyWith(imageUrl: imageUrl);

      final customerSignatureUrl = await reportRemoteDataSource
          .uploadSurveyReportImages(
            image: customerSignature,
            surveyReport: surveyReportModel,
            type: 'customer',
          );

      surveyReportModel = surveyReportModel.copyWith(
        customerSignatureUrl: customerSignatureUrl,
      );

      final surveyorSignatureUrl = await reportRemoteDataSource
          .uploadSurveyReportImages(
            image: surveyorSignature,
            surveyReport: surveyReportModel,
            type: 'technician',
          );

      surveyReportModel = surveyReportModel.copyWith(
        surveyorSignatureUrl: surveyorSignatureUrl,
      );

      final uploadedReport = await reportRemoteDataSource.uploadSurveyReport(
        surveyReportModel,
      );

      return right(uploadedReport);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
