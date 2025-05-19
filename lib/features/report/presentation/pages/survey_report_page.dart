import 'package:indotech_teknisi_app/core/common/entities/report.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/customer_info_widget.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/product_info_widget.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/signature_section.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/location_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SurveyReportPage extends StatefulWidget {
  static route(Report report) =>
      MaterialPageRoute(builder: (context) => SurveyReportPage(report: report));

  final Report report;
  const SurveyReportPage({super.key, required this.report});

  @override
  State<SurveyReportPage> createState() => SurveyReportPageState();
}

class SurveyReportPageState extends State<SurveyReportPage> {
  Map<String, dynamic> surveyData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Berita Acara Survey")),
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
                      LocationSelectionWidget(
                        onChanged: (data) {
                          setState(() {
                            surveyData = data;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text('Instalasi Pemipaan & Kelistrikan',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      CheckboxListTile(
                        title: const Text('Jalur pemipaan air dingin tersedia'),
                        value: surveyData['hasColdWaterPipe'] ?? false,
                        onChanged: (value) {
                          setState(() {
                            surveyData['hasColdWaterPipe'] = value;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Jalur pemipaan air panas tersedia'),
                        value: surveyData['hasHotWaterPipe'] ?? false,
                        onChanged: (value) {
                          setState(() {
                            surveyData['hasHotWaterPipe'] = value;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Jalur kabel listrik untuk backup Element Heating tersedia'),
                        value: surveyData['hasElectricalBackup'] ?? false,
                        onChanged: (value) {
                          setState(() {
                            surveyData['hasElectricalBackup'] = value;
                          });
                        },
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
                      const Text('Sumber Air',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                              title: const Text('PAM'),
                              value: 'PAM',
                              groupValue: surveyData['waterSource'],
                              onChanged: (value) {
                                setState(() {
                                  surveyData['waterSource'] = value;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              title: const Text('Sumur'),
                              value: 'SUMUR',
                              groupValue: surveyData['waterSource'],
                              onChanged: (value) {
                                setState(() {
                                  surveyData['waterSource'] = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              /* const SignatureSection(
                leftTitle: 'Surveyor',
                rightTitle: 'Customer',
              ), */
            ],
          ),
        ),
      ),
    );
  }
}
