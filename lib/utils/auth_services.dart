import 'package:clubhub/main.dart';
import 'package:clubhub/screens/auth/createaccount_screen.dart';
import 'package:clubhub/screens/home_screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/home_screen/home_vm.dart';

class AuthServices {
  // handle auth state
  handleAuthState(BuildContext context, HomeViewModel viewModel) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const Home();
        } else {
          return const CreateAccountScreen();
        }
      },
    );
  }

  signOut() {
    prefs.clear();
    FirebaseAuth.instance.signOut();
  }
}
