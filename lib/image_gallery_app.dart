import 'package:flutter/material.dart';
import 'package:image_gallery/utilities/app_router.dart';

class ImageGalleryApp extends StatefulWidget {
  const ImageGalleryApp({super.key});

  @override
  State<ImageGalleryApp> createState() => _ImageGalleryAppState();
}

class _ImageGalleryAppState extends State<ImageGalleryApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Image Gallery',
      debugShowCheckedModeBanner: false,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
