import 'package:indotech_teknisi_app/core/common/widgets/loader.dart';
import 'package:indotech_teknisi_app/core/utils/show_snackbar.dart';
import 'package:indotech_teknisi_app/features/dashboard/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:indotech_teknisi_app/features/dashboard/presentation/widgets/dashboard/assignment_card.dart';
import 'package:indotech_teknisi_app/features/dashboard/presentation/widgets/dashboard/technician_card.dart';
import 'package:indotech_teknisi_app/features/auth/presentation/pages/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const DashboardPage());
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(FetchDashboardData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'What\'s New?',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: false,

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(context, ProfilePage.route());
              },
              icon: const Icon(Icons.person_rounded, size: 30),
            ),
          ),
        ],
      ),
      body: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is DashboardFailure) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Loader();
          }
          if (state is DashboardGetAllSuccess) {
            final assignment = state.assignments;
            final technician = state.user;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TechnicianCard(user: technician),
                  const SizedBox(height: 16),
                  AssignmentCard(assignment: assignment!),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
