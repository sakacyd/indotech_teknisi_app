import 'dart:async';
import 'dart:io';
import 'package:indotech_teknisi_app/core/usecase/usecase.dart';
import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/features/assignment/domain/usecases/get_previous_assignments.dart';
import 'package:indotech_teknisi_app/features/assignment/domain/usecases/get_today_assignments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'assignment_event.dart';
part 'assignment_state.dart';

class AssignmentBloc extends Bloc<AssignmentEvent, AssignmentState> {
  final GetTodayAssignments _getTodayAssignments;
  final GetPreviousAssignments _getPreviousAssignments;
  AssignmentBloc({
    required GetTodayAssignments getTodayAssignments,
    required GetPreviousAssignments getPreviousAssignments,
  }) : _getTodayAssignments = getTodayAssignments,
       _getPreviousAssignments = getPreviousAssignments,
       super(AssignmentInitial()) {
    on<AssignmentEvent>((event, emit) => emit(AssignmentLoading()));
    on<FetchTodayAssignments>(_onTodayAssignmentsRequested);
    on<FetchPreviousAssignments>(_onPreviousAssignmentsRequested);
  }

  FutureOr<void> _onTodayAssignmentsRequested(
    FetchTodayAssignments event,
    Emitter<AssignmentState> emit,
  ) async {
    final res = await _getTodayAssignments(NoParams());

    res.fold(
      (l) => emit(AssignmentFailure(l.message)),
      (r) => emit(AssignmentGetAllSuccess(r)),
    );
  }

  FutureOr<void> _onPreviousAssignmentsRequested(
    FetchPreviousAssignments event,
    Emitter<AssignmentState> emit,
  ) async {
    final res = await _getPreviousAssignments(NoParams());

    res.fold(
      (l) => emit(AssignmentFailure(l.message)),
      (r) => emit(AssignmentGetAllSuccess(r)),
    );
  }
}
