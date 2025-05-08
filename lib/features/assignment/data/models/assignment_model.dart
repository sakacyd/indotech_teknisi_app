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
    super.assignmentTypeName,
    super.customerName,
    super.customerPhoneNumber,
    super.customerAddress,
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
      'imageUrl': imageUrl,
      'assignment_type_id': assignmentTypeId,
      'assignment_type_name': assignmentTypeName,
      'customer_name': customerName,
      'customer_phone_number': customerPhoneNumber,
      'customer_address': customerAddress,
    };
  }

  factory AssignmentModel.fromJson(Map<String, dynamic> map) {
    return AssignmentModel(
      id: map['id'] as String,
      customerId: map['customer_id'] as String,
      technicianId: map['technician_id'] as String,
      scheduledAt: DateTime.parse(map['scheduled_at']),
      unit: map['unit'] as String,
      history: map['history'] as String,
      status: map['status'] as String,
      imageUrl: map['image_url'] as String,
      assignmentTypeId: map['assignment_type_id'] as String,
      assignmentTypeName: map['assignment_type_name'] as String?,
      customerName: map['customer_name'] as String?,
      customerPhoneNumber: map['customer_phone_number'] as String?,
      customerAddress: map['customer_address'] as String?,
    );
  }

  AssignmentModel copyWith({
    String? id,
    String? customerId,
    String? technicianId,
    DateTime? scheduledAt,
    List<String>? assignmentType,
    String? unit,
    String? history,
    String? status,
    String? imageUrl,
    String? assignmentTypeId,
    String? assignmentTypeName,
    String? customerName,
    String? customerPhoneNumber,
    String? customerAddress,
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
      customerName: customerName ?? this.customerName,
      assignmentTypeName: assignmentTypeName ?? this.assignmentTypeName,
      customerPhoneNumber: customerPhoneNumber ?? this.customerPhoneNumber,
      customerAddress: customerAddress ?? this.customerAddress,
    );
  }
}
