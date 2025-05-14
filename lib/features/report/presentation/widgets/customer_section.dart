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
    final TextEditingController namaCustomerController =
        TextEditingController(text: report.customerName);
    final TextEditingController noTelpController = TextEditingController(text: report.customerPhoneNumber);
    final TextEditingController alamatController = TextEditingController(text: report.customerAddress);
    final TextEditingController picController = TextEditingController();
    final TextEditingController noTelpPicController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1.5),
          1: FlexColumnWidth(0.2),
          2: FlexColumnWidth(3),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          buildCustomTableRow(
            "Nama Customer / Perusahaan",
            namaCustomerController,
          ),
          buildCustomTableRow("No. Telp / HP", noTelpController),
          buildCustomTableRow("Alamat", alamatController, maxLines: 2),
          buildCustomTableRow("P.I.C.", picController),
          buildCustomTableRow("No Telp / HP P.I.C.", noTelpPicController),
        ],
      ),
    );
  }
}
