import 'package:flutter/material.dart';
import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/core/theme/app_pallete.dart';
import 'package:indotech_teknisi_app/core/utils/format_date.dart';

class AssignmentDetails extends StatelessWidget {
  final Assignment assignment;

  const AssignmentDetails({
    super.key,
    required this.assignment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeaderSection(),
        const SizedBox(height: 16),
        _buildDetailSection(),
        const SizedBox(height: 16),
        _buildActionButtons(context),
      ],
    );
  }

  Widget _buildHeaderSection() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              assignment.assignmentType.join(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                const SizedBox(width: 5),
                Text(
                  formatDateByddMMMMyyyy(assignment.scheduledAt),
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 15),
            _buildStatusBadge(assignment.status),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String? statusText) {
    Color statusColor;
    switch (statusText?.toLowerCase()) {
      case "selesai":
      case "done":
        statusColor = Colors.green;
        break;
      case "berjalan":
      case "on progress":
        statusColor = Colors.blue;
        break;
      case "tertunda":
      case "pending":
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        statusText ?? "Tidak Diketahui",
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDetailSection() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailItem(Icons.description, "Catatan", assignment.history),
            _buildDetailItem(Icons.location_on, "Lokasi", assignment.customerAddress ?? "Alamat tidak tersedia"),
            _buildDetailItem(Icons.people, "Customer", assignment.customerName ?? "Customer"),
            _buildDetailItem(Icons.access_time, "Waktu", formatDateByHm(assignment.scheduledAt)),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(fontSize: 14, color: AppPallete.whiteColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton("Edit", Colors.orange, () {
          // Navigasi ke edit
        }),
        _buildButton("Hapus", Colors.red, () {
          // Konfirmasi hapus
        }),
        _buildButton("Kembali", Colors.blue, () {
          Navigator.pop(context);
        }),
      ],
    );
  }

  Widget _buildButton(String label, Color color, VoidCallback onTap) {
    return SizedBox(
      width: 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onTap,
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
