import 'package:google_fonts/google_fonts.dart';
import 'package:indotech_teknisi_app/core/common/entities/report.dart';
import 'package:indotech_teknisi_app/core/theme/app_pallete.dart';
import 'package:indotech_teknisi_app/core/utils/calculate_reading_time.dart';
import 'package:indotech_teknisi_app/core/utils/format_date.dart';
import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/core/common/entities/user.dart';
import 'package:indotech_teknisi_app/features/report/presentation/pages/report_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/custom_table_row.dart';

class CustomerSection extends StatelessWidget {
  final Report report;
  const CustomerSection({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final TextEditingController namaCustomerController = TextEditingController(
      text: report.customerName,
    );
    final TextEditingController noTelpController = TextEditingController(
      text: report.customerPhoneNumber,
    );
    final TextEditingController alamatController = TextEditingController(
      text: report.customerAddress,
    );
    final TextEditingController picController = TextEditingController();
    final TextEditingController noTelpPicController = TextEditingController();
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      color: AppPallete.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTextField("Nama Customer", namaCustomerController),
            _buildTextField(
              "No. Telp / HP",
              noTelpController,
              keyboardType: TextInputType.phone,
            ),
            _buildTextField("Alamat", alamatController, maxLines: 3),
            _buildTextField("PLC", picController),
            _buildTextField(
              "No. Telp / HP PLC",
              noTelpPicController,
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildTextField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: AppPallete.secondaryColor,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            style: GoogleFonts.inter(fontSize: 14, color: Colors.grey.shade800),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppPallete.accentColor),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
            ),
          ),
        ],
      ),
    );
  }
