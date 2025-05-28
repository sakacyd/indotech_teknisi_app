import 'package:fpdart/fpdart.dart';
import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/core/usecase/usecase.dart';
import 'package:indotech_teknisi_app/features/report/domain/entities/inspection_item.dart';
import 'package:indotech_teknisi_app/features/report/domain/repository/report_repository.dart';

class UploadInspectionItem
    implements UseCase<InspectionItem, UploadInspectionItemParams> {
  final ReportRepository reportRepository;

  UploadInspectionItem(this.reportRepository);

  @override
  Future<Either<Failure, InspectionItem>> call(
    UploadInspectionItemParams params,
  ) async {
    return await reportRepository.uploadInspectionItem(
      inspectionReportId: params.inspectionReportId,
      itemName: params.itemName,
      condition: params.condition,
      quantity: params.quantity,
      notes: params.notes,
    );
  }
}

class UploadInspectionItemParams {
  final String inspectionReportId;
  final String? itemName;
  final String? condition;
  final int? quantity;
  final String? notes;

  UploadInspectionItemParams({
    required this.inspectionReportId,
    this.itemName,
    this.condition,
    this.quantity,
    this.notes,
  });
}
