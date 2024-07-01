import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:imageapp/constant/app_assets.dart';
import 'package:imageapp/constant/app_string.dart';
import 'package:imageapp/constant/app_style.dart';
import 'package:imageapp/feature/home/controller/home_controller.dart';
import 'package:imageapp/feature/home/model/image_model.dart';
import 'package:imageapp/feature/image/image_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.primary.withOpacity(0.3),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(AppString.userCollection)
            .doc(homeController.user?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.hasData) {
            if (snapshot.data!.data()!['images'].length == 0) {
              return Center(
                child: Text(
                  AppString.noImages,
                  style: AppStyle.headingBlack(size: 25),
                ),
              );
            } else {
              List<dynamic> imagesList = snapshot.data!
                  .data()!['images']
                  .map((image) => ImageModel.fromMap(image))
                  .toList();
              return SafeArea(
                child: MasonryGridView.builder(
                  shrinkWrap: true,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: snapshot.data!.data()!['images'].length,
                  addRepaintBoundaries: false,
                  cacheExtent: 20,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(2),
                      child: GestureDetector(
                        onLongPress: () {
                          showAlertDialog(context, index, imagesList);
                        },
                        onTap: () {
                          homeController.selectedIndex.value = index;
                          Get.to(() => ImageScreen(imagesList: imagesList));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            memCacheWidth: AppStyle.width(context) ~/ 2,
                            imageUrl: imagesList[index].url,
                            placeholder: (context, url) => Skeletonizer(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  AppAssets.bg1,
                                  fit: BoxFit.fill,
                                  height: 250,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppStyle.primary,
              ),
            );
          }
          return Text('Error ${snapshot.error}');
        },
      ),
    );
  }

  showAlertDialog(BuildContext context, int index, List imagesList) {
    Widget cancelButton = GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Text(
        "Cancel",
        style: AppStyle.normalText().copyWith(
          color: AppStyle.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
    Widget deleteButton = GestureDetector(
      onTap: () {
        Get.back();
        homeController.deleteImage(imagesList[index]);
      },
      child: Text(
        "Delete",
        style: AppStyle.normalText().copyWith(
          color: AppStyle.error,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
    AlertDialog alert = AlertDialog(
      title: Text(
        "Delete Image",
        style: AppStyle.headingBlack(),
      ),
      content: Text(
        "Are you sure you to delete the image",
        style: AppStyle.normalText().copyWith(color: AppStyle.black),
      ),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
