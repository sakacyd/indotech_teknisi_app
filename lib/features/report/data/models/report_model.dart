import 'package:indotech_teknisi_app/core/common/entities/report.dart';

class ReportModel extends Report {
  ReportModel({
    required super.id,
    required super.assignmentId,
    super.technicianArrivedAt,
    super.assignmentStartedAt,
    super.assignmentFinishedAt,
    super.unit,
    super.unitQuantity,
    super.customerName,
    super.customerPhoneNumber,
    super.customerAddress,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'assignment_id': assignmentId,
      'technician_arrived_at': technicianArrivedAt?.toIso8601String(),
      'assignment_started_at': assignmentStartedAt?.toIso8601String(),
      'assignment_finished_at': assignmentFinishedAt?.toIso8601String(),
      'unit': unit,
      'unit_quantity': unitQuantity,
      'customer_name': customerName,
      'customer_phone_number': customerPhoneNumber,
      'customer_address': customerAddress,
    };
  }

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'],
      assignmentId: json['assignment_id'] as String,
      technicianArrivedAt:
          json['technician_arrived_at'] != null
              ? DateTime.parse(json['technician_arrived_at'])
              : null,
      assignmentStartedAt:
          json['assignment_started_at'] != null
              ? DateTime.parse(json['assignment_started_at'])
              : null,
      assignmentFinishedAt:
          json['assignment_finished_at'] != null
              ? DateTime.parse(json['assignment_finished_at'])
              : null,
      unit: json['unit'] as String,
      unitQuantity: json['unit_quantity'] as String,
      customerName: json['customer_name'] as String,
      customerPhoneNumber: json['customer_phone_number'] as String,
      customerAddress: json['customer_address'] as String,
    );
  }

  ReportModel copyWith({
    int? id,
    String? assignmentId,
    DateTime? technicianArrivedAt,
    DateTime? assignmentStartedAt,
    DateTime? assignmentFinishedAt,
    String? unit,
    String? unitQuantity,
    String? customerName,
    String? customerPhoneNumber,
    String? customerAddress,
  }) {
    return ReportModel(
      id: id ?? this.id,
      assignmentId: assignmentId ?? this.assignmentId,
      technicianArrivedAt: technicianArrivedAt ?? this.technicianArrivedAt,
      assignmentStartedAt: assignmentStartedAt ?? this.assignmentStartedAt,
      assignmentFinishedAt: assignmentFinishedAt ?? this.assignmentFinishedAt,
      unit: unit ?? this.unit,
      unitQuantity: unitQuantity ?? this.unitQuantity,
      customerName: customerName ?? this.customerName,
      customerPhoneNumber: customerPhoneNumber ?? this.customerPhoneNumber,
      customerAddress: customerAddress ?? this.customerAddress,
    );
  }
}
