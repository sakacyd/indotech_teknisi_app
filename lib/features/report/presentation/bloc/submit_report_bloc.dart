import 'dart:async';
import 'dart:io';
import 'package:indotech_teknisi_app/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:indotech_teknisi_app/core/common/entities/report.dart';
import 'package:indotech_teknisi_app/core/usecase/usecase.dart';
import 'package:indotech_teknisi_app/core/common/entities/user.dart';
import 'package:indotech_teknisi_app/features/report/domain/usecases/upload_installation_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'submit_report_event.dart';
part 'submit_report_state.dart';

class SubmitReportBloc extends Bloc<SubmitReportEvent, SubmitReportState> {
  final SubmitInstallationReport _submitInstallationReport;
  SubmitReportBloc({
    required SubmitInstallationReport submitInstallationReportForm,
  }) : _submitInstallationReport = submitInstallationReportForm,
       super(SubmitReportInitial()) {
    on<SubmitReportEvent>((event, emit) => emit(SubmitReportLoading()));
    on<InstallationReportSubmit>(_onInstallationReportSubmit);
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
}
