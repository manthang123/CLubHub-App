// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:clubhub/screens/event_detail_screen.dart';
import 'package:flutter/material.dart';

import '../../../utils/ui_constant.dart';
import '../home_vm.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
    this.viewModel,
    required this.mainContext,
  });

  HomeViewModel? viewModel;
  final BuildContext mainContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiConstants.whiteColor,
      body: viewModel!.isLoading
          ? const Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: UiConstants.bgButton,
                  strokeWidth: 3,
                ),
              ),
            )
          : Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Upcoming Events',
                    style: TextStyle(
                      fontSize: 28,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w800,
                      color: UiConstants.titleColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 200,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 2),
                      height: 180.0,
                      enlargeCenterPage: true,
                      onPageChanged: (position, reason) {
                        print(reason);
                        print(CarouselPageChangedReason.controller);
                      },
                      enableInfiniteScroll: false,
                    ),
                    // items: sliderImage.map<Widget>((image) {
                    //   return Builder(
                    //     builder: (BuildContext context) {
                    //       return SizedBox(
                    //         width: MediaQuery.of(context).size.width,
                    //         child: ClipRRect(
                    //           borderRadius: BorderRadius.circular(10),
                    //           child: SizedBox.fromSize(
                    //             size: const Size.fromRadius(48), // Image radius
                    //             child: Image.network(
                    //               image,
                    //               fit: BoxFit.fill,
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   );
                    // }).toList(),
                    items: [
                      GestureDetector(
                        onTap: () {
                          launchUrlWeb(url: viewModel!.homeSliderModel[0].url);
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(48), // Image radius
                              child: Image.network(
                                viewModel!.homeSliderModel[0].image,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          launchUrlWeb(url: viewModel!.homeSliderModel[1].url);
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(48), // Image radius
                              child: Image.network(
                                viewModel!.homeSliderModel[1].image,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          launchUrlWeb(url: viewModel!.homeSliderModel[2].url);
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(48), // Image radius
                              child: Image.network(
                                viewModel!.homeSliderModel[2].image,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Events',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: UiConstants.titleColor,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel?.eventsModel.length,
                    itemBuilder: (context, index) {
                      return CardEventWidget(
                        imageUrl: viewModel!.eventsModel[index].image,
                        title: viewModel!.eventsModel[index].title,
                        description: viewModel!.eventsModel[index].description,
                        clubName: viewModel!.eventsModel[index].clubName,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EventDetailScreen(
                                eventsModel: viewModel!.eventsModel[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class CardEventWidget extends StatelessWidget {
  CardEventWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.clubName,
    required this.onTap,
  });

  String imageUrl;
  String title;
  String description;
  String clubName;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 15,
        ),
        elevation: 4,
        shadowColor: UiConstants.bgBottomColor,
        child: SizedBox(
          width: 250,
          child: Row(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30))),
                height: 80,
                width: 100,
                child: imageUrl != ""
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.fill,
                      )
                    : Image.asset("assets/clubs_onboard.jpg"),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: UiConstants.titleColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: UiConstants.greyColor0,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      clubName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10,
                        color: UiConstants.blueColor,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
