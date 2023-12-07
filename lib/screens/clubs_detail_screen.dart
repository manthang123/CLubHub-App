import 'package:clubhub/models/clubsModel.dart';
import 'package:clubhub/utils/ui_constant.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ClubsDetailScreen extends StatelessWidget {
  ClubsDetailScreen({super.key, required this.clubsModel});
  ClubsModel clubsModel;
  @override
  Widget build(BuildContext context) {
    double members = double.parse(clubsModel.members);
    double events = double.parse(clubsModel.totalEvents);
    Map<String, double> dataMap = {
      "Members": members,
      "Events": events,
    };
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: UiConstants.bgButton,
            size: 22,
          ),
        ),
        backgroundColor: UiConstants.whiteColor,
        title: const Text(
          'Club Details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: UiConstants.bgButton,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  width: double.infinity,
                  height: 190,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(48), // Image radius
                      child: Image.network(clubsModel.image, fit: BoxFit.fill),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    "President: ${clubsModel.president}",
                    style: const TextStyle(
                      fontSize: 13,
                      color: UiConstants.darkColorPurple,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Type: ${clubsModel.type}",
                    style: const TextStyle(
                      fontSize: 13,
                      color: UiConstants.darkColorPurple,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                clubsModel.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                clubsModel.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: UiConstants.describeColor,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(
                    Icons.groups_rounded,
                    color: UiConstants.describeColor,
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    "Members",
                    style: TextStyle(
                      fontSize: 14,
                      color: UiConstants.describeColor,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Text(
                    clubsModel.members,
                    style: const TextStyle(
                      fontSize: 15,
                      color: UiConstants.describeColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  "Connect With Us",
                  style: TextStyle(
                      fontSize: 16,
                      color: UiConstants.redColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 15),
              clubsModel.whatsapp.isNotEmpty
                  ? CustomButton(
                      image: Image.asset("assets/icons/whatsapp.png"),
                      onTap: () {
                        launchUrlWeb(url: clubsModel.whatsapp);
                      },
                      textVal: "Whatsapp",
                    )
                  : Container(),
              const SizedBox(height: 15),
              clubsModel.instagram.isNotEmpty
                  ? CustomButton(
                      image: Image.asset("assets/icons/instagram.png"),
                      onTap: () {
                        launchUrlWeb(url: clubsModel.instagram);
                      },
                      textVal: "Instagram",
                    )
                  : Container(),
              const SizedBox(height: 15),
              clubsModel.twitter.isNotEmpty
                  ? CustomButton(
                      image: Image.asset("assets/icons/twitter.png"),
                      onTap: () {
                        launchUrlWeb(url: clubsModel.twitter);
                      },
                      textVal: "Twitter",
                    )
                  : Container(),
              const SizedBox(height: 15),
              clubsModel.linkedin.isNotEmpty
                  ? CustomButton(
                      image: Image.asset("assets/icons/linkedin.png"),
                      onTap: () {
                        launchUrlWeb(url: clubsModel.linkedin);
                      },
                      textVal: "LinkedIn",
                    )
                  : Container(),
              const SizedBox(height: 30),
              PieChart(dataMap: dataMap),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
// Image.asset("assets/clubs_onboard.jpg")

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.onTap,
    required this.image,
    required this.textVal,
  });

  Function() onTap;
  Image image;
  String textVal;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        elevation: const MaterialStatePropertyAll(3),
        backgroundColor: const MaterialStatePropertyAll(
          UiConstants.whiteColor,
        ),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(vertical: 6),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        child: Row(
          children: [
            SizedBox(
              width: 25,
              height: 25,
              child: image,
            ),
            const SizedBox(width: 10),
            Text(
              textVal,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: UiConstants.titleColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> launchUrlWeb({required String url}) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  }
}
