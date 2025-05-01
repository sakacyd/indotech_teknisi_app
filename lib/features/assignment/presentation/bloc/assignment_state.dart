part of 'assignment_bloc.dart';

@immutable
sealed class AssignmentState {}

final class AssignmentInitial extends AssignmentState {}

final class AssignmentLoading extends AssignmentState {}

final class AssignmentUploadSuccess extends AssignmentState {
}
final class AssignmentGetAllSuccess extends AssignmentState {
  final List<Assignment> assignments;

  AssignmentGetAllSuccess(this.assignments);
}

final class AssignmentFailure extends AssignmentState {
  final String message;

  AssignmentFailure(this.message);
}
