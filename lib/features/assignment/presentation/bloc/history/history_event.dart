part of 'history_bloc.dart';

@immutable
sealed class AssignmentEvent {}

final class FetchPreviousAssignments extends AssignmentEvent {}
