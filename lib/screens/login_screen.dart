import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 65.0),
          Image(
            image: AssetImage("assets/images/logo.png"),
            width: 120.0,
            height: 120.0,
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
