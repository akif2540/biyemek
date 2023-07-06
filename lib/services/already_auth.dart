import 'package:biyemek/screens/business_screens/home/home_screen.dart';
import 'package:biyemek/screens/onboarding/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is logged in
          if (snapshot.hasData) {
            return const BusinessHomePage();
          }
          //user is not logged in
          else {
            return const IntroductionScreen();
          }
        },
      ),
    );
  }
}
