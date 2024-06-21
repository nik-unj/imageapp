import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;
  const CustomNetworkImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: double.maxFinite,
      height: 150,
      fit: BoxFit.fill,
      imageUrl: url,
      placeholder: (context, url) => Skeletonizer(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: const SizedBox(
            height: 200,
            width: 200,
          ),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
