import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xteamtask/screens/app_screen.dart';
import 'package:xteamtask/screens/authentication_screen.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data?.emailVerified == true) {
          return AppScreen(); // here app screen
        } else {
          return AuthScreen(); // here reg screen
        }
      },
    ));
  }
}
