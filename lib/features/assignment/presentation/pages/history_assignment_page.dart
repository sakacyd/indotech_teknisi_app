import 'package:indotech_teknisi_app/core/common/widgets/loader.dart';
import 'package:indotech_teknisi_app/core/utils/show_snackbar.dart';
import 'package:indotech_teknisi_app/features/assignment/presentation/bloc/assignment_bloc.dart';
/* import 'package:indotech_teknisi_app/features/assignment/presentation/pages/add_new_assignment_page.dart'; */
import 'package:indotech_teknisi_app/features/assignment/presentation/widgets/assignment_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indotech_teknisi_app/features/auth/presentation/pages/profile_page.dart';

class HistoryAssignmentPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const HistoryAssignmentPage());
  const HistoryAssignmentPage({super.key});

  @override
  State<HistoryAssignmentPage> createState() => _HistoryAssignmentPageState();
}

class _HistoryAssignmentPageState extends State<HistoryAssignmentPage> {
  @override
  void initState() {
    super.initState();
    context.read<AssignmentBloc>().add(FetchPreviousAssignments());
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
      ),
      body: BlocConsumer<AssignmentBloc, AssignmentState>(
        listener: (context, state) {
          if (state is AssignmentFailure) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is AssignmentLoading) {
            return const Loader();
          }
          if (state is AssignmentGetPreviousSuccess) {
            if (state.assignments.isEmpty) {
              return const Center(
                child: Text(
                  'Tidak ada pekerjaan sebelumnya',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            return ListView.builder(
              itemCount: state.assignments.length,
              itemBuilder: (context, index) {
                final assignment = state.assignments[index];
                return AssignmentCard(assignment: assignment);
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
