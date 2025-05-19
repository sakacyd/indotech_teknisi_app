import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indotech_teknisi_app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/installation_section.dart';
import 'package:indotech_teknisi_app/main_page.dart';
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

  bool _validateMaterialAndInstallation() {
    final materialFromCompany =
        installationData['materialFromCompany'] ?? false;
    final materialFromCustomer =
        installationData['materialFromCustomer'] ?? false;
    final installationByCompany =
        installationData['installationByCompany'] ?? false;
    final installationByCustomer =
        installationData['installationByCustomer'] ?? false;

    if (!(materialFromCompany || materialFromCustomer)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih minimal satu opsi untuk Material Dari'),
        ),
      );
      return false;
    }

    if (!(installationByCompany || installationByCustomer)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih minimal satu opsi untuk Instalasi Oleh'),
        ),
      );
      return false;
    }

    return true;
  }

  void uploadInstallationReport() async {
    if (!formKey.currentState!.validate()) return;

    if (!_validateMaterialAndInstallation()) return;

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
        tangki:
            (installationData['installationStatus']?['tangki'] ?? false)
                ? 'Terpasang'
                : 'Belum terpasang',
        collector:
            (installationData['installationStatus']?['kolektor'] ?? false)
                ? 'Terpasang'
                : 'Belum terpasang',
        elementHeating:
            (installationData['installationStatus']?['elementHeating'] ?? false)
                ? 'Terpasang'
                : 'Belum terpasang',
        thermostat:
            (installationData['installationStatus']?['thermostat'] ?? false)
                ? 'Terpasang'
                : 'Belum terpasang',
        safetyValve:
            (installationData['installationStatus']?['safetyValve'] ?? false)
                ? 'Terpasang'
                : 'Belum terpasang',
        kabelListrik:
            (installationData['installationStatus']?['kabelListrik'] ?? false)
                ? 'Terpasang'
                : 'Belum terpasang',
        pipa:
            (installationData['installationStatus']?['pipa'] ?? false)
                ? 'Terpasang'
                : 'Belum terpasang',
        dinabolt:
            (installationData['installationStatus']?['dinabolt'] ?? false)
                ? 'Terpasang'
                : 'Belum terpasang',
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
        note: noteController.text,
        technicianSignature: technicianFile,
        customerSignature: customerFile,
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
                      ],
                    ),
                    const SizedBox(height: 16),
                    SubmitReportCard(
                      title: 'Pemasangan',
                      children: [
                        InstallationSection(
                          initialValue: selectedLocation,
                          onChanged: (value) {
                            setState(() {
                              selectedLocation = value;
                            });
                          },
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
                      title: 'Note',
                      children: [
                        InfoField(
                          controller: noteController,
                          label: 'Note',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Note wajib diisi';
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
