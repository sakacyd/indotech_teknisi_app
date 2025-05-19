import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/core/usecase/usecase.dart';
import 'package:indotech_teknisi_app/features/report/domain/entities/installation_report.dart';
import 'package:indotech_teknisi_app/features/report/domain/repository/report_repository.dart';

class SubmitInstallationReport
    implements UseCase<InstallationReport, SubmitInstallationReportParams> {
  final ReportRepository reportRepository;

  SubmitInstallationReport(this.reportRepository);

  @override
  Future<Either<Failure, InstallationReport>> call(
    SubmitInstallationReportParams params,
  ) async {
    return await reportRepository.uploadInstallationReport(
      reportId: params.reportId,
      nomorSeriTangki: params.nomorSeriTangki,
      nomorSeriKolektor: params.nomorSeriKolektor,
      pemasangan: params.pemasangan,
      tangki: params.tangki,
      collector: params.collector,
      elementHeating: params.elementHeating,
      thermostat: params.thermostat,
      safetyValve: params.safetyValve,
      kabelListrik: params.kabelListrik,
      pipa: params.pipa,
      dinabolt: params.dinabolt,
      alasan: params.alasan,
      tanggal: params.tanggal,
      materialDari: params.materialDari,
      instalasiOleh: params.instalasiOleh,
      note: params.note,
      customerSignature: params.customerSignature,
      technicianSignature: params.technicianSignature,
    );
  }
}

class SubmitInstallationReportParams {
  final int reportId;
  final String nomorSeriTangki;
  final String nomorSeriKolektor;
  final String pemasangan;
  final String tangki;
  final String collector;
  final String elementHeating;
  final String thermostat;
  final String safetyValve;
  final String kabelListrik;
  final String pipa;
  final String dinabolt;
  final String? alasan;
  final DateTime tanggal;
  final String materialDari;
  final String instalasiOleh;
  final String? note;
  final File customerSignature;
  final File technicianSignature;

  SubmitInstallationReportParams({
    required this.reportId,
    required this.nomorSeriTangki,
    required this.nomorSeriKolektor,
    required this.pemasangan,
    required this.tangki,
    required this.collector,
    required this.elementHeating,
    required this.thermostat,
    required this.safetyValve,
    required this.kabelListrik,
    required this.pipa,
    required this.dinabolt,
    this.alasan,
    required this.tanggal,
    required this.materialDari,
    required this.instalasiOleh,
    this.note,
    required this.customerSignature,
    required this.technicianSignature,
  });
}
