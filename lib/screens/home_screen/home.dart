import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:unicons/unicons.dart';
import '../../utils/ui_constant.dart';
import 'bottom_nav_screen/home_screen.dart';
import 'bottom_nav_screen/profile_screen.dart';
import 'bottom_nav_screen/clubs_screen.dart';
import 'home_vm.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 1. This method call when app in terminated state and you get a notification
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          // LocalNotificationService.display(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (viewModel) {
        viewModel.initialise(context);
      },
      builder: (context, viewModel, child) {
        final tabs = [
          HomeScreen(
            mainContext: context,
            viewModel: viewModel,
          ),
          SettingScreen(
            mainContext: context,
            viewModel: viewModel,
          ),
          ProfileScreen(
            mainContext: context,
            viewModel: viewModel,
          ),
        ];
        return Scaffold(
          backgroundColor: UiConstants.whiteColor,
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              print(FirebaseMessaging.instance.getToken().toString());
              viewModel.tabChange(value);
              if (value == 0) {
                viewModel.getEvents();
              }
            },
            currentIndex: viewModel.currentIndex,
            selectedItemColor: UiConstants.secondaryColor,
            backgroundColor: UiConstants.bgBottomColor,
            unselectedItemColor: UiConstants.greyColor1,
            iconSize: 26,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(UniconsLine.estate),
                label: 'Home',
                backgroundColor: UiConstants.whiteColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(UniconsLine.layer_group),
                label: 'Clubs',
                backgroundColor: UiConstants.mainColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  UniconsLine.user,
                ),
                label: 'Profile',
                backgroundColor: UiConstants.whiteColor,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: tabs[viewModel.currentIndex],
          ),
        );
      },
    );
  }
}
