import 'dart:async';
import 'package:indotech_teknisi_app/core/usecase/usecase.dart';
import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/features/assignment/domain/usecases/get_previous_assignments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<AssignmentEvent, AssignmentState> {
  final GetPreviousAssignments _getPreviousAssignments;
  HistoryBloc({
    required GetPreviousAssignments getPreviousAssignments,
  }) : 
       _getPreviousAssignments = getPreviousAssignments,
       super(AssignmentInitial()) {
    on<FetchPreviousAssignments>(_onPreviousAssignmentsRequested);
  }

  FutureOr<void> _onPreviousAssignmentsRequested(
    FetchPreviousAssignments event,
    Emitter<AssignmentState> emit,
  ) async {
    emit(AssignmentLoadingPrevious());
    final res = await _getPreviousAssignments(NoParams());

    res.fold(
      (l) => emit(AssignmentFailure(l.message)),
      (r) => emit(AssignmentGetPreviousSuccess(r)),
    );
  }
}
