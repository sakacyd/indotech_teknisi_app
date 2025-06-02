import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:indotech_teknisi_app/core/common/entities/report.dart';
import 'package:indotech_teknisi_app/core/common/widgets/loader.dart';
import 'package:indotech_teknisi_app/core/theme/app_pallete.dart';
import 'package:indotech_teknisi_app/core/utils/pick_image.dart';
import 'package:indotech_teknisi_app/features/report/presentation/bloc/submit_report_bloc.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/customer_info_widget.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/info_field.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/installation_section.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/product_info_widget.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/signature_section.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/location_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/submit_report_button.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/submit_report_card.dart';
import 'package:indotech_teknisi_app/main_page.dart';
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
    'surveyLocation': {},
    'installationData': {},
  };

  final namaCustomerController = TextEditingController();
  final namaTeknisiController = TextEditingController();
  final noTelpController = TextEditingController();
  final alamatController = TextEditingController();
  final picController = TextEditingController();
  final noTelpPicController = TextEditingController();
  final namaProdukController = TextEditingController();
  final noteController = TextEditingController();
  final estimasiInstalasiJalurAirController = TextEditingController();
  final estimasiInstalasiJalurKabelController = TextEditingController();
  final voltaseController = TextEditingController();
  final ampereController = TextEditingController();
  final hertzController = TextEditingController();
  final wattController = TextEditingController();
  final pressureBarController = TextEditingController();
  final volumeKolamController = TextEditingController();
  final panjangKolamController = TextEditingController();
  final lebarKolamController = TextEditingController();
  final tinggiKolamController = TextEditingController();
  final suhuAwalController = TextEditingController();
  final suhuTargetController = TextEditingController();
  DateTime? selectedDateTime;
  File? image;

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

  void selectImage() async {
    final pickecImage = await pickImage();
    if (pickecImage != null) {
      setState(() {
        image = pickecImage;
      });
    }
  }

  void uploadSurveyReport() async {
    if (formKey.currentState!.validate() &&
        image != null &&
        _technicianSignatureBytes != null &&
        _customerSignatureBytes != null) {
      final technicianFile = await saveSignatureToFile(
        _technicianSignatureBytes!,
        'technician_signature',
      );
      final customerFile = await saveSignatureToFile(
        _customerSignatureBytes!,
        'customer_signature',
      );

      context.read<SubmitReportBloc>().add(
        SurveyReportSubmit(
          reportId: widget.report.id,
          installationLocation:
              surveyData['surveyLocation']?['lokasiPemasangan'] ?? '',
          roofFrameType:
              surveyData['surveyLocation']?['jenisRangkaGenteng'] ?? '',
          needsReinforcement:
              surveyData['surveyLocation']?['apakahPerluDiperkuat'] ?? '',
          installationDirection:
              surveyData['surveyLocation']?['arahPemasangan'] ?? '',
          obstructedByShade:
              surveyData['surveyLocation']?['terhalangBayangan'] ?? '',
          coldWaterLine:
              surveyData['installationData']?['jalurAirDingin'] ?? '',
          hotWaterLine: surveyData['installationData']?['jalurAirHangat'] ?? '',
          waterLineProvider:
              surveyData['installationData']?['penyediaJalurAir'] ?? '',
          estimatedWaterLineInstallation:
              estimasiInstalasiJalurAirController.text,
          electricalCableLine:
              surveyData['installationData']?['jalurKabelListrik'] ?? '',
          cableLineProvider:
              surveyData['installationData']?['penyediaJalurKabel'] ?? '',
          estimatedCableLineInstallation:
              estimasiInstalasiJalurKabelController.text,
          voltage: voltaseController.text,
          amperage: ampereController.text,
          hertz: hertzController.text,
          watt: wattController.text,
          coldWaterSource:
              surveyData['installationData']?['sumberAirDingin'] ?? '',
          waterFromReservoir:
              surveyData['installationData']?['airDariToren'] ?? '',
          boosterPump: surveyData['installationData']?['pompaPendorong'] ?? '',
          pressureBar: pressureBarController.text,
          poolVolume: volumeKolamController.text,
          poolLength: panjangKolamController.text,
          poolWidth: lebarKolamController.text,
          poolHeight: tinggiKolamController.text,
          initialTemperature: suhuAwalController.text,
          targetTemperature: suhuTargetController.text,
          visitDate: selectedDateTime!,
          note: noteController.text,
          imageFile: image!,
          surveyorSignature: technicianFile,
          customerSignature: customerFile,
        ),
      );
    } else if (_customerSignatureBytes == null ||
        _technicianSignatureBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tanda tangan belum lengkap')),
      );
      return;
    }
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
    noteController.dispose();
    estimasiInstalasiJalurAirController.dispose();
    estimasiInstalasiJalurKabelController.dispose();
    voltaseController.dispose();
    ampereController.dispose();
    hertzController.dispose();
    wattController.dispose();
    pressureBarController.dispose();
    volumeKolamController.dispose();
    panjangKolamController.dispose();
    lebarKolamController.dispose();
    tinggiKolamController.dispose();
    suhuAwalController.dispose();
    suhuTargetController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    surveyData['surveyLocation'] ??= {};
    final surveyKeys = [
      'lokasiPemasangan',
      'jenisRangkaGenteng',
      'terhalangBayangan',
      'apakahPerluDiperkuat',
      'arahPemasangan',
    ];
    for (final surveyKey in surveyKeys) {
      surveyData['surveyLocation'][surveyKey] ??= '';
    }
    surveyData['installationData'] ??= {};
    final installationKeys = [
      'jalurAirDingin',
      'jalurAirPanas',
      'penyediaJalurAir',
      'jalurKabelListrik',
      'penyediaJalurKabel',
    ];
    for (final installationKey in installationKeys) {
      surveyData['surveyLocation'][installationKey] ??= '';
    }
    namaTeknisiController.text = widget.report.technicianName ?? '';
    namaCustomerController.text = widget.report.customerName ?? '';
    noTelpController.text = widget.report.customerPhoneNumber ?? '';
    alamatController.text = widget.report.customerAddress ?? '';
    namaProdukController.text = widget.report.unit ?? '';
    estimasiInstalasiJalurAirController.text = '';
    estimasiInstalasiJalurKabelController.text = '';
    voltaseController.text = '';
    ampereController.text = '';
    hertzController.text = '';
    wattController.text = '';
    pressureBarController.text = '';
    volumeKolamController.text = '';
    panjangKolamController.text = '';
    lebarKolamController.text = '';
    tinggiKolamController.text = '';
    suhuAwalController.text = '';
    suhuTargetController.text = '';
    noteController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Berita Acara Survey")),
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
                              surveyData['surveyLocation']?['lokasiPemasangan']
                                  as String?,
                          onChanged: (value) {
                            setState(() {
                              surveyData['surveyLocation'] ??= {};
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
                              surveyData['surveyLocation']?['jenisRangkaGenteng']
                                  as String?,
                          onChanged: (value) {
                            setState(() {
                              surveyData['surveyLocation'] ??= {};
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
                        const SizedBox(height: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Apakah sudah tersedia jalur pemipaan air hangat?',
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
                                            surveyData['installationData']['jalurAirHangat'] ==
                                            value,
                                        onChanged: (_) {
                                          setState(() {
                                            surveyData['installationData']['jalurAirHangat'] =
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
                              'Disediakan oleh?',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Wrap(
                              spacing: 16,
                              runSpacing: -10,
                              children: [
                                for (final value in [
                                  'PT. INDOTECH ENERGI PERSADA',
                                  'Customer',
                                ])
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                        value:
                                            surveyData['installationData']['penyediaJalurAir'] ==
                                            value,
                                        onChanged: (_) {
                                          setState(() {
                                            surveyData['installationData']['penyediaJalurAir'] =
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
                        InfoField(
                          controller: estimasiInstalasiJalurAirController,
                          label: 'Estimasi instalasi (meter)',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Estimasi instalasi wajib diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        Divider(
                          height: 1,
                          color: Colors.grey[300],
                          thickness: 1,
                        ),
                        const SizedBox(height: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Apakah sudah tersedia jalur kabel listrik untuk backup Element Heating / Unit?',
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
                                            surveyData['installationData']['jalurKabelListrik'] ==
                                            value,
                                        onChanged: (_) {
                                          setState(() {
                                            surveyData['installationData']['jalurKabelListrik'] =
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
                              'Disediakan oleh?',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Wrap(
                              spacing: 16,
                              runSpacing: -10,
                              children: [
                                for (final value in [
                                  'PT. INDOTECH ENERGI PERSADA',
                                  'Customer',
                                ])
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                        value:
                                            surveyData['installationData']['penyediaJalurKabel'] ==
                                            value,
                                        onChanged: (_) {
                                          setState(() {
                                            surveyData['installationData']['penyediaJalurKabel'] =
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
                        InfoField(
                          controller: estimasiInstalasiJalurKabelController,
                          label: 'Estimasi instalasi (meter)',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Estimasi instalasi wajib diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Data kelistrikan',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        InfoField(
                          controller: voltaseController,
                          label: 'Voltase',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Voltase wajib diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 4),
                        InfoField(
                          controller: ampereController,
                          label: 'Ampere',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Ampere wajib diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 4),
                        InfoField(
                          controller: hertzController,
                          label: 'Hertz',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Hertz wajib diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 4),
                        InfoField(
                          controller: wattController,
                          label: 'Watt / Daya',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Watt / Daya wajib diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        Divider(
                          height: 1,
                          color: Colors.grey[300],
                          thickness: 1,
                        ),
                        const SizedBox(height: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Sumber air dingin?',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Wrap(
                              spacing: 16,
                              runSpacing: 8,
                              children: [
                                for (final value in ['PAM', 'Sumur (Tanah)'])
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                        value:
                                            surveyData['installationData']['sumberAirDingin'] ==
                                            value,
                                        onChanged: (_) {
                                          setState(() {
                                            surveyData['installationData']['sumberAirDingin'] =
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
                              'Air dari toren?',
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
                                            surveyData['installationData']['airDariToren'] ==
                                            value,
                                        onChanged: (_) {
                                          setState(() {
                                            surveyData['installationData']['airDariToren'] =
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
                              'Tersedia pompa pendorong?',
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
                                            surveyData['installationData']['pompaPendorong'] ==
                                            value,
                                        onChanged: (_) {
                                          setState(() {
                                            surveyData['installationData']['pompaPendorong'] =
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
                        const Text(
                          'Pressure air (dalam bar)',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        InfoField(
                          controller: pressureBarController,
                          label: 'Bar',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Pressure Bar wajib diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Untuk Swimming Pool,',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        InfoField(
                          controller: volumeKolamController,
                          label: 'Volume Kolam (m3)',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Volume Kolam wajib diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        const Text('Dimensi', style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 4),
                        InfoField(
                          controller: panjangKolamController,
                          label: 'Panjang (meter)',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Panjang wajib diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 4),
                        InfoField(
                          controller: lebarKolamController,
                          label: 'Lebar (meter)',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Lebar wajib diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 4),
                        InfoField(
                          controller: tinggiKolamController,
                          label: 'Tinggi (meter)',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Tinggi wajib diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 4),
                        InfoField(
                          controller: suhuAwalController,
                          label: 'Suhu Awal (°C)',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Suhu Awal wajib diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 4),
                        InfoField(
                          controller: suhuTargetController,
                          label: 'Suhu Target (°C)',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Suhu Target wajib diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        Divider(
                          height: 1,
                          color: Colors.grey[300],
                          thickness: 1,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Kunjungan dilakukan pada:',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        InkWell(
                          onTap: () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: selectedDateTime ?? DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2100),
                            );

                            if (pickedDate != null) {
                              final pickedTime = await showTimePicker(
                                context: context,
                                initialTime:
                                    selectedDateTime != null
                                        ? TimeOfDay.fromDateTime(
                                          selectedDateTime!,
                                        )
                                        : TimeOfDay.now(),
                              );

                              if (pickedTime != null) {
                                setState(() {
                                  selectedDateTime = DateTime(
                                    pickedDate.year,
                                    pickedDate.month,
                                    pickedDate.day,
                                    pickedTime.hour,
                                    pickedTime.minute,
                                  );
                                });
                              }
                            }
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              selectedDateTime != null
                                  ? '${selectedDateTime!.day}/${selectedDateTime!.month}/${selectedDateTime!.year} '
                                      'pukul ${selectedDateTime!.hour.toString().padLeft(2, '0')}:${selectedDateTime!.minute.toString().padLeft(2, '0')}'
                                  : 'Pilih tanggal dan waktu',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
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
                          maxLines: 3,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SubmitReportCard(
                      title: 'Gambar',
                      children: [
                        image != null
                            ? GestureDetector(
                              onTap: () {
                                selectImage();
                              },
                              child: SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(image!, fit: BoxFit.cover),
                                ),
                              ),
                            )
                            : GestureDetector(
                              onTap: () {
                                selectImage();
                              },
                              child: DottedBorder(
                                color: AppPallete.borderColor,
                                dashPattern: const [10, 4],
                                radius: const Radius.circular(10),
                                borderType: BorderType.RRect,
                                strokeCap: StrokeCap.round,
                                child: const SizedBox(
                                  height: 200,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.folder_open, size: 40),
                                      SizedBox(height: 50),
                                      Text(
                                        'Select your image',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
                        uploadSurveyReport();
                        print(surveyData);
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
