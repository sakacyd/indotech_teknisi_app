import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indotech_teknisi_app/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:indotech_teknisi_app/core/common/widgets/loader.dart';
import 'package:indotech_teknisi_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:indotech_teknisi_app/features/auth/presentation/pages/login_page.dart';
import 'package:indotech_teknisi_app/features/auth/presentation/widgets/profile_details.dart';

class ProfilePage extends StatelessWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const ProfilePage());

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppUserCubit, AppUserState>(
      builder: (context, state) {
        if (state is AuthLoading || state is AppUserInitial) {
          return const Scaffold(body: Center(child: Loader()));
        }

        if (state is! AppUserLoggedIn) {
          return const Scaffold(
            body: Center(child: Text('Tidak ada data user')),
          );
        }

        final user = state.user;
        final double screenWidth = MediaQuery.of(context).size.width;
        final double screenHeight = MediaQuery.of(context).size.height;

        return Scaffold(
          appBar: AppBar(title: const Text('Profile')),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: screenHeight * 0.2,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: screenWidth * 0.14,
                            backgroundColor: Colors.red,
                            child: CircleAvatar(
                              radius: screenWidth * 0.13,
                              backgroundColor: Colors.blue,
                              child: Icon(
                                Icons.person,
                                size: screenWidth * 0.1,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ProfileDetails(user: user),
                const SizedBox(height: 110),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
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
                      const SizedBox(height: 10),
                      Text(
                        "Version 1.0.10",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
