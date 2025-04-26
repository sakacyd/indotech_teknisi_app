import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indotech_teknisi_app/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:indotech_teknisi_app/core/common/widgets/loader.dart';
import 'package:indotech_teknisi_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:indotech_teknisi_app/features/auth/presentation/pages/login_page.dart';

class ProfilePage extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => const ProfilePage());

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppUserCubit>().state;

    if (state is! AppUserLoggedIn) {
      return const Center(child: Loader());
    }

    final user = state.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.photoUrl ?? ''),
              child: user.photoUrl == null ? const Icon(Icons.person, size: 50) : null,
            ), */
            const SizedBox(height: 16),
            Text('Name: ${user.name}', style: const TextStyle(fontSize: 18)),
            Text('Email: ${user.email}', style: const TextStyle(fontSize: 18)),
            Text('ID: ${user.id}', style: const TextStyle(fontSize: 18)),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthSignOut());
                Navigator.pushAndRemoveUntil(
                  context,
                  LoginPage.route(),
                  (route) => false,
                );
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}