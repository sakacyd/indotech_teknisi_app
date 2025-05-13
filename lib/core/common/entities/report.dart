// ignore_for_file: public_member_api_docs, sort_constructors_first
class Report {
  final int id;
  final String assignmentId;
  final DateTime? technicianArrivedAt;
  final DateTime? assignmentStartedAt;
  final DateTime? assignmentFinishedAt;
  Report({
    required this.id,
    required this.assignmentId,
    this.technicianArrivedAt,
    this.assignmentStartedAt,
    this.assignmentFinishedAt,
  });
}
