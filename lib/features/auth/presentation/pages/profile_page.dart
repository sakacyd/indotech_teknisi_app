import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indotech_teknisi_app/core/common/widgets/loader.dart';
import 'package:indotech_teknisi_app/core/utils/show_snackbar.dart';
import 'package:indotech_teknisi_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:indotech_teknisi_app/features/auth/presentation/pages/login_page.dart';
import 'package:indotech_teknisi_app/features/auth/presentation/widgets/profile_details.dart';

class ProfilePage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const ProfilePage());

  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Loader();
          }

          if (state is AuthSuccess) {
            final user = state.user;

            final double screenWidth = MediaQuery.of(context).size.width;
            final double screenHeight = MediaQuery.of(context).size.height;

            return SingleChildScrollView(
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
                            ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: user.imageUrl,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                                placeholder:
                                    (context, url) => const SizedBox(
                                      width: 120,
                                      height: 120,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                errorWidget:
                                    (context, url, error) =>
                                        const Icon(Icons.error),
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
                  const SizedBox(height: 30),
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
            );
          }

          // Default fallback UI
          return const Loader();
        },
      ),
    );
  }
}
