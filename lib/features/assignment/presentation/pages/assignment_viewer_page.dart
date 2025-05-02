import 'package:indotech_teknisi_app/core/theme/app_pallete.dart';
import 'package:indotech_teknisi_app/core/utils/calculate_reading_time.dart';
import 'package:indotech_teknisi_app/core/utils/format_date.dart';
import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/features/assignment/presentation/widgets/markdown/custom_markdown_body.dart';
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
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  {assignment.assignmentType} as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    text: 'By ',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppPallete.mutedTextColor,
                    ),
                    children: [
                      TextSpan(
                        text: assignment.customerName ?? '..........',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  formatDateByDMMMYYYY(assignment.scheduledAt),
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppPallete.greyColor,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  child: CachedNetworkImage(
                    imageUrl: assignment.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 30),
                CustomMarkdownBody(data: assignment.history),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
