import 'package:clubhub/models/authentication.dart';
import 'package:clubhub/utils/const_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../main.dart';
import '../home_screen/home.dart';

class CreateAccountScreenViewModel extends ChangeNotifier {
  late FirebaseAuth mAuth;
  bool? newUser = false;
  bool loading = false;
  late AuthenticationModel authenticationModel;

  void initialise(BuildContext context) {
    fToast.init(context);
    initController();
  }

  void initController() {}

  signInWithGoogle({required BuildContext context}) async {
    loading = true;
    notifyListeners();
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;

    final GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.signOut();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    loading = false;
    notifyListeners();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        user = userCredential.user!;
        firebaseAuth = FirebaseAuth.instance;
        if (user.uid.isNotEmpty) {
          prefs.setString(ConstText.emailIdKey, user.email.toString());
          postRepo.authentication(
            user.displayName.toString(),
            user.email.toString(),
            user.photoURL.toString(),
          );
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
          );
        }

        loading = false;
      } on FirebaseAuthException catch (e) {
        loading = false;
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        loading = false;
        // handle the error here
      }
    }
    notifyListeners();
  }
}
