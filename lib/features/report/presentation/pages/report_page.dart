import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/features/report/presentation/bloc/report_bloc.dart';
import 'package:indotech_teknisi_app/features/report/presentation/pages/get_report_page_route.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/card/report_card.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/stepper/custom_stepper.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/slider/custom_action_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportPage extends StatefulWidget {
  static route(Assignment assignment) => MaterialPageRoute(
    builder: (context) => ReportPage(assignment: assignment),
  );

  final Assignment assignment;
  const ReportPage({super.key, required this.assignment});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  void initState() {
    super.initState();
    context.read<ReportBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<ReportBloc, ReportState>(
        listener: (context, state) {
          if (state is ReportCompleted) {
            final assignment = widget.assignment;
            final report = state.report;
            Navigator.pushAndRemoveUntil(
              context,
              getReportPageRoute(assignment, report),
              (route) => false,
            );
          }
        },
        child: BlocBuilder<ReportBloc, ReportState>(
          builder: (context, state) {
            final currentStep = state.currentStep;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomStepper(currentStep: currentStep),
                    ReportCard(assignment: widget.assignment),
                    const SizedBox(height: 16),
                    CustomActionSlider(
                      text: _getButtonText(currentStep),
                      onSuccess: () {
                        final bloc = context.read<ReportBloc>();
                        final id = widget.assignment.id;

                        if (currentStep == 0) {
                          bloc.add(UpdateArrived(id));
                        } else if (currentStep == 1) {
                          bloc.add(UpdateStarted(id));
                        } else if (currentStep == 2) {
                          bloc.add(UpdateFinished(id));
                          /* bloc.add(UpdateStatus(id)); */ //TODO: uncomment
                          bloc.add(CompleteReport(id));
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _getButtonText(int step) {
    switch (step) {
      case 0:
        return "Konfirmasi teknisi sudah sampai lokasi";
      case 1:
        return "Konfirmasi pekerjaan sudah dimulai";
      case 2:
        return "Konfirmasi pekerjaan sudah selesai";
      default:
        return "Selesai";
    }
  }
}
