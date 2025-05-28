import 'dart:io';
import 'dart:typed_data';

import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/core/common/entities/report.dart';
import 'package:indotech_teknisi_app/core/common/widgets/loader.dart';
import 'package:indotech_teknisi_app/features/assignment/presentation/pages/history_assignment_page.dart';
import 'package:indotech_teknisi_app/features/report/domain/entities/inspection_item.dart';
import 'package:indotech_teknisi_app/features/report/presentation/bloc/report_bloc.dart';
import 'package:indotech_teknisi_app/features/report/presentation/bloc/submit_report_bloc.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/card/report_card.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/customer_section.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/info_field.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/stepper/custom_stepper.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/slider/custom_action_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indotech_teknisi_app/core/common/entities/report.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/customer_info_widget.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/product_info_widget.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/signature_section.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/inspection_checklist_widget.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/submit_report_button.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/submit_report_card.dart';
import 'package:indotech_teknisi_app/main_page.dart';
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
  List<InspectionItem> inspectionItems = [];
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

    context.read<SubmitReportBloc>().add(
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
    );
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
    remarksController.dispose();
    notesController.dispose();
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
    remarksController.text = '';
    notesController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Berita Acara Pengecekan")),
      body: BlocConsumer<SubmitReportBloc, SubmitReportState>(
        listener: (context, state) {
          if (state is SubmitReportFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is SubmitReportSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Berita Acara berhasil dikirim')),
            );
            Future.delayed(const Duration(milliseconds: 300), () {
              Navigator.pushAndRemoveUntil(
                context,
                MainPage.route(),
                (route) => false,
              );
            });
          }
        },
        builder: (context, state) {
          if (state is SubmitReportLoading) {
            return const Loader();
          }
          return SingleChildScrollView(
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
                      ],
                    ),
                    const SizedBox(height: 16),
                    SubmitReportCard(
                      title: 'Produk',
                      children: [
                        InfoField(
                          controller: namaProdukController,
                          label: 'Nama Produk',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Nama Produk wajib diisi';
                            }
                            return null;
                          },
                        ),
                        InfoField(
                          controller: jumlahController,
                          label: 'Jumlah',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Jumlah wajib diisi';
                            }
                            return null;
                          },
                        ),
                        InfoField(
                          controller: nomorSeriTangkiController,
                          label: 'Nomor Seri Tangki',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Nomor Seri Tangki wajib diisi';
                            }
                            return null;
                          },
                        ),
                        InfoField(
                          controller: nomorSeriKolektorController,
                          label: 'Nomor Seri Kolektor',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Nomor Seri Kolektor wajib diisi';
                            }
                            return null;
                          },
                        ),
                        Row(
                          children: [
                            const Text(
                              'Dalam Masa Garansi',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(width: 8),
                            const Text(':'),
                            const SizedBox(width: 12),
                            Row(
                              children: [
                                Checkbox(
                                  value: isUnderWarranty == true,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isUnderWarranty = true;
                                    });
                                  },
                                ),
                                const Text('Ya'),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: isUnderWarranty == false,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isUnderWarranty = false;
                                    });
                                  },
                                ),
                                const Text('Tidak'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SubmitReportCard(
                      title: 'Keterangan/Keluhan',
                      children: [
                        InfoField(
                          controller: remarksController,
                          label: 'Keterangan',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Keterangan wajib diisi';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    SubmitReportCard(
                      title: 'Sparepart',
                      children: [
                        InspectionChecklistWidget(
                          onChanged: (items) {
                            setState(() {
                              inspectionItems = items;
                            });
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    SubmitReportCard(
                      title: 'Note',
                      children: [
                        InfoField(
                          controller: notesController,
                          label: 'Catatan',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Catatan wajib diisi';
                            }
                            return null;
                          },
                          maxLines: 5,
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    SubmitReportCard(
                      title: 'Tanda Tangan Pelanggan',
                      children: [
                        SignatureSection(
                          value: widget.report.customerName ?? '-',
                          title: 'Tanda Tangan Pelanggan',
                          controller: _customerSignatureController,
                          textController: namaCustomerController,
                          onSignatureSaved: (bytes) {
                            setState(() {
                              _customerSignatureBytes = bytes;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SubmitReportCard(
                      title: 'Tanda Tangan Teknisi',
                      children: [
                        SignatureSection(
                          title: "Tanda Tangan Teknisi",
                          value: widget.report.technicianName ?? '-',
                          controller: _technicianSignatureController,
                          textController: namaTeknisiController,
                          onSignatureSaved: (bytes) {
                            setState(() {
                              _technicianSignatureBytes = bytes;
                            });
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    SubmitReportButton(
                      buttonText: 'Submit Berita Acara',
                      onPressed: () {
                        uploadInspectionReport();
                        print(inspectionData);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
