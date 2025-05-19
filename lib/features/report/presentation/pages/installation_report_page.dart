import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indotech_teknisi_app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';
import 'package:indotech_teknisi_app/core/common/entities/report.dart';
import 'package:indotech_teknisi_app/core/common/widgets/loader.dart';
import 'package:indotech_teknisi_app/core/theme/app_pallete.dart';
import 'package:indotech_teknisi_app/features/report/presentation/bloc/submit_report_bloc.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/customer_info_widget.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/info_field.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/product_info_widget.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/signature_section.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/installation_status_widget.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/submit_report_button.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/submit_report_card.dart';

class InstallationReportPage extends StatefulWidget {
  static route(Report report) => MaterialPageRoute(
    builder: (context) => InstallationReportPage(report: report),
  );

  final Report report;
  const InstallationReportPage({super.key, required this.report});

  @override
  State<InstallationReportPage> createState() => _InstallationReportPageState();
}

class _InstallationReportPageState extends State<InstallationReportPage> {
  Map<String, dynamic> installationData = {};
  String? selectedLocation;
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

  void uploadInstallationReport() async {
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
      InstallationReportSubmit(
        reportId: widget.report.id,
        nomorSeriTangki: nomorSeriTangkiController.text,
        nomorSeriKolektor: nomorSeriKolektorController.text,
        pemasangan: selectedLocation ?? '',
        tangki: installationData['tangki'] ?? '',
        collector: installationData['collector'] ?? '',
        elementHeating: installationData['elementHeating'] ?? '',
        thermostat: installationData['thermostat'] ?? '',
        safetyValve: installationData['safetyValve'] ?? '',
        kabelListrik: installationData['kabelListrik'] ?? '',
        pipa: installationData['pipa'] ?? '',
        dinabolt: installationData['dinabolt'] ?? '',
        alasan: installationData['alasan'] ?? '',
        tanggal: DateTime.now(),
        materialDari:
            installationData['materialFromCompany'] == true
                ? 'PT. INDOTECH'
                : 'CUSTOMER',
        instalasiOleh:
            installationData['installationByCompany'] == true
                ? 'PT. INDOTECH'
                : 'CUSTOMER',
        note: null,
        technicianSignature: technicianFile,
        customerSignature: customerFile,
      ),
    );
  }

  @override
  void dispose() {
    _technicianSignatureController.dispose();
    _customerSignatureController.dispose();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Berita Acara Pemasangan")),
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
            Navigator.of(context).pushNamedAndRemoveUntil(
              DashboardPage.route(),
              (route) => false,
            );
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
                        ),
                        InfoField(
                          controller: noTelpController,
                          label: 'No. Telp / HP',
                        ),
                        InfoField(
                          controller: alamatController,
                          label: 'Alamat',
                        ),
                        InfoField(controller: picController, label: 'PIC'),
                        InfoField(
                          controller: noTelpPicController,
                          label: 'No Telp / HP PIC',
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
                        ),
                        InfoField(
                          controller: jumlahController,
                          label: 'Jumlah',
                        ),
                        InfoField(
                          controller: nomorSeriTangkiController,
                          label: 'Nomor Seri Tangki',
                        ),
                        InfoField(
                          controller: nomorSeriKolektorController,
                          label: 'Nomor Seri Kolektor',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SubmitReportCard(
                      title: 'Pemasangan',
                      children: [
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: [
                            ChoiceChip(
                              label: const Text(
                                'Genteng',
                                overflow: TextOverflow.ellipsis,
                              ),
                              selected: selectedLocation == 'Genteng',
                              onSelected: (selected) {
                                setState(() {
                                  selectedLocation =
                                      selected ? 'Genteng' : null;
                                });
                              },
                              labelPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              selectedColor: Colors.blue.shade200,
                              backgroundColor: Colors.grey.shade200,
                            ),
                            ChoiceChip(
                              label: const Text(
                                'Dak/Atap Datar',
                                overflow: TextOverflow.ellipsis,
                              ),
                              selected: selectedLocation == 'Dak',
                              onSelected: (selected) {
                                setState(() {
                                  selectedLocation = selected ? 'Dak' : null;
                                });
                              },
                              labelPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              selectedColor: Colors.blue.shade200,
                              backgroundColor: Colors.grey.shade200,
                            ),
                            ChoiceChip(
                              label: const Text(
                                'Plafon',
                                overflow: TextOverflow.ellipsis,
                              ),
                              selected: selectedLocation == 'Plafon',
                              onSelected: (selected) {
                                setState(() {
                                  selectedLocation = selected ? 'Plafon' : null;
                                });
                              },
                              labelPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              selectedColor: Colors.blue.shade200,
                              backgroundColor: Colors.grey.shade200,
                            ),
                            ChoiceChip(
                              label: const Text(
                                'Dinding',
                                overflow: TextOverflow.ellipsis,
                              ),
                              selected: selectedLocation == 'Dinding',
                              onSelected: (selected) {
                                setState(() {
                                  selectedLocation =
                                      selected ? 'Dinding' : null;
                                });
                              },
                              labelPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              selectedColor: Colors.blue.shade200,
                              backgroundColor: Colors.grey.shade200,
                            ),
                            Container(
                              width: 120,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Lainnya...',
                                  filled: true,
                                  fillColor: AppPallete.backgroundColor,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(24),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(24),
                                    borderSide: BorderSide.none,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(24),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(24),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    selectedLocation =
                                        value.isNotEmpty ? value : null;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Divider(
                          height: 1,
                          color: Colors.grey[300],
                          thickness: 1,
                        ),
                        InstallationStatusWidget(
                          onChanged: (status) {
                            setState(() {
                              installationData['installationStatus'] = status;
                            });
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    SubmitReportCard(
                      title: 'Material dan Instalasi',
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                title: const Text('Material dari PT. INDOTECH'),
                                value:
                                    installationData['materialFromCompany'] ??
                                    false,
                                onChanged: (value) {
                                  setState(() {
                                    if (value == true) {
                                      installationData['materialFromCompany'] =
                                          true;
                                      installationData['materialFromCustomer'] =
                                          false;
                                    } else {
                                      installationData['materialFromCompany'] =
                                          false;
                                    }
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                title: const Text('Material dari Customer'),
                                value:
                                    installationData['materialFromCustomer'] ??
                                    false,
                                onChanged: (value) {
                                  setState(() {
                                    if (value == true) {
                                      installationData['materialFromCustomer'] =
                                          true;
                                      installationData['materialFromCompany'] =
                                          false;
                                    } else {
                                      installationData['materialFromCustomer'] =
                                          false;
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Divider(
                          height: 1,
                          color: Colors.grey[300],
                          thickness: 1,
                        ),
                        const SizedBox(width: 8),
                        Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                title: const Text(
                                  'Instalasi oleh PT. INDOTECH',
                                ),
                                value:
                                    installationData['installationByCompany'] ??
                                    false,
                                onChanged: (value) {
                                  setState(() {
                                    if (value == true) {
                                      installationData['installationByCompany'] =
                                          true;
                                      installationData['installationByCustomer'] =
                                          false;
                                    } else {
                                      installationData['installationByCompany'] =
                                          false;
                                    }
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                title: const Text('Instalasi oleh Customer'),
                                value:
                                    installationData['installationByCustomer'] ??
                                    false,
                                onChanged: (value) {
                                  setState(() {
                                    if (value == true) {
                                      installationData['installationByCustomer'] =
                                          true;
                                      installationData['installationByCompany'] =
                                          false;
                                    } else {
                                      installationData['installationByCustomer'] =
                                          false;
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
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
                        uploadInstallationReport();
                        print(installationData);
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
