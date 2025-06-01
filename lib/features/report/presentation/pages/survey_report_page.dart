import 'dart:io';
import 'dart:typed_data';

import 'package:indotech_teknisi_app/core/common/entities/report.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/customer_info_widget.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/info_field.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/installation_section.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/product_info_widget.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/signature_section.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/location_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/submit_report_card.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

class SurveyReportPage extends StatefulWidget {
  static route(Report report) =>
      MaterialPageRoute(builder: (context) => SurveyReportPage(report: report));

  final Report report;
  const SurveyReportPage({super.key, required this.report});

  @override
  State<SurveyReportPage> createState() => SurveyReportPageState();
}

class SurveyReportPageState extends State<SurveyReportPage> {
  Map<String, dynamic> surveyData = {
    'surveyLocation': {'arahPemasangan': null, 'apakahPerluDiperkuat': null},
    'installationData': {'jalurAirDingin': null, 'apakahPerluDiperkuat': null},
  };

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
  final noteController = TextEditingController();

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

  void uploadInspectionReport() async {
    if (!formKey.currentState!.validate()) return;

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

    /*     context.read<SubmitReportBloc>().add(
      InspectionReportSubmit(
        reportId: widget.report.id,
        date: DateTime.now(),
        tankSerialNumber: nomorSeriTangkiController.text,
        collectorSerialNumber: nomorSeriKolektorController.text,
        isUnderWarranty: isUnderWarranty ? 'Ya' : 'Tidak',
        remarks: remarksController.text,
        notes: notesController.text,
        technicianSignature: technicianFile,
        customerSignature: customerFile,
        inspectionItems: inspectionItems,
      ),
    ); */
  }

  @override
  void dispose() {
    _technicianSignatureController.dispose();
    _customerSignatureController.dispose();
    namaTeknisiController.dispose();
    namaCustomerController.dispose();
    noTelpController.dispose();
    alamatController.dispose();
    namaProdukController.dispose();
    jumlahController.dispose();
    nomorSeriTangkiController.dispose();
    nomorSeriKolektorController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    namaTeknisiController.text = widget.report.technicianName ?? '';
    namaCustomerController.text = widget.report.customerName ?? '';
    noTelpController.text = widget.report.customerPhoneNumber ?? '';
    alamatController.text = widget.report.customerAddress ?? '';
    namaProdukController.text = widget.report.unit ?? '';
    jumlahController.text = widget.report.unitQuantity ?? '';
    nomorSeriTangkiController.text = '';
    nomorSeriKolektorController.text = '';
    noteController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Berita Acara Survey")),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SubmitReportCard(
                  title: 'Customer',
                  children: [
                    InfoField(
                      controller: namaCustomerController,
                      label: 'Nama Customer',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Nama Customer wajib diisi';
                        }
                        return null;
                      },
                    ),
                    InfoField(
                      controller: noTelpController,
                      label: 'No. Telp / HP',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'No. Telp / HP wajib diisi';
                        }
                        return null;
                      },
                    ),
                    InfoField(
                      controller: alamatController,
                      label: 'Alamat',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Alamat wajib diisi';
                        }
                        return null;
                      },
                      maxLines: 3,
                    ),
                    InfoField(
                      controller: picController,
                      label: 'PIC',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'PIC wajib diisi';
                        }
                        return null;
                      },
                    ),
                    InfoField(
                      controller: noTelpPicController,
                      label: 'No Telp / HP PIC',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'No Telp / HP PIC wajib diisi';
                        }
                        return null;
                      },
                    ),
                    InfoField(
                      controller: namaProdukController,
                      label: 'Nama Produk / Unit',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Nama Produk / Unit wajib diisi';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SubmitReportCard(
                  title: 'Lokasi',
                  children: [
                    const Text(
                      'Lokasi Pemasangan',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    InstallationSection(
                      initialValue:
                          surveyData['surveyLocation']?['lokasiPemasangan'],
                      onChanged: (value) {
                        setState(() {
                          surveyData['surveyLocation']?['lokasiPemasangan'] =
                              value;
                        });
                      },
                      options: ['Genteng', 'Dak'],
                      label: 'Isi lokasi lain',
                      otherOptionLabel: 'Lainnya',
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Jenis Rangka Genteng',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    InstallationSection(
                      initialValue:
                          surveyData['surveyLocation']?['jenisRangkaGenteng'],
                      onChanged: (value) {
                        setState(() {
                          surveyData['surveyLocation']?['jenisRangkaGenteng'] =
                              value;
                        });
                      },
                      options: ['Kayu', 'Baja Ringan'],
                      label: 'Isi rangka lain',
                      otherOptionLabel: 'Rangka lainnya, ...',
                    ),
                    const SizedBox(height: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Apakah perlu diperkuat?',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 16,
                          runSpacing: 8,
                          children: [
                            for (final value in ['Ya', 'Tidak'])
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                    value:
                                        surveyData['surveyLocation']['apakahPerluDiperkuat'] ==
                                        value,
                                    onChanged: (_) {
                                      setState(() {
                                        surveyData['surveyLocation']['apakahPerluDiperkuat'] =
                                            value;
                                      });
                                    },
                                  ),
                                  Text(value),
                                ],
                              ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Arah Pemasangan',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 16,
                          runSpacing: 8,
                          children: [
                            for (final arah in [
                              'Utara',
                              'Selatan',
                              'Timur',
                              'Barat',
                            ])
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                    value:
                                        surveyData['surveyLocation']['arahPemasangan'] ==
                                        arah,
                                    onChanged: (_) {
                                      setState(() {
                                        surveyData['surveyLocation']['arahPemasangan'] =
                                            arah;
                                      });
                                    },
                                  ),
                                  Text(arah),
                                ],
                              ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Terhalang bayangan seperti pohon, gedung, dll?',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    InstallationSection(
                      initialValue:
                          surveyData['surveyLocation']?['terhalangBayangan'],
                      onChanged: (value) {
                        setState(() {
                          surveyData['surveyLocation']?['terhalangBayangan'] =
                              value;
                        });
                      },
                      options: ['Tidak'],
                      label: 'Isi pilihan lain',
                      otherOptionLabel: 'Ya, ...',
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SubmitReportCard(
                  title: 'Instalasi Pemipaan & Kelistrikan',
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Apakah sudah tersedia jalur pemipaan air dingin?',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 16,
                          runSpacing: 8,
                          children: [
                            for (final value in ['Ya', 'Tidak'])
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                    value:
                                        surveyData['installationData']['jalurAirDingin'] ==
                                        value,
                                    onChanged: (_) {
                                      setState(() {
                                        surveyData['installationData']['jalurAirDingin'] =
                                            value;
                                      });
                                    },
                                  ),
                                  Text(value),
                                ],
                              ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
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
                        const Text(
                          'Instalasi Pemipaan & Kelistrikan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CheckboxListTile(
                          title: const Text(
                            'Jalur pemipaan air dingin tersedia',
                          ),
                          value: surveyData['hasColdWaterPipe'] ?? false,
                          onChanged: (value) {
                            setState(() {
                              surveyData['hasColdWaterPipe'] = value;
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: const Text(
                            'Jalur pemipaan air panas tersedia',
                          ),
                          value: surveyData['hasHotWaterPipe'] ?? false,
                          onChanged: (value) {
                            setState(() {
                              surveyData['hasHotWaterPipe'] = value;
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: const Text(
                            'Jalur kabel listrik untuk backup Element Heating tersedia',
                          ),
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
                        const Text(
                          'Sumber Air',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
      ),
    );
  }
}
