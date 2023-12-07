import 'package:clubhub/utils/ui_constant.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/eventsModel.dart';

// ignore: must_be_immutable
class EventDetailScreen extends StatelessWidget {
  EventDetailScreen({super.key, required this.eventsModel});
  EventsModel eventsModel;
  @override
  Widget build(BuildContext context) {
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
          'Event Details',
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
                      child: Image.network(eventsModel.image, fit: BoxFit.fill),
                    ),
                  ),
                ),
              ),
              Text(
                "Event by: ${eventsModel.clubName}",
                style: const TextStyle(
                  fontSize: 13,
                  color: UiConstants.darkColorPurple,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                eventsModel.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                eventsModel.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: UiConstants.describeColor,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Event Details",
                style: TextStyle(
                  fontSize: 16,
                  color: UiConstants.redColor,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.timer_rounded,
                        color: UiConstants.describeColor,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        eventsModel.eventTime,
                        style: const TextStyle(
                          fontSize: 16,
                          color: UiConstants.describeColor,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(
                        Icons.date_range_rounded,
                        color: UiConstants.describeColor,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        eventsModel.eventDate.toString().substring(0, 10),
                        style: const TextStyle(
                          fontSize: 16,
                          color: UiConstants.describeColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_rounded,
                    color: UiConstants.describeColor,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "Venue: ${eventsModel.venue}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: UiConstants.describeColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100),
              Center(
                child: SizedBox(
                  width: 280,
                  child: ElevatedButton(
                    onPressed: () {
                      launchUrlWeb(url: eventsModel.url);
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
                    child: const Text(
                      'Register Now',
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
}

Future<void> launchUrlWeb({required String url}) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  }
}
