// ignore_for_file: must_be_immutable
import 'package:clubhub/main.dart';
import 'package:clubhub/widgets/custom_dialogboxes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/ui_constant.dart';
import '../home_vm.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({
    super.key,
    required this.viewModel,
    required this.mainContext,
  });

  HomeViewModel viewModel;
  final BuildContext mainContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiConstants.whiteColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'My Profile',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: UiConstants.titleColor,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  height: 110,
                  width: 110,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: UiConstants.bgColorGrey,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 233, 243, 255),
                        blurRadius: 10.0,
                        spreadRadius: 6,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 48,
                    backgroundColor: UiConstants.whiteColor,
                    backgroundImage: NetworkImage(
                      firebaseAuth.currentUser!.photoURL.toString() != ""
                          ? firebaseAuth.currentUser!.photoURL.toString()
                          : "https://www.pngmart.com/files/22/User-Avatar-Profile-PNG-Isolated-Transparent-Picture.png",
                    ), // Image radius
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Username
              ProfileTitleWidget(title: "Username"),
              squareBoxValue(
                  textValue: firebaseAuth.currentUser!.displayName.toString()),
              const SizedBox(height: 10),
              // Email Id
              ProfileTitleWidget(title: "Email Id"),
              squareBoxValue(
                  textValue: firebaseAuth.currentUser!.email.toString()),
              const SizedBox(height: 20),
              const Text(
                "Support",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              // About Us
              ProfileButtons(
                  onTap: () {
                    launchUrlWeb(url: "https://google.com");
                  },
                  buttonText: "About Us"),
              // Privacy Policy
              ProfileButtons(
                  onTap: () {
                    launchUrlWeb(url: "https://google.com");
                  },
                  buttonText: "Privacy Policy"),
              // Terms Condition
              ProfileButtons(
                onTap: () {
                  launchUrlWeb(url: "https://google.com");
                },
                buttonText: "Terms & Condition",
              ),

              // Save Button
              const SizedBox(height: 60),
              Center(
                child: SizedBox(
                  width: 280,
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.logout_outlined,
                      color: UiConstants.whiteColor,
                    ),
                    onPressed: () {
                      AlertBox(
                        context: context,
                        icon: Icons.login_rounded,
                        titleTextColor: UiConstants.bgButton,
                        title: "Are you sure?",
                        messageText: "Do you want to logout this account",
                        button1Text: "Logout",
                        button1Color: UiConstants.redColor,
                        button1OnClick: () {
                          HomeViewModel().signOut();
                        },
                        button2OnClick: () {
                          Navigator.pop(context);
                        },
                        button2Text: "Cancel",
                        button2Color: UiConstants.bgLogoutButton,
                      );
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      backgroundColor: const MaterialStatePropertyAll(
                        UiConstants.bgButton,
                      ),
                      padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                    label: const Text(
                      'Log Out',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: UiConstants.whiteColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding squareBoxValue({
    required String textValue,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          // border: Border.all(color: UiConstants.whiteColor),
          borderRadius: BorderRadius.circular(10),
          color: UiConstants.bgColorGreyLight,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            textValue != "" ? textValue : "VIIT Clubs",
            style: const TextStyle(
              color: UiConstants.titleColor,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> launchUrlWeb({required String url}) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}

class ProfileTitleWidget extends StatelessWidget {
  ProfileTitleWidget({
    super.key,
    required this.title,
  });

  String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
              color: UiConstants.titleColor,
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class ProfileButtons extends StatelessWidget {
  ProfileButtons({
    super.key,
    required this.onTap,
    required this.buttonText,
  });

  Function onTap;
  String buttonText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        margin: const EdgeInsets.only(bottom: 1.5),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          child: Row(
            children: [
              Text(
                buttonText,
                style: const TextStyle(
                    color: UiConstants.describeColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
              const Spacer(
                flex: 2,
              ),
              const Icon(
                Icons.keyboard_arrow_right_rounded,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
