part of 'submit_report_bloc.dart';

@immutable
sealed class SubmitReportEvent {}

final class InstallationReportSubmit extends SubmitReportEvent {
  final int reportId;
  final String nomorSeriTangki;
  final String nomorSeriKolektor;
  final String pemasangan;
  final String tangki;
  final String collector;
  final String elementHeating;
  final String thermostat;
  final String safetyValve;
  final String kabelListrik;
  final String pipa;
  final String dinabolt;
  final String? alasan;
  final DateTime tanggal;
  final String materialDari;
  final String instalasiOleh;
  final String? note;
  final File technicianSignature;
  final File customerSignature;

  InstallationReportSubmit({
    required this.reportId,
    required this.nomorSeriTangki,
    required this.nomorSeriKolektor,
    required this.pemasangan,
    required this.tangki,
    required this.collector,
    required this.elementHeating,
    required this.thermostat,
    required this.safetyValve,
    required this.kabelListrik,
    required this.pipa,
    required this.dinabolt,
    this.alasan,
    required this.tanggal,
    required this.materialDari,
    required this.instalasiOleh,
    this.note,
    required this.technicianSignature,
    required this.customerSignature,
  });
}

final class InspectionReportSubmit extends SubmitReportEvent {
  final int reportId;
  final DateTime date;
  final String tankSerialNumber;
  final String collectorSerialNumber;
  final String isUnderWarranty;
  final String remarks;
  final String? notes;
  final File technicianSignature;
  final File customerSignature;
  final List<InspectionItem> inspectionItems;

  InspectionReportSubmit({
    required this.reportId,
    required this.date,
    required this.tankSerialNumber,
    required this.collectorSerialNumber,
    required this.isUnderWarranty,
    required this.remarks,
    this.notes,
    required this.technicianSignature,
    required this.customerSignature,
    required this.inspectionItems,
  });
}

final class InspectionItemSubmit extends SubmitReportEvent {
  final String inspectionReportId;
  final String? itemName;
  final String? condition;
  final int? quantity;
  final String? notes;

  InspectionItemSubmit({
    required this.inspectionReportId,
    this.itemName,
    this.condition,
    this.quantity,
    this.notes,
  });
}

final class SurveyReportSubmit extends SubmitReportEvent {
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

  SurveyReportSubmit({
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
