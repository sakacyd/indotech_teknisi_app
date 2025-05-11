import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc() : super(ReportInitial()) {
    on<ReportEvent>((event, emit) => emit(ReportLoading()));
    on<CompleteReport>((event, emit) async {
      emit(ReportCompleted());
    });
    on<ChangeStep>(_onSlideSuccess);
  }

  FutureOr<void> _onSlideSuccess(
    ChangeStep event,
    Emitter<ReportState> emit,
  ) async {
    emit(ReportLoading());

    await Future.delayed(const Duration(milliseconds: 300));

    emit(StepperChanged(event.step));
  }
}
