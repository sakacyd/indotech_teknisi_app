import 'package:indotech_teknisi_app/features/report/domain/entities/inspection_report.dart';

class InspectionReportModel extends InspectionReport {
  InspectionReportModel({
    required super.id,
    required super.reportId,
    required super.date,
    required super.tankSerialNumber,
    required super.collectorSerialNumber,
    required super.isUnderWarranty,
    required super.remarks,
    super.notes,
    required super.technicianSignatureUrl,
    required super.customerSignatureUrl,
  });

  factory InspectionReportModel.fromJson(Map<String, dynamic> json) {
    return InspectionReportModel(
      id: json['id'] as String,
      reportId: json['report_id'] as int,
      date: DateTime.parse(json['date']),
      tankSerialNumber: json['tank_serial_number'] as String,
      collectorSerialNumber: json['collector_serial_number'] as String,
      isUnderWarranty: json['is_under_warranty'] as String,
      remarks: json['remarks'] as String,
      notes: json['notes'] as String?,
      technicianSignatureUrl: json['technician_signature_url'] as String,
      customerSignatureUrl: json['customer_signature_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'report_id': reportId,
      'date': date.toIso8601String(),
      'tank_serial_number': tankSerialNumber,
      'collector_serial_number': collectorSerialNumber,
      'is_under_warranty': isUnderWarranty,
      'remarks': remarks,
      'notes': notes,
      'technician_signature_url': technicianSignatureUrl,
      'customer_signature_url': customerSignatureUrl,
    };
  }

  InspectionReportModel copyWith({
    String? id,
    int? reportId,
    DateTime? date,
    String? tankSerialNumber,
    String? collectorSerialNumber,
    String? isUnderWarranty,
    String? remarks,
    String? notes,
    String? technicianSignatureUrl,
    String? customerSignatureUrl,
  }) {
    return InspectionReportModel(
      id: id ?? this.id,
      reportId: reportId ?? this.reportId,
      date: date ?? this.date,
      tankSerialNumber: tankSerialNumber ?? this.tankSerialNumber,
      collectorSerialNumber:
          collectorSerialNumber ?? this.collectorSerialNumber,
      isUnderWarranty: isUnderWarranty ?? this.isUnderWarranty,
      remarks: remarks ?? this.remarks,
      notes: notes ?? this.notes,
      technicianSignatureUrl:
          technicianSignatureUrl ?? this.technicianSignatureUrl,
      customerSignatureUrl: customerSignatureUrl ?? this.customerSignatureUrl,
    );
  }
}
