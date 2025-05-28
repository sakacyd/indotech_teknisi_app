import 'dart:async';
import 'dart:io';
import 'package:indotech_teknisi_app/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:indotech_teknisi_app/core/common/entities/report.dart';
import 'package:indotech_teknisi_app/core/usecase/usecase.dart';
import 'package:indotech_teknisi_app/core/common/entities/user.dart';
import 'package:indotech_teknisi_app/features/report/domain/entities/inspection_item.dart';
import 'package:indotech_teknisi_app/features/report/domain/usecases/upload_installation_report.dart';
import 'package:indotech_teknisi_app/features/report/domain/usecases/upload_inspection_report.dart';
import 'package:indotech_teknisi_app/features/report/domain/usecases/upload_inspection_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'submit_report_event.dart';
part 'submit_report_state.dart';

class SubmitReportBloc extends Bloc<SubmitReportEvent, SubmitReportState> {
  final SubmitInstallationReport _submitInstallationReport;
  final UploadInspectionReport _uploadInspectionReport;
  final UploadInspectionItem _uploadInspectionItem;
  SubmitReportBloc({
    required SubmitInstallationReport submitInstallationReportForm,
    required UploadInspectionReport uploadInspectionReport,
    required UploadInspectionItem uploadInspectionItem,
  }) : _submitInstallationReport = submitInstallationReportForm,
       _uploadInspectionReport = uploadInspectionReport,
       _uploadInspectionItem = uploadInspectionItem,
       super(SubmitReportInitial()) {
    on<SubmitReportEvent>((event, emit) => emit(SubmitReportLoading()));
    on<InstallationReportSubmit>(_onInstallationReportSubmit);
    on<InspectionReportSubmit>(_onInspectionReportSubmit);
  }

  FutureOr<void> _onInstallationReportSubmit(
    InstallationReportSubmit event,
    Emitter<SubmitReportState> emit,
  ) async {
    final res = await _submitInstallationReport(
      SubmitInstallationReportParams(
        reportId: event.reportId,
        nomorSeriTangki: event.nomorSeriTangki,
        nomorSeriKolektor: event.nomorSeriKolektor,
        pemasangan: event.pemasangan,
        tangki: event.tangki,
        collector: event.collector,
        elementHeating: event.elementHeating,
        thermostat: event.thermostat,
        safetyValve: event.safetyValve,
        kabelListrik: event.kabelListrik,
        pipa: event.pipa,
        dinabolt: event.dinabolt,
        alasan: event.alasan,
        tanggal: event.tanggal,
        materialDari: event.materialDari,
        instalasiOleh: event.instalasiOleh,
        note: event.note,
        customerSignature: event.customerSignature,
        technicianSignature: event.technicianSignature,
      ),
    );
    res.fold(
      (l) => emit(SubmitReportFailure(l.message)),
      (r) => emit(SubmitReportSuccess()),
    );
  }

  FutureOr<void> _onInspectionReportSubmit(
    InspectionReportSubmit event,
    Emitter<SubmitReportState> emit,
  ) async {
    final res = await _uploadInspectionReport(
      UploadInspectionReportParams(
        reportId: event.reportId,
        date: event.date,
        tankSerialNumber: event.tankSerialNumber,
        collectorSerialNumber: event.collectorSerialNumber,
        isUnderWarranty: event.isUnderWarranty,
        remarks: event.remarks,
        notes: event.notes,
        customerSignature: event.customerSignature,
        technicianSignature: event.technicianSignature,
      ),
    );

    if (res.isLeft()) {
      final failureMessage = res.fold((l) => l.message, (_) => '');
      emit(SubmitReportFailure(failureMessage));
      return;
    }

    final inspectionReport = res.fold(
      (_) => throw Exception('Unexpected failure'),
      (r) => r,
    );

    for (final item in event.inspectionItems) {
      final itemRes = await _uploadInspectionItem(
        UploadInspectionItemParams(
          inspectionReportId: inspectionReport.id,
          itemName: item.itemName,
          condition: item.condition,
          quantity: item.quantity,
          notes: item.notes,
        ),
      );

      if (itemRes.isLeft()) {
        emit(
          SubmitReportFailure(
            itemRes.fold((l) => l.message, (_) => 'Unknown error'),
          ),
        );
        return;
      }
    }

    if (!emit.isDone) {
      emit(SubmitReportSuccess());
    }
  }
}
