import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const ProfilePage());
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
