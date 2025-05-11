import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indotech_teknisi_app/features/assignment/data/models/assignment_model.dart';

part 'viewer_event.dart';
part 'viewer_state.dart';

class ViewerBloc extends Bloc<ViewerEvent, ViewerState> {
  ViewerBloc() : super(ViewerInitial()) {
    on<ViewerEvent>((event, emit) => emit(ViewerLoading()));
    on<CompleteViewer>((event, emit) async {
      emit(ViewerCompleted());
    });
    on<ChangeStep>(_onSlideSuccess);
  }

  FutureOr<void> _onSlideSuccess(
    ChangeStep event,
    Emitter<ViewerState> emit,
  ) async {
    emit(ViewerLoading());

    await Future.delayed(const Duration(milliseconds: 300));

    emit(StepperChanged(event.step));
  }
}
