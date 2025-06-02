import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/core/usecase/usecase.dart';
import 'package:indotech_teknisi_app/features/report/domain/entities/survey_report.dart';
import 'package:indotech_teknisi_app/features/report/domain/repository/report_repository.dart';

class UploadSurveyReport
    implements UseCase<SurveyReport, UploadSurveyReportParams> {
  final ReportRepository reportRepository;

  UploadSurveyReport(this.reportRepository);

  @override
  Future<Either<Failure, SurveyReport>> call(
    UploadSurveyReportParams params,
  ) async {
    return await reportRepository.uploadSurveyReport(
      reportId: params.reportId,
      installationLocation: params.installationLocation,
      roofFrameType: params.roofFrameType,
      needsReinforcement: params.needsReinforcement,
      installationDirection: params.installationDirection,
      obstructedByShade: params.obstructedByShade,
      coldWaterLine: params.coldWaterLine,
      hotWaterLine: params.hotWaterLine,
      waterLineProvider: params.waterLineProvider,
      estimatedWaterLineInstallation: params.estimatedWaterLineInstallation,
      electricalCableLine: params.electricalCableLine,
      cableLineProvider: params.cableLineProvider,
      estimatedCableLineInstallation: params.estimatedCableLineInstallation,
      voltage: params.voltage,
      amperage: params.amperage,
      hertz: params.hertz,
      watt: params.watt,
      coldWaterSource: params.coldWaterSource,
      waterFromReservoir: params.waterFromReservoir,
      boosterPump: params.boosterPump,
      pressureBar: params.pressureBar,
      poolVolume: params.poolVolume,
      poolLength: params.poolLength,
      poolWidth: params.poolWidth,
      poolHeight: params.poolHeight,
      initialTemperature: params.initialTemperature,
      targetTemperature: params.targetTemperature,
      visitDate: params.visitDate,
      note: params.note,
      imageFile: params.imageFile,
      surveyorSignature: params.surveyorSignature,
      customerSignature: params.customerSignature,
    );
  }
}

class UploadSurveyReportParams {
  final int reportId;
  final String installationLocation;
  final String roofFrameType;
  final String needsReinforcement;
  final String installationDirection;
  final String obstructedByShade;
  final String coldWaterLine;
  final String hotWaterLine;
  final String waterLineProvider;
  final String estimatedWaterLineInstallation;
  final String electricalCableLine;
  final String cableLineProvider;
  final String estimatedCableLineInstallation;
  final String voltage;
  final String amperage;
  final String hertz;
  final String watt;
  final String coldWaterSource;
  final String waterFromReservoir;
  final String boosterPump;
  final String pressureBar;
  final String? poolVolume;
  final String? poolLength;
  final String? poolWidth;
  final String? poolHeight;
  final String? initialTemperature;
  final String? targetTemperature;
  final DateTime visitDate;
  final String? note;
  final File imageFile;
  final File surveyorSignature;
  final File customerSignature;

  UploadSurveyReportParams({
    required this.reportId,
    required this.installationLocation,
    required this.roofFrameType,
    required this.needsReinforcement,
    required this.installationDirection,
    required this.obstructedByShade,
    required this.coldWaterLine,
    required this.hotWaterLine,
    required this.waterLineProvider,
    required this.estimatedWaterLineInstallation,
    required this.electricalCableLine,
    required this.cableLineProvider,
    required this.estimatedCableLineInstallation,
    required this.voltage,
    required this.amperage,
    required this.hertz,
    required this.watt,
    required this.coldWaterSource,
    required this.waterFromReservoir,
    required this.boosterPump,
    required this.pressureBar,
    this.poolVolume,
    this.poolLength,
    this.poolWidth,
    this.poolHeight,
    this.initialTemperature,
    this.targetTemperature,
    required this.visitDate,
    this.note,
    required this.imageFile,
    required this.surveyorSignature,
    required this.customerSignature,
  });
}
