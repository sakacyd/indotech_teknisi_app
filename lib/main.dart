import 'package:indotech_teknisi_app/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:indotech_teknisi_app/core/common/cubits/cubit/bottom_nav_cubit.dart';
import 'package:indotech_teknisi_app/core/theme/theme.dart';
import 'package:indotech_teknisi_app/features/assignment/presentation/bloc/assignment_bloc.dart';
import 'package:indotech_teknisi_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:indotech_teknisi_app/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indotech_teknisi_app/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:indotech_teknisi_app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:indotech_teknisi_app/init_dependencies.dart';
import 'package:indotech_teknisi_app/main_page.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'id_ID';
  initializeDateFormatting('id_ID', '');

  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<DashboardBloc>()),
        BlocProvider(create: (_) => serviceLocator<AssignmentBloc>()),
        BlocProvider(create: (_) => BottomNavCubit()),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog Application',
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const MainPage();
          }
          return const LoginPage();
        },
      ),
    );
  }
}
