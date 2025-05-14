import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indotech_teknisi_app/features/report/domain/usecases/update_assignment_finished_at.dart';
import 'package:indotech_teknisi_app/features/report/domain/usecases/update_assignment_started_at.dart';
import 'package:indotech_teknisi_app/features/report/domain/usecases/update_technician_arrived_at.dart';
import 'package:indotech_teknisi_app/features/report/domain/usecases/update_assignment_status.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final UpdateTechnicianArrivedAt _updateTechnicianArrivedAt;
  final UpdateAssignmentStartedAt _updateAssignmentStartedAt;
  final UpdateAssignmentFinishedAt _updateAssignmentFinishedAt;
  final UpdateAssignmentStatus _updateAssignmentStatus;

  ReportBloc({
    required UpdateTechnicianArrivedAt updateTechnicianArrivedAt,
    required UpdateAssignmentStartedAt updateAssignmentStartedAt,
    required UpdateAssignmentFinishedAt updateAssignmentFinishedAt,
    required UpdateAssignmentStatus updateAssignmentStatus,
  }) : _updateTechnicianArrivedAt = updateTechnicianArrivedAt,
       _updateAssignmentStartedAt = updateAssignmentStartedAt,
       _updateAssignmentFinishedAt = updateAssignmentFinishedAt,
       _updateAssignmentStatus = updateAssignmentStatus,
       super(ReportInitial()) {
    on<UpdateArrived>(_onUpdateArrived);
    on<UpdateStarted>(_onUpdateStarted);
    on<UpdateFinished>(_onUpdateFinished);
    on<UpdateStatus>(_onUpdateStatus);
    on<CompleteReport>(_onCompleteReport);
  }

  FutureOr<void> _onUpdateArrived(
    UpdateArrived event,
    Emitter<ReportState> emit,
  ) async {
    emit(ReportLoading(currentStep: state.currentStep));
    final res = await _updateTechnicianArrivedAt(
      UpdateTechnicianArrivedAtParams(assignmentId: event.assignmentId),
    );
    res.fold(
      (l) => emit(ReportFailure(l.message, currentStep: state.currentStep)),
      (_) => emit(UpdateArrivedSuccess()),
    );
  }

  FutureOr<void> _onUpdateStarted(
    UpdateStarted event,
    Emitter<ReportState> emit,
  ) async {
    emit(ReportLoading(currentStep: state.currentStep));
    final res = await _updateAssignmentStartedAt(
      UpdateAssignmentStartedAtParams(assignmentId: event.assignmentId),
    );
    res.fold(
      (l) => emit(ReportFailure(l.message, currentStep: state.currentStep)),
      (_) => emit(UpdateStartedSuccess()),
    );
  }

  FutureOr<void> _onUpdateFinished(
    UpdateFinished event,
    Emitter<ReportState> emit,
  ) async {
    emit(ReportLoading(currentStep: state.currentStep));
    final res = await _updateAssignmentFinishedAt(
      UpdateAssignmentFinishedAtParams(assignmentId: event.assignmentId),
    );
    res.fold(
      (l) => emit(ReportFailure(l.message, currentStep: state.currentStep)),
      (_) => emit(UpdateFinishedSuccess()),
    );
  }

  FutureOr<void> _onUpdateStatus(
    UpdateStatus event,
    Emitter<ReportState> emit,
  ) async {
    emit(ReportLoading(currentStep: state.currentStep));
    final res = await _updateAssignmentStatus(
      UpdateAssignmentStatusParams(assignmentId: event.assignmentId),
    );
    res.fold(
      (l) => emit(ReportFailure(l.message, currentStep: state.currentStep)),
      (_) => emit(UpdateStatusSuccess()),
    );
  }

  FutureOr<void> _onCompleteReport(
    CompleteReport event,
    Emitter<ReportState> emit,
  ) async {
    emit(ReportCompleted());
  }
}
