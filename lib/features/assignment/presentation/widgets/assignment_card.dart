import 'package:indotech_teknisi_app/core/theme/app_pallete.dart';
import 'package:indotech_teknisi_app/core/utils/calculate_reading_time.dart';
import 'package:indotech_teknisi_app/core/utils/format_date.dart';
import 'package:indotech_teknisi_app/features/assignment/domain/entities/assignment.dart';
import 'package:indotech_teknisi_app/features/assignment/presentation/pages/assignment_viewer_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AssignmentCard extends StatelessWidget {
  final Assignment assignment;
  const AssignmentCard({super.key, required this.assignment});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.push(context, AssignmentViewerPage.route(assignment)),
      child: CachedNetworkImage(
        imageUrl: assignment.imageUrl,
        placeholder:
            (context, url) => const Center(child: CircularProgressIndicator()),
        imageBuilder:
            (context, imageProvider) => IntrinsicHeight(
              child: Container(
                constraints: const BoxConstraints(minHeight: 270),
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 5),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 Teks di sebelah kiri
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${assignment.assignmentType} - ${assignment.customerName ?? 'Customer'}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            assignment.customerAddress ??
                                'Alamat tidak tersedia',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                formatDateByDMMMYYYY(assignment.scheduledAt),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                formatDateByHm(assignment.scheduledAt),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Image(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 100,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF64B5F6), Color(0xFFE57373)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    AssignmentViewerPage.route(assignment),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                child: const Text(
                                  "Details",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
