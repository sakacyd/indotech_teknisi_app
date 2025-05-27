import 'dart:io';
import 'dart:typed_data';

import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/core/common/entities/report.dart';
import 'package:indotech_teknisi_app/features/assignment/presentation/pages/history_assignment_page.dart';
import 'package:indotech_teknisi_app/features/report/presentation/bloc/report_bloc.dart';
import 'package:indotech_teknisi_app/features/report/presentation/bloc/submit_report_bloc.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/card/report_card.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/customer_section.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/stepper/custom_stepper.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/slider/custom_action_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indotech_teknisi_app/core/common/entities/report.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/customer_info_widget.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/product_info_widget.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/signature_section.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/inspection_checklist_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

class InspectionReportPage extends StatefulWidget {
  static route(Report report) => MaterialPageRoute(
    builder: (context) => InspectionReportPage(report: report),
  );

  final Report report;
  const InspectionReportPage({super.key, required this.report});

  @override
  State<InspectionReportPage> createState() => InspectionReportPageState();
}

class InspectionReportPageState extends State<InspectionReportPage> {
  Map<String, dynamic> inspectionData = {};
  bool isUnderWarranty = false;
  final namaCustomerController = TextEditingController();
  final namaTeknisiController = TextEditingController();
  final noTelpController = TextEditingController();
  final alamatController = TextEditingController();
  final picController = TextEditingController();
  final noTelpPicController = TextEditingController();
  final namaProdukController = TextEditingController();
  final jumlahController = TextEditingController();
  final nomorSeriTangkiController = TextEditingController();
  final nomorSeriKolektorController = TextEditingController();
  final remarksController = TextEditingController();
  final notesController = TextEditingController();

  final SignatureController _technicianSignatureController =
      SignatureController(
        penStrokeWidth: 3,
        penColor: Colors.black,
        exportBackgroundColor: Colors.white,
      );

  final SignatureController _customerSignatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  Uint8List? _customerSignatureBytes;
  Uint8List? _technicianSignatureBytes;

  final formKey = GlobalKey<FormState>();

  Future<File> saveSignatureToFile(Uint8List bytes, String filename) async {
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/$filename.png');
    return await file.writeAsBytes(bytes);
  }

  bool _validateWarranty() {
    final warrantyTrue = inspectionData['warrantyTrue'] ?? false;
    final warrantyFalse = inspectionData['warrantyFalse'] ?? false;

    if (!(warrantyTrue || warrantyFalse)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih minimal satu opsi Garansi')),
      );
      return false;
    }

    return true;
  }

  void uploadInspectionReport() async {
    if (!formKey.currentState!.validate()) return;

    if (!_validateWarranty()) return;

    if (_customerSignatureBytes == null || _technicianSignatureBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tanda tangan belum lengkap')),
      );
      return;
    }
    final technicianFile = await saveSignatureToFile(
      _technicianSignatureBytes!,
      'technician_signature',
    );
    final customerFile = await saveSignatureToFile(
      _customerSignatureBytes!,
      'customer_signature',
    );

    context.read<SubmitReportBloc>().add(
      InspectionReportSubmit(
        reportId: widget.report.id,
        date: DateTime.now(),
        tankSerialNumber: nomorSeriTangkiController.text,
        collectorSerialNumber: nomorSeriKolektorController.text,
        isUnderWarranty:
            inspectionData['warrantyTrue'] == true
                ? 'Ya'
                : 'Tidak',
        remarks: remarksController.text,
        notes: notesController.text,
        technicianSignature: technicianFile,
        customerSignature: customerFile,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Berita Acara Pengecekan")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomerInfoWidget(report: widget.report),
              const SizedBox(height: 16),
              ProductInfoWidget(report: widget.report),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Dalam Masa Garansi',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 16),
                          Switch(
                            value: isUnderWarranty,
                            onChanged: (value) {
                              setState(() {
                                isUnderWarranty = value;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: notesController,
                        decoration: const InputDecoration(
                          labelText: 'Keterangan/Keluhan',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hasil Pemeriksaan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      InspectionChecklistWidget(
                        onChanged: (checklist) {
                          setState(() {
                            inspectionData['checklist'] = checklist;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              /*  const SignatureSection(
                leftTitle: 'Teknisi',
                rightTitle: 'Customer',
              ), */
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }
}
