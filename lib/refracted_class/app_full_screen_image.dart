import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_travel_app/refracted_widgets/app_colors.dart';
// ignore: depend_on_referenced_packages
import 'package:photo_view/photo_view.dart';
// ignore: depend_on_referenced_packages
import 'package:photo_view/photo_view_gallery.dart';



class FullScreenImagePageView extends StatelessWidget {
  final List<String> images;
  final int initialIndex;

  const FullScreenImagePageView({
    Key? key,
    required this.images,
    required this.initialIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoViewGallery.builder(
        itemCount: images.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: FileImage(File(images[index])),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
            heroAttributes: PhotoViewHeroAttributes(tag: 'imageHero$index'),
          );
        },
        scrollPhysics: const BouncingScrollPhysics(),
        pageController: PageController(initialPage: initialIndex),
        backgroundDecoration: const BoxDecoration(
          color:AppColors.black,
        ),
      ),
    );
  }
}
