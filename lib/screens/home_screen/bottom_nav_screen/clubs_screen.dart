// ignore_for_file: must_be_immutable

import 'package:clubhub/screens/clubs_detail_screen.dart';
import 'package:flutter/material.dart';
import '../../../utils/ui_constant.dart';
import '../home_vm.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({
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
      body: viewModel.isLoading
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
                    'Clubs',
                    style: TextStyle(
                      fontSize: 28,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w800,
                      color: UiConstants.titleColor,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.clubsModel.length,
                    itemBuilder: (context, index) {
                      return CardEventWidget(
                        imageUrl: viewModel.clubsModel[index].image,
                        title: viewModel.clubsModel[index].name,
                        description: viewModel.clubsModel[index].description,
                        clubType: viewModel.clubsModel[index].type,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ClubsDetailScreen(
                                clubsModel: viewModel.clubsModel[index],
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
    required this.clubType,
    required this.onTap,
  });

  String imageUrl;
  String title;
  String description;
  String clubType;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(
          bottom: 16,
          left: 14,
          right: 14,
        ),
        elevation: 4,
        shadowColor: UiConstants.bgBottomColor,
        child: SizedBox(
          width: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30))),
                height: 180,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(48), // Image radius
                    child: imageUrl != ""
                        ? Image.network(
                            imageUrl,
                            fit: BoxFit.fill,
                          )
                        : Image.asset("assets/clubs_onboard.jpg"),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      clubType,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10,
                        color: UiConstants.blueColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
