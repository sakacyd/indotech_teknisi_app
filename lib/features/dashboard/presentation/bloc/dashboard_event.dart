part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

final class FetchNearestAssignment extends DashboardEvent {}

final class FetchTechnician extends DashboardEvent {}
