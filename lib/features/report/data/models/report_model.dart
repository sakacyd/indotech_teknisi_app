import 'package:indotech_teknisi_app/core/common/entities/report.dart';

class ReportModel extends Report {
  ReportModel({
    required super.id,
    required super.assignmentId,
    super.technicianArrivedAt,
    super.assignmentStartedAt,
    super.assignmentFinishedAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'assignment_id': assignmentId,
      'technician_arrived_at': technicianArrivedAt?.toIso8601String(),
      'assignment_started_at': assignmentStartedAt?.toIso8601String(),
      'assignment_finished_at': assignmentFinishedAt?.toIso8601String(),
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
    );
  }

  ReportModel copyWith({
    int? id,
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
