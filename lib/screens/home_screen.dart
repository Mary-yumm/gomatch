import 'package:flutter/material.dart';
import 'package:gomatch/utils/colors.dart';

class HomeScreen extends StatelessWidget {
  static const String idScreen = "HomeScreen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height:40),
            Text(
              "Welcome to the Home Screen!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            
          ],
        ),
      ),
    );
  }
}
