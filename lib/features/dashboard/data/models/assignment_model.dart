import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';

class AssignmentModel extends Assignment {
  AssignmentModel({
    required super.id,
    required super.customerId,
    required super.technicianId,
    required super.scheduledAt,
    required super.unit,
    required super.history,
    required super.status,
    required super.imageUrl,
    required super.assignmentTypeId,
    required super.technicianArrivedAt,
    required super.assignmentStartedAt,
    required super.assignmentFinishedAt,
    super.assignmentTypeName,
    super.customerName,
    super.customerPhoneNumber,
    super.customerAddress,
    super.technicianName,
    super.technicianPhoneNumber,
    super.technicianAddress,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'customer_id': customerId,
      'technician_id': technicianId,
      'scheduled_at': scheduledAt.toIso8601String(),
      'unit': unit,
      'history': history,
      'status': status,
      'image_url': imageUrl,
      'assignment_type_id': assignmentTypeId,
      'technician_arrived_at': technicianArrivedAt.toIso8601String(),
      'assignment_started_at': assignmentStartedAt.toIso8601String(),
      'assignment_finished_at': assignmentFinishedAt.toIso8601String(),
    };
  }

  factory AssignmentModel.fromJson(Map<String, dynamic> json) {
    return AssignmentModel(
      id: json['id'] as String,
      customerId: json['customer_id'] as String,
      technicianId: json['technician_id'] as String,
      scheduledAt: DateTime.parse(json['scheduled_at']),
      unit: json['unit'] as String,
      history: json['history'] as String,
      status: json['status'] as String,
      imageUrl: json['image_url'] as String,
      assignmentTypeId: json['assignment_type_id'] as String,
      technicianArrivedAt: DateTime.parse(json['technician_arrived_at']),
      assignmentStartedAt: DateTime.parse(json['assignment_started_at']),
      assignmentFinishedAt: DateTime.parse(json['assignment_finished_at']),
      assignmentTypeName: json['assignment_type_name'] as String?,
      customerName: json['customer_name'] as String?,
      customerPhoneNumber: json['customer_phone_number'] as String?,
      customerAddress: json['customer_address'] as String?,
      technicianName: json['technician_name'] as String?,
      technicianPhoneNumber: json['technician_phone_number'] as String?,
      technicianAddress: json['technician_address'] as String?,
    );
  }

  AssignmentModel copyWith({
    String? id,
    String? customerId,
    String? technicianId,
    DateTime? scheduledAt,
    String? unit,
    String? history,
    String? status,
    String? imageUrl,
    String? assignmentTypeId,
    DateTime? technicianArrivedAt,
    DateTime? assignmentStartedAt,
    DateTime? assignmentFinishedAt,
    String? assignmentTypeName,
    String? customerName,
    String? customerPhoneNumber,
    String? customerAddress,
    String? technicianName,
    String? technicianPhoneNumber,
    String? technicianAddress,
  }) {
    return AssignmentModel(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      technicianId: technicianId ?? this.technicianId,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      unit: unit ?? this.unit,
      history: history ?? this.history,
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
      assignmentTypeId: assignmentTypeId ?? this.assignmentTypeId,
      technicianArrivedAt: technicianArrivedAt ?? this.technicianArrivedAt,
      assignmentStartedAt: assignmentStartedAt ?? this.assignmentStartedAt,
      assignmentFinishedAt: assignmentFinishedAt ?? this.assignmentFinishedAt,
      assignmentTypeName: assignmentTypeName ?? this.assignmentTypeName,
      customerName: customerName ?? this.customerName,
      customerPhoneNumber: customerPhoneNumber ?? this.customerPhoneNumber,
      customerAddress: customerAddress ?? this.customerAddress,
      technicianName: technicianName ?? this.technicianName,
      technicianPhoneNumber:
          technicianPhoneNumber ?? this.technicianPhoneNumber,
      technicianAddress: technicianAddress ?? this.technicianAddress,
    );
  }
}
