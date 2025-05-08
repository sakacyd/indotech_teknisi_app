import 'package:indotech_teknisi_app/core/common/widgets/custom_dialog.dart';
import 'package:indotech_teknisi_app/core/theme/app_pallete.dart';
import 'package:indotech_teknisi_app/core/utils/calculate_reading_time.dart';
import 'package:indotech_teknisi_app/core/utils/format_date.dart';
import 'package:indotech_teknisi_app/core/common/widgets/loader.dart';
import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/core/common/entities/user.dart';
import 'package:indotech_teknisi_app/features/assignment/presentation/pages/assignment_viewer_page.dart';
import 'package:indotech_teknisi_app/features/assignment/presentation/pages/history_assignment_page.dart';
import 'package:indotech_teknisi_app/features/dashboard/presentation/bloc/dashboard_viewer/viewer_bloc.dart';
import 'package:indotech_teknisi_app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:indotech_teknisi_app/features/dashboard/presentation/widgets/dashboard_viewer/card/dashboard_assignment_viewer_card.dart';
import 'package:indotech_teknisi_app/features/dashboard/presentation/widgets/dashboard_viewer/stepper/custom_stepper.dart';
import 'package:indotech_teknisi_app/features/dashboard/presentation/widgets/markdown/custom_markdown_body.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indotech_teknisi_app/features/dashboard/presentation/widgets/dashboard_viewer/slider/custom_action_slider.dart';

class DashboardViewerPage extends StatefulWidget {
  static route(Assignment assignment) => MaterialPageRoute(
    builder: (context) => DashboardViewerPage(assignment: assignment),
  );

  final Assignment assignment;
  const DashboardViewerPage({super.key, required this.assignment});

  @override
  State<DashboardViewerPage> createState() => _DashboardViewerPageState();
}

class _DashboardViewerPageState extends State<DashboardViewerPage> {
  @override
  void initState() {
    super.initState();
    context.read<ViewerBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<ViewerBloc, ViewerState>(
        listener: (context, state) {
          if (state is ViewerCompleted) {
            Navigator.pushAndRemoveUntil(
              context,
              HistoryAssignmentPage.route(),
              (Route<dynamic> route) => false,
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<ViewerBloc, ViewerState>(
                  builder: (context, state) {
                    int currentStep = 0;
                    if (state is StepperChanged) {
                      currentStep = state.currentStep;
                    }
                    return CustomStepper(currentStep: currentStep);
                  },
                ),
                DashboardAssignmentViewerCard(assignment: widget.assignment),
                Builder(
                  builder: (context) {
                    final state = context.watch<ViewerBloc>().state;
                    int currentStep = 0;
                    String text = "Konfirmasi teknisi sudah sampai lokasi";

                    if (state is StepperChanged) {
                      currentStep = state.currentStep;
                      if (currentStep == 1) {
                        text = "Konfirmasi pekerjaan sudah dimulai";
                      } else if (currentStep == 2) {
                        text = "Konfirmasi pekerjaan sudah selesai";
                      } else if (currentStep >= 3) {
                        context.read<ViewerBloc>().add(CompleteViewer());
                      }
                    }

                    return CustomActionSlider(
                      text: text,
                      onSuccess: () {
                        context.read<ViewerBloc>().add(
                          ChangeStep(currentStep + 1),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
