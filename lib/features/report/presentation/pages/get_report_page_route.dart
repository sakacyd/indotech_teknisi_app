import 'package:flutter/material.dart';
import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/core/common/entities/report.dart';
import 'package:indotech_teknisi_app/features/report/presentation/pages/survey_report_page.dart';
import 'package:indotech_teknisi_app/features/report/presentation/pages/installation_report_page.dart';
import 'package:indotech_teknisi_app/features/report/presentation/pages/inspection_report_page.dart';

Route<dynamic> getReportPageRoute(Assignment assignment, Report report) {
  final type = assignment.assignmentTypeName?.toLowerCase();

  switch (type) {
    case 'survey':
      return SurveyReportPage.route(report);
    case 'pemasangan & serah terima unit':
      return InstallationReportPage.route(report);
    case 'pengecekan':
      return InspectionReportPage.route(report);
    default:
      // fallback jika tidak dikenali
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text("Unknown Report Type")),
          body: Center(child: Text("Tipe pekerjaan tidak dikenal: $type")),
        ),
      );
  }
}
