part of 'viewer_bloc.dart';

@immutable
sealed class ViewerEvent {}

final class ChangeStep extends ViewerEvent {
  final int step;

  ChangeStep(this.step);
}

final class CompleteViewer extends ViewerEvent {}
