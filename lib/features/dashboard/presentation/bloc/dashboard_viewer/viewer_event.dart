part of 'viewer_bloc.dart';

@immutable
sealed class ViewerEvent {}

final class ChangeStep extends ViewerEvent {
  final int step;

  ChangeStep(this.step);
}

final class UpdateTechnicianArrivedAtEvent extends ViewerEvent {
  final Assignment assignment;

  UpdateTechnicianArrivedAtEvent({required this.assignment});

  @override
  List<Object?> get props => [assignment];
}

final class CompleteViewer extends ViewerEvent {}
