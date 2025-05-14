// ignore_for_file: public_member_api_docs, sort_constructors_first
class Report {
  final int id;
  final String assignmentId;
  final DateTime? technicianArrivedAt;
  final DateTime? assignmentStartedAt;
  final DateTime? assignmentFinishedAt;
  final String? unit;
  final String? unitQuantity;
  final String? customerName;
  final String? customerPhoneNumber;
  final String? customerAddress;
  Report({
    required this.id,
    required this.assignmentId,
    this.technicianArrivedAt,
    this.assignmentStartedAt,
    this.assignmentFinishedAt,
    this.unit,
    this.unitQuantity,
    this.customerName,
    this.customerPhoneNumber,
    this.customerAddress,
  });
}
