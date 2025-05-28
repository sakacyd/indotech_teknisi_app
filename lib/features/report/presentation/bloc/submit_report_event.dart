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
