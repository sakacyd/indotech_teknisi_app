import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/core/usecase/usecase.dart';
import 'package:indotech_teknisi_app/features/report/domain/entities/inspection_report.dart';
import 'package:indotech_teknisi_app/features/report/domain/repository/report_repository.dart';

class UploadInspectionReport
    implements UseCase<InspectionReport, UploadInspectionReportParams> {
  final ReportRepository reportRepository;

  UploadInspectionReport(this.reportRepository);

  @override
  Future<Either<Failure, InspectionReport>> call(
    UploadInspectionReportParams params,
  ) async {
    return await reportRepository.uploadInspectionReport(
      reportId: params.reportId,
      date: params.date,
      tankSerialNumber: params.tankSerialNumber,
      collectorSerialNumber: params.collectorSerialNumber,
      isUnderWarranty: params.isUnderWarranty,
      remarks: params.remarks,
      notes: params.notes,
      customerSignature: params.customerSignature,
      technicianSignature: params.technicianSignature,
    );
  }
}

class UploadInspectionReportParams {
  final int reportId;
  final DateTime date;
  final String tankSerialNumber;
  final String collectorSerialNumber;
  final String isUnderWarranty;
  final String remarks;
  final String? notes;
  final File customerSignature;
  final File technicianSignature;

  UploadInspectionReportParams({
    required this.reportId,
    required this.date,
    required this.tankSerialNumber,
    required this.collectorSerialNumber,
    required this.isUnderWarranty,
    required this.remarks,
    this.notes,
    required this.customerSignature,
    required this.technicianSignature,
  });
}
