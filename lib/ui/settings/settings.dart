import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        backgroundColor: AppColors.orange,
        elevation: 4.0,
        centerTitle: true,
        automaticallyImplyLeading: false, // Remove the back arrow
      ),
    );
  }
}