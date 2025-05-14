import 'package:indotech_teknisi_app/core/common/entities/report.dart';
import 'package:indotech_teknisi_app/core/theme/app_pallete.dart';
import 'package:indotech_teknisi_app/core/utils/calculate_reading_time.dart';
import 'package:indotech_teknisi_app/core/utils/format_date.dart';
import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/features/report/presentation/pages/report_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AssignmentCard extends StatelessWidget {
  final Assignment assignment;
  const AssignmentCard({super.key, required this.assignment});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Informasi assignment di kiri
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${assignment.assignmentTypeName} - ${assignment.customerName}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    assignment.customerAddress ?? "Alamat customer tidak tersedia",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
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
                        formatDateByddMMMMyyyy(assignment.scheduledAt),
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

            // 🔹 Gambar & Tombol di kanan
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: assignment.imageUrl ?? "",
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    placeholder:
                        (context, url) => const SizedBox(
                          width: 100,
                          height: 100,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                    errorWidget:
                        (context, url, error) => const Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 100,
                  height: 35,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 0,
                      side: const BorderSide(color: Colors.grey),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        ReportPage.route(assignment),
                      );
                    },
                    child: const Text(
                      "Details",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
