import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final namaController = TextEditingController();
  final noTelpController = TextEditingController();
  final alamatController = TextEditingController();
  final picController = TextEditingController();
  final noTelpPicController = TextEditingController();
  final namaProdukController = TextEditingController();
  final jumlahController = TextEditingController();
  final nomorSeriTangkiController = TextEditingController();
  final nomorSeriKolektorController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void uploadInstallationReport() async {
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
            installationData['materialFromCustomer'] == true
                ? 'CUSTOMER'
                : 'PT. INDOTECH',
        note: null,
        technicianSignature: File(''),
        customerSignature: File(''),
      ),
    );
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
            Navigator.pop(context);
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
                    Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Customer',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            InfoField(
                              controller: namaController,
                              label: 'Nama Customer',
                              value: widget.report.customerName ?? '-',
                            ),
                            InfoField(
                              controller: noTelpController,
                              label: 'No. Telp / HP',
                              value: widget.report.customerPhoneNumber ?? '-',
                            ),
                            InfoField(
                              controller: alamatController,
                              label: 'Alamat',
                              value: widget.report.customerAddress ?? '-',
                            ),
                            InfoField(
                              controller: picController,
                              label: 'PIC',
                              value: '',
                            ),
                            InfoField(
                              controller: noTelpPicController,
                              label: 'No Telp / HP PIC',
                              value: '',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Produk',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            InfoField(
                              controller: namaProdukController,
                              label: 'Nama Produk',
                              value: widget.report.unit ?? '-',
                            ),
                            InfoField(
                              controller: jumlahController,
                              label: 'Jumlah',
                              value: widget.report.unitQuantity ?? '-',
                            ),
                            InfoField(
                              controller: nomorSeriTangkiController,
                              label: 'Nomor Seri Tangki',
                              value: '',
                            ),
                            InfoField(
                              controller: nomorSeriKolektorController,
                              label: 'Nomor Seri Kolektor',
                              value: '',
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
                              'Pemasangan',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
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
                                      selectedLocation =
                                          selected ? 'Dak' : null;
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
                                      selectedLocation =
                                          selected ? 'Plafon' : null;
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                            InstallationStatusWidget(
                              onChanged: (status) {
                                setState(() {
                                  installationData['installationStatus'] =
                                      status;
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
                              'Material dan Instalasi',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: CheckboxListTile(
                                    title: const Text(
                                      'Material dari PT. INDOTECH',
                                    ),
                                    value:
                                        installationData['materialFromCompany'] ??
                                        false,
                                    onChanged: (value) {
                                      setState(() {
                                        installationData['materialFromCompany'] =
                                            value;
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
                                        installationData['materialFromCustomer'] =
                                            value;
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
                    const SignatureSection(
                      leftTitle: 'Installer',
                      rightTitle: 'Customer',
                    ),
                    const SizedBox(height: 16),
                    SubmitReportButton(
                      buttonText: 'Submit Berita Acara',
                      onPressed: () {
                        uploadInstallationReport();
                        // Handle the submit action here
                        // You can access the installationData map to get the values
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
