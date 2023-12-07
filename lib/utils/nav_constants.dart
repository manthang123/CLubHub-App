// ignore_for_file: constant_identifier_names

import 'package:clubhub/screens/auth/createaccount_screen.dart';
import 'package:clubhub/screens/home_screen/home.dart';

class NavigationConstants {
  static const String AUTHENTICATIONROUTE = "/authentication";
  static const String HOMEROUTE = "/home";

  static final routes = {
    AUTHENTICATIONROUTE: (context) => const CreateAccountScreen(),
    HOMEROUTE: (context) => const Home(),
  };
}
