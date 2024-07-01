import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imageapp/constant/app_assets.dart';
import 'package:imageapp/constant/app_string.dart';
import 'package:imageapp/constant/app_style.dart';
import 'package:imageapp/feature/home/controller/home_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ImageScreen extends StatefulWidget {
  final List<dynamic> imagesList;
  const ImageScreen({
    super.key,
    required this.imagesList,
  });

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final homeController = Get.put(HomeController());
  late PageController _pageController;
  double rotate = 0;
  int index = 0;
  double scale = 1;
  double defaultScale = 1;

  @override
  void initState() {
    _pageController =
        PageController(initialPage: homeController.selectedIndex.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.white,
      body: Stack(
        children: [
          imageBuilder(),
          appBar(),
          bottomBar(),
        ],
      ),
    );
  }

  Widget imageBuilder() {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.imagesList.length,
      itemBuilder: (BuildContext context, int index) {
        return Transform.scale(
          scale: scale,
          child: Transform.rotate(
            angle: rotate,
            child: GestureDetector(
              onScaleStart: (details) {
                setState(() {
                  defaultScale = scale;
                });
              },
              onScaleUpdate: (details) {
                setState(() {
                  scale = defaultScale * details.scale;
                });
              },
              onScaleEnd: (details) {
                setState(() {
                  defaultScale = 1;
                });
              },
              onDoubleTap: () {
                setState(() {
                  scale == 1 ? scale += 1 : scale = 1;
                });
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: widget.imagesList[index].url,
                  placeholder: (context, url) => Skeletonizer(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        AppAssets.bg1,
                        fit: BoxFit.fill,
                        height: 250,
                        width: 250,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
        );
      },
      onPageChanged: (value) {
        setState(() {
          rotate = 0;
          index = value;
          scale = 1;
        });
      },
    );
  }

  Widget appBar() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: AppStyle.black.withOpacity(0.2),
          padding: const EdgeInsets.only(top: 20, left: 5),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppStyle.black,
                ),
                onPressed: () => Get.back(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: AppStyle.black.withOpacity(0.2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.rotate_left,
                    color: AppStyle.black,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      rotate -= 3.14159 / 2;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.rotate_right,
                    color: AppStyle.black,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      rotate += 3.14159 / 2;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: AppStyle.black,
                    size: 30,
                  ),
                  onPressed: () {
                    homeController.deleteImage(widget.imagesList[index]);
                    if (widget.imagesList.length == 1) {
                      Get.back();
                    }
                    setState(() {
                      rotate = 0;
                      scale = 1;
                      widget.imagesList.removeAt(index);
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.more_horiz,
                    color: AppStyle.black,
                    size: 30,
                  ),
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return ClipRect(
                          child: SizedBox(
                            height: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppString.imageInfo,
                                    style: AppStyle.headingBlack(size: 20),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${AppString.name}:',
                                        style: AppStyle.normalText(),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          widget.imagesList[index].name,
                                          maxLines: 3,
                                          style: AppStyle.normalText(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${AppString.uploadDate}: ',
                                        style: AppStyle.normalText(),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          widget.imagesList[index].date,
                                          maxLines: 2,
                                          style: AppStyle.normalText(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
