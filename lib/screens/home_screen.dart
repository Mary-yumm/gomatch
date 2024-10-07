import 'package:flutter/material.dart';
import 'package:gomatch/utils/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String idScreen = "Home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home",
          style:TextStyle(
            color: Colors.white,
          )
        ), // AppBar title
        backgroundColor: AppColors.primaryColor, // You can customize the color
      ),
      body: const Center(
        child: Text(
          "Welcome to the Home Screen!",
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}
