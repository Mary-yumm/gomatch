import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gomatch/screens/home_screen.dart';

Future<void> loginUser(BuildContext context, String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    if (userCredential.user != null) {
      Navigator.pushNamedAndRemoveUntil(context, HomeScreen.idScreen, (route) => false);
    }
  } on FirebaseAuthException catch (e) {
    String errorMessage;
    if (e.code == 'user-not-found') {
      errorMessage = "No user found for that email.";
    } else if (e.code == 'wrong-password') {
      errorMessage = "Wrong password provided.";
    } else {
      errorMessage = "Login failed. Please try again.";
    }
    displayToastMessage(errorMessage, context);
  }
}

void displayToastMessage(String message, BuildContext context) {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 3),
  );
  scaffoldMessenger.showSnackBar(snackBar);  // Using ScaffoldMessenger correctly
}
