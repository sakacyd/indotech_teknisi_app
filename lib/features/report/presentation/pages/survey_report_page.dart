import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/core/common/entities/report.dart';
import 'package:indotech_teknisi_app/features/assignment/presentation/pages/history_assignment_page.dart';
import 'package:indotech_teknisi_app/features/report/presentation/bloc/report_bloc.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/card/report_card.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/stepper/custom_stepper.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/slider/custom_action_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SurveyReportPage extends StatefulWidget {
  static route(Report report) =>
      MaterialPageRoute(builder: (context) => SurveyReportPage(report: report));

  final Report report;
  const SurveyReportPage({super.key, required this.report});

  @override
  State<SurveyReportPage> createState() => SurveyReportPageState();
}

class SurveyReportPageState extends State<SurveyReportPage> {
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
            Text('Survey Report'),
            Text('Report ID: ${widget.report.id}'),
          ],
        ),
      ),
    );
  }
}
