import 'dart:convert';
import 'package:clubhub/main.dart';
import 'package:clubhub/models/authentication.dart';
import 'package:clubhub/screens/auth/createaccount_vm.dart';
import 'package:clubhub/utils/ui_constant.dart';
import 'package:clubhub/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:logger/logger.dart';

import '../utils/const_text.dart';

class PostRepo with ChangeNotifier {
  Logger logger = Logger();
  late AuthenticationModel authenticationModel;

  //Create user api call
  Future<Response> authentication(
    String username,
    String email,
    String profileUrl,
  ) async {
    try {
      Response response = await http.post(
        Uri.parse('${ConstText.baseUrl}/user/authentication.php'),
        headers: {
          'content-type': 'application/json',
          "username": username,
          "profile": profileUrl,
          "email_id": email,
        },
        body: jsonEncode({}),
      );
      // userFromJson(response.body);
      authenticationModel = authenticationModelFromJson(response.body);
      logger.i(authenticationModel.token);
      prefs.setString(ConstText.accessTokenKey, authenticationModel.token);
      CreateAccountScreenViewModel().authenticationModel = authenticationModel;
      showToast(
        fToast: fToast,
        message: authenticationModel.message,
        colorVal: UiConstants.darkColorPurple,
      );

      logger.i("authentication api response. \n ${response.body}");

      /// all the decoding part is been done by the model file.
      return response;
    } catch (e) {
      logger.e("Create user api failed. \n ${e.toString()}");
      rethrow;
    }
  }
}
