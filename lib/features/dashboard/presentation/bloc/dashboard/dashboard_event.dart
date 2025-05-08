part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

final class FetchDashboardData extends DashboardEvent {}