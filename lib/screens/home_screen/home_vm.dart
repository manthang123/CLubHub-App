// ignore_for_file: use_build_context_synchronously

import 'package:clubhub/models/clubsModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../../models/eventsModel.dart';
import '../../models/homeSliderModel.dart';
import '../../models/userModel.dart';
import '../../services/getter_repo.dart';
import '../../utils/const_text.dart';
import '../../utils/nav_constants.dart';
import 'package:http/http.dart';

class HomeViewModel extends ChangeNotifier {
  late int _currentIndex = 0;
  late bool _isLoading = true;
  final GetterRepo _getterRepo = GetterRepo();
  late UserModel _userModel;
  late List<EventsModel> _eventsModel;
  late List<ClubsModel> _clubsModel;
  late List<HomeSliderModel> _homeSliderModel;
  Logger logger = Logger();
  int _activePage = 0;

  // Controllers
  PageController _pageController = PageController();

  // Getters
  int get currentIndex => _currentIndex;
  bool get isLoading => _isLoading;
  UserModel get userModel => _userModel;
  List<EventsModel> get eventsModel => _eventsModel;
  List<ClubsModel> get clubsModel => _clubsModel;
  List<HomeSliderModel> get homeSliderModel => _homeSliderModel;
  PageController get pageController => _pageController;
  int get activePage => _activePage;

  initialise(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString(ConstText.accessTokenKey);
    emailId = prefs.getString(ConstText.emailIdKey);
    _isLoading = true;
    fToast.init(context);
    initController();
  }

  void initController() {
    _pageController = PageController(viewportFraction: 0.8);
    getUser();
    getEvents();
    getClubs();
    getHomeSlider();
  }

  void tabChange(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  void sliderChange(int value) {
    _activePage = value;
    notifyListeners();
  }

  Future<void> getUser() async {
    Response response;
    response = await _getterRepo.getUser('$emailId', '$accessToken');

    if (response.statusCode == 202 || response.statusCode == 200) {
      _userModel = userModelFromJson(response.body);
    } else {
      logger.log(Level.error,
          "Login user failed ${response.body} and status code was ${response.statusCode}");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getEvents() async {
    Response response;
    response = await _getterRepo.getEvents();

    if (response.statusCode == 202 || response.statusCode == 200) {
      _eventsModel = eventsModelFromJson(response.body);
      logger.i("Get Event Responses " + response.body);
    } else {
      logger.log(Level.error,
          "Events call data failed ${response.body} and status code was ${response.statusCode}");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getClubs() async {
    Response response;
    response = await _getterRepo.getClubs();

    if (response.statusCode == 202 || response.statusCode == 200) {
      _clubsModel = clubsModelFromJson(response.body);
      logger.i(response.body);
    } else {
      logger.log(Level.error,
          "Clubs call data failed ${response.body} and status code was ${response.statusCode}");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getHomeSlider() async {
    Response response;
    response = await _getterRepo.getHomeSlider();

    if (response.statusCode == 202 || response.statusCode == 200) {
      _homeSliderModel = homeSliderModelFromJson(response.body);
      logger.i(response.body);
    } else {
      logger.log(Level.error,
          "Home Slider call data failed ${response.body} and status code was ${response.statusCode}");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseAuth.instance.signOut();
    prefs.clear();
    navService.pushNamedAndRemoveUntil(
      NavigationConstants.AUTHENTICATIONROUTE,
      args: true,
    );
    _isLoading = false;
    notifyListeners();
  }
}
