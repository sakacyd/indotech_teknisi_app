part of 'assignment_bloc.dart';

@immutable
sealed class AssignmentEvent {}

final class FetchTodayAssignments extends AssignmentEvent {}
final class FetchPreviousAssignments extends AssignmentEvent {}
