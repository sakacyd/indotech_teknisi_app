part of 'today_bloc.dart';

@immutable
sealed class AssignmentEvent {}

final class FetchTodayAssignments extends AssignmentEvent {}
