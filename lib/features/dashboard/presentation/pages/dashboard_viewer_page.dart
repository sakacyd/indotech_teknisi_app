import 'package:indotech_teknisi_app/core/theme/app_pallete.dart';
import 'package:indotech_teknisi_app/core/utils/calculate_reading_time.dart';
import 'package:indotech_teknisi_app/core/utils/format_date.dart';
import 'package:indotech_teknisi_app/core/common/widgets/loader.dart';
import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/core/common/entities/user.dart';
import 'package:indotech_teknisi_app/features/assignment/presentation/pages/assignment_viewer_page.dart';
import 'package:indotech_teknisi_app/features/assignment/presentation/pages/history_assignment_page.dart';
import 'package:indotech_teknisi_app/features/dashboard/presentation/bloc/dashboard_viewer_bloc/viewer_bloc.dart';
import 'package:indotech_teknisi_app/features/dashboard/presentation/widgets/details/card/dashboard_assignment_viewer_card.dart';
import 'package:indotech_teknisi_app/features/dashboard/presentation/widgets/details/custom_stepper.dart';
import 'package:indotech_teknisi_app/features/dashboard/presentation/widgets/markdown/custom_markdown_body.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indotech_teknisi_app/features/dashboard/presentation/widgets/details/slider/custom_action_slider.dart';

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
      body: BlocConsumer<ViewerBloc, ViewerState>(
        listener: (context, state) {
          if (state is ViewerCompleted) {
            Navigator.push(context, HistoryAssignmentPage.route());
          }
        },
        builder: (context, state) {
          int currentStep = 0;
          String text = "";
          if (state is ViewerLoading) {
            return const Loader();
          } else if (state is StepperChanged) {
            currentStep = state.currentStep;
            text = "Tes";
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomStepper(currentStep: currentStep),
                  DashboardAssignmentViewerCard(assignment: widget.assignment),
                  const SizedBox(height: 20),
                  CustomActionSlider(text: text),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
