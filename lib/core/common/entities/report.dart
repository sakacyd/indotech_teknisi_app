// ignore_for_file: public_member_api_docs, sort_constructors_first
class Assignment {
  final String id;
  final String customerId;
  final String technicianId;
  final DateTime scheduledAt;
  final String unit;
  final String history;
  final String status;
  final String imageUrl;
  final String assignmentTypeId;
  final DateTime technicianArrivedAt;
  final DateTime assignmentStartedAt;
  final DateTime assignmentFinishedAt;
  final String? assignmentTypeName;
  final String? customerName;
  final String? customerPhoneNumber;
  final String? customerAddress;
  final String? technicianName;
  final String? technicianPhoneNumber;
  final String? technicianAddress;
  Assignment({
    required this.id,
    required this.customerId,
    required this.technicianId,
    required this.scheduledAt,
    required this.unit,
    required this.history,
    required this.status,
    required this.imageUrl,
    required this.assignmentTypeId,
    required this.technicianArrivedAt,
    required this.assignmentStartedAt,
    required this.assignmentFinishedAt,
    this.assignmentTypeName,
    this.customerName,
    this.customerPhoneNumber,
    this.customerAddress,
    this.technicianName,
    this.technicianPhoneNumber,
    this.technicianAddress,
  });
}
