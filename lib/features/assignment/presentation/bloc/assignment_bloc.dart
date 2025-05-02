import 'dart:async';
import 'dart:io';
import 'package:indotech_teknisi_app/core/usecase/usecase.dart';
import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/features/assignment/domain/usecases/get_all_assignments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'assignment_event.dart';
part 'assignment_state.dart';

class AssignmentBloc extends Bloc<AssignmentEvent, AssignmentState> {
  /* final UploadAssignment _uploadAssignment; */
  final GetAllAssignments _getAllAssignments;
  AssignmentBloc({
    /* required UploadAssignment uploadAssignment, */
    required GetAllAssignments getAllAssignments,
  }) : /* _uploadAssignment = uploadAssignment, */
       _getAllAssignments = getAllAssignments,
       super(AssignmentInitial()) {
    on<AssignmentEvent>((event, emit) => emit(AssignmentLoading()));
    /* on<AssignmentUpload>(_onAssignmentUpload); */
    on<AssignmentFetchAll>(_onAllAssignmentsRequested);
  }

  /* FutureOr<void> _onAssignmentUpload(
    AssignmentUpload event,
    Emitter<AssignmentState> emit,
  ) async {
    final res = await _uploadAssignment(
      UploadAssignmentParams(
        image: event.image,
        title: event.title,
        content: event.content,
        posterId: event.posterId,
        topics: event.topics,
      ),
    );

    res.fold(
      (l) => emit(AssignmentFailure(l.message)),
      (_) => emit(AssignmentUploadSuccess()),
    );
  } */

  FutureOr<void> _onAllAssignmentsRequested(
    AssignmentFetchAll event,
    Emitter<AssignmentState> emit,
  ) async {
    final res = await _getAllAssignments(NoParams());

    res.fold(
      (l) => emit(AssignmentFailure(l.message)),
      (r) => emit(AssignmentGetAllSuccess(r)),
    );
  }
}
