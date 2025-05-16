import 'dart:async';
import 'package:indotech_teknisi_app/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:indotech_teknisi_app/core/usecase/usecase.dart';
import 'package:indotech_teknisi_app/core/common/entities/user.dart';
import 'package:indotech_teknisi_app/features/submitreport/domain/usecases/current_user.dart';
import 'package:indotech_teknisi_app/features/submitreport/domain/usecases/user_login.dart';
import 'package:indotech_teknisi_app/features/submitreport/domain/usecases/user_sign_up.dart';
import 'package:indotech_teknisi_app/features/submitreport/domain/usecases/user_sign_out.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'submit_report_event.dart';
part 'submit_report_state.dart';

class SubmitReportBloc extends Bloc<SubmitReportEvent, SubmitReportState> {
  final ReportFormSubbmitted _submitReportForm;
  SubmitReportBloc({required ReportFormSubbmitted submitForm})
    : _submitReportForm = submitReportForm,
      super(SubmitReportInitial()) {
    on<SubmitReportEvent>((_, emit) => emit(SubmitReportLoading()));
    on<SubmitReportForm>(_onSubmitReportForm);
  }

  FutureOr<void> _onSubmitReportForm(
    SubmitReportForm event,
    Emitter<SubmitReportState> emit,
  ) async {
    final res = await _submitReportForm(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );
    res.fold(
      (l) => emit(SubmitReportFailure(l.message)),
      (r) => _submitReportForm(r, emit),
    );
  }
}
