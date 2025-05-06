import 'dart:async';
import 'package:indotech_teknisi_app/core/usecase/usecase.dart';
import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/features/assignment/domain/usecases/get_today_assignments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'today_event.dart';
part 'today_state.dart';

class TodayBloc extends Bloc<AssignmentEvent, AssignmentState> {
  final GetTodayAssignments _getTodayAssignments;
  TodayBloc({
    required GetTodayAssignments getTodayAssignments,
  }) : _getTodayAssignments = getTodayAssignments,
       super(AssignmentInitial()) {
    on<FetchTodayAssignments>(_onTodayAssignmentsRequested);
  }

  FutureOr<void> _onTodayAssignmentsRequested(
    FetchTodayAssignments event,
    Emitter<AssignmentState> emit,
  ) async {
    emit(AssignmentLoadingToday());
    final res = await _getTodayAssignments(NoParams());

    res.fold(
      (l) => emit(AssignmentFailure(l.message)),
      (r) => emit(AssignmentGetTodaySuccess(r)),
    );
  }
}
