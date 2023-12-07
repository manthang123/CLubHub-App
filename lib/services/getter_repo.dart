import 'package:clubhub/main.dart';
import 'package:clubhub/models/clubsModel.dart';
import 'package:clubhub/models/eventsModel.dart';
import 'package:clubhub/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:logger/logger.dart';

import '../models/homeSliderModel.dart';
import '../utils/const_text.dart';

class GetterRepo with ChangeNotifier {
  Logger logger = Logger();
  late List<EventsModel> eventsModel;
  late List<ClubsModel> clubsModel;
  late List<HomeSliderModel> homeSliderModel;

  //Create user api call
  Future<Response> getUser(
    String email,
    String token,
  ) async {
    try {
      Response response = await http.get(
        Uri.parse('${ConstText.baseUrl}/user/user_info.php'),
        headers: {
          'content-type': 'application/json',
          'email_id': email,
          // 'Authorization': 'Bearer $token',
        },
      );
      userModel = userModelFromJson(response.body);

      logger.i('Get user response \n${response.body}');
      return response;
    } catch (e) {
      logger.e("Get user api failed. \n ${e.toString()}");
      rethrow;
    }
  }

  //Get Events
  Future<Response> getEvents() async {
    try {
      Response response = await http.get(
        Uri.parse('${ConstText.baseUrl}/events/get_events.php'),
        headers: {
          'content-type': 'application/json',
          // 'Authorization': 'Bearer $token',
        },
      );
      eventsModel = eventsModelFromJson(response.body);

      logger.i('Get events response \n${response.body}');
      return response;
    } catch (e) {
      logger.e("Get events api failed. \n ${e.toString()}");
      rethrow;
    }
  }

  //Get Clubs
  Future<Response> getClubs() async {
    try {
      Response response = await http.get(
        Uri.parse('${ConstText.baseUrl}/clubs/get_clubs.php'),
        headers: {
          'content-type': 'application/json',
          // 'Authorization': 'Bearer $token',
        },
      );
      clubsModel = clubsModelFromJson(response.body);

      logger.i('Get clubs response \n${response.body}');
      return response;
    } catch (e) {
      logger.e("Get clubs api failed. \n ${e.toString()}");
      rethrow;
    }
  }

  //Get Home Slider
  Future<Response> getHomeSlider() async {
    try {
      Response response = await http.get(
        Uri.parse('${ConstText.baseUrl}/home_slider/get_slider.php'),
        headers: {
          'content-type': 'application/json',
          // 'Authorization': 'Bearer $token',
        },
      );
      homeSliderModel = homeSliderModelFromJson(response.body);

      logger.i('Get home slider response \n${response.body}');
      return response;
    } catch (e) {
      logger.e("Get home slider api failed. \n ${e.toString()}");
      rethrow;
    }
  }
}
