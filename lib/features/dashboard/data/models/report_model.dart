import 'package:indotech_teknisi_app/core/common/entities/report.dart';

class ReportModel extends Report {
  ReportModel({
    required super.id,
    required super.assignmentId,
    required super.technicianArrivedAt,
    required super.assignmentStartedAt,
    required super.assignmentFinishedAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'assignment_id': assignmentId,
      'technician_arrived_at': technicianArrivedAt.toIso8601String(),
      'assignment_started_at': assignmentStartedAt.toIso8601String(),
      'assignment_finished_at': assignmentFinishedAt.toIso8601String(),
    };
  }

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'] as String,
      assignmentId: json['assignment_id'] as String,
      technicianArrivedAt: DateTime.parse(json['technician_arrived_at']),
      assignmentStartedAt: DateTime.parse(json['assignment_started_at']),
      assignmentFinishedAt: DateTime.parse(json['assignment_finished_at']),
    );
  }

  ReportModel copyWith({
    String? id,
    String? assignmentId,
    DateTime? technicianArrivedAt,
    DateTime? assignmentStartedAt,
    DateTime? assignmentFinishedAt,
  }) {
    return ReportModel(
      id: id ?? this.id,
      assignmentId: assignmentId ?? this.assignmentId,
      technicianArrivedAt: technicianArrivedAt ?? this.technicianArrivedAt,
      assignmentStartedAt: assignmentStartedAt ?? this.assignmentStartedAt,
      assignmentFinishedAt: assignmentFinishedAt ?? this.assignmentFinishedAt,
    );
  }
}
