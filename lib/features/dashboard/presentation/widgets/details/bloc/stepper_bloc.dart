import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'stepper_event.dart';
part 'stepper_state.dart';

class StepperBloc extends Bloc<StepperEvent, StepperState> {
  StepperBloc() : super(StepperInitial()) {
    on<StepperEvent>((event, emit) => emit(StepperLoading()));
    on<ChangeStep>(_onChangeStep);
  }

  FutureOr<void> _onChangeStep(
    ChangeStep event,
    Emitter<StepperState> emit,
  ) async {
    emit(StepperLoading());

    await Future.delayed(const Duration(milliseconds: 300));

    emit(StepperChanged(event.step));
  }
}
