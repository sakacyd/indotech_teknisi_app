import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/core/common/entities/report.dart';
import 'package:indotech_teknisi_app/features/assignment/presentation/pages/history_assignment_page.dart';
import 'package:indotech_teknisi_app/features/report/presentation/bloc/report_bloc.dart';
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
  final TextEditingController notesController = TextEditingController();

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
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
