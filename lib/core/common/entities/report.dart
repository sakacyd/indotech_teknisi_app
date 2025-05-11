// ignore_for_file: public_member_api_docs, sort_constructors_first
class Report {
  final String id;
  final String assignmentId;
  final DateTime technicianArrivedAt;
  final DateTime assignmentStartedAt;
  final DateTime assignmentFinishedAt;
  Report({
    required this.id,
    required this.assignmentId,
    required this.technicianArrivedAt,
    required this.assignmentStartedAt,
    required this.assignmentFinishedAt,
  });
}
