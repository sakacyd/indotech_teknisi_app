import 'package:indotech_teknisi_app/core/theme/app_pallete.dart';
import 'package:indotech_teknisi_app/core/utils/calculate_reading_time.dart';
import 'package:indotech_teknisi_app/core/utils/format_date.dart';
import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/features/assignment/presentation/widgets/markdown/custom_markdown_body.dart';
import 'package:indotech_teknisi_app/features/assignment/presentation/widgets/assignment_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AssignmentViewerPage extends StatelessWidget {
  static route(Assignment assignment) => MaterialPageRoute(
    builder: (context) => AssignmentViewerPage(assignment: assignment),
  );

  final Assignment assignment;
  const AssignmentViewerPage({super.key, required this.assignment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.backgroundColor,
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AssignmentDetails(assignment: assignment,),
          ],
        ),
      ),
    );
  }
}
