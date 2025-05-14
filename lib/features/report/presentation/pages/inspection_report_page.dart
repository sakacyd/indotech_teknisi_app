import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/core/common/entities/report.dart';
import 'package:indotech_teknisi_app/features/assignment/presentation/pages/history_assignment_page.dart';
import 'package:indotech_teknisi_app/features/report/presentation/bloc/report_bloc.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/card/report_card.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/stepper/custom_stepper.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/slider/custom_action_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InspectionReportPage extends StatefulWidget {
  static route(Report report) => MaterialPageRoute(
    builder: (context) => InspectionReportPage(report: report),
  );

  final Report report;
  const InspectionReportPage({super.key, required this.report});

  @override
  State<InspectionReportPage> createState() => InspectionReportPageState();
}

class InspectionReportPageState extends State<InspectionReportPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Biar column gak memenuhi layar
          children: [
            Text('Inspection Report'),
            Text('Report ID: ${widget.report.id}'),
          ],
        ),
      ),
    );
  }
}
