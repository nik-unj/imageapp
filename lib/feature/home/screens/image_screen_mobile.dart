import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imageapp/constant/app_string.dart';
import 'package:imageapp/constant/app_style.dart';
import 'package:imageapp/feature/home/controller/home_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ImageScreenMobile extends StatefulWidget {
  final List<dynamic> imagesList;
  const ImageScreenMobile({
    super.key,
    required this.imagesList,
  });

  @override
  State<ImageScreenMobile> createState() => _ImageScreenMobileState();
}

class _ImageScreenMobileState extends State<ImageScreenMobile> {
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
              child: CachedNetworkImage(
                imageUrl: widget.imagesList[index].url,
                progressIndicatorBuilder: (context, url, progress) {
                  return Skeletonizer(
                      enabled: true,
                      child: SizedBox(
                        height: AppStyle.height(context),
                        width: AppStyle.width(context),
                      ));
                },
                errorWidget: (context, url, error) {
                  return Text(
                    "Something went wrong",
                    style: AppStyle.errorText(),
                  );
                },
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
          color: AppStyle.primary.withOpacity(0.8),
          padding: const EdgeInsets.only(top: 20, left: 5),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppStyle.white,
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
            color: AppStyle.primary.withOpacity(0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.rotate_left,
                    color: AppStyle.white,
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
                    color: AppStyle.white,
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
                    color: AppStyle.white,
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
                    color: AppStyle.white,
                    size: 30,
                  ),
                  onPressed: () {
                    showModalBottomSheet<void>(
                      backgroundColor: Colors.grey.shade200.withOpacity(0.8),
                      context: context,
                      builder: (BuildContext context) {
                        return ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
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
                                      style: AppStyle.headingBlack(),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppString.name,
                                          style: AppStyle.headingBlack()
                                              .copyWith(fontSize: 15),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            widget.imagesList[index].name,
                                            maxLines: 3,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          AppString.uploadDate,
                                          style: AppStyle.headingBlack()
                                              .copyWith(fontSize: 15),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            widget.imagesList[index].date,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
