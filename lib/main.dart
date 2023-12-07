// ignore_for_file: depend_on_referenced_packages
import 'package:clubhub/services/post_repo.dart';
import 'package:clubhub/utils/firebase_notification.dart';
import 'package:clubhub/utils/nav_constants.dart';
import 'package:clubhub/utils/ui_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/userModel.dart';
import 'utils/const_text.dart';

bool? isLogin = false;
String? accessToken = "";
String? emailId = "";
var logger = Logger();
late FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FToast fToast = FToast();
PostRepo postRepo = PostRepo();
late SharedPreferences prefs;
late UserModel userModel;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseNotification().initNotification();
  await FirebaseNotification().initLocalNotifications();
  FirebaseMessaging.instance.subscribeToTopic("notification");
  prefs = await SharedPreferences.getInstance();
  isLogin = prefs.getBool(ConstText.isLoggedKey);
  accessToken = prefs.getString(ConstText.accessTokenKey);
  emailId = prefs.getString(ConstText.emailIdKey);
  // AuthServices().signOut();
  runApp(const Core());
}

class Core extends StatelessWidget {
  const Core({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    logger.i(
        "firebseAuth :: ${firebaseAuth.currentUser?.uid} \nlogin :: $isLogin\nAccess Token :: $accessToken");
    return MaterialApp(
      useInheritedMediaQuery: true,
      // builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigationKey,
      title: 'TheClubHub',
      theme: ThemeData(
        fontFamily: "Jost",
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: UiConstants.mainColor,
          secondary: UiConstants.secondaryColor,
        ),
      ),
      initialRoute: firebaseAuth.currentUser?.uid == null
          ? NavigationConstants.AUTHENTICATIONROUTE
          : NavigationConstants.HOMEROUTE,
      routes: NavigationConstants.routes,
    );
  }
}
