import 'package:indotech_teknisi_app/core/common/widgets/loader.dart';
import 'package:indotech_teknisi_app/core/utils/show_snackbar.dart';
import 'package:indotech_teknisi_app/features/assignment/presentation/bloc/assignment_bloc.dart';
/* import 'package:indotech_teknisi_app/features/assignment/presentation/pages/add_new_assignment_page.dart'; */
import 'package:indotech_teknisi_app/features/assignment/presentation/widgets/assignment_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indotech_teknisi_app/features/profile/presentation/pages/profile_page.dart';

class AssignmentPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const AssignmentPage());
  const AssignmentPage({super.key});

  @override
  State<AssignmentPage> createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  @override
  void initState() {
    super.initState();
    context.read<AssignmentBloc>().add(AssignmentFetchAll());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'What\'s New?',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(context, ProfilePage.route());
              },
              icon: const Icon(
                CupertinoIcons.add_circled,
                size: 30,
              ),
            ),
          ),
        ],
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
          if (state is AssignmentGetAllSuccess) {
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
