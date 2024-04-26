import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery/features/image_gallery/image_gallery_page.dart';
import 'package:image_gallery/features/image_gallery/image_gallery_vm.dart';
import 'package:image_gallery/state/app_state.dart';

class ImageGalleryConnector extends StatelessWidget {
  const ImageGalleryConnector({super.key});

  static const route = '/image-gallery-connector';
  static const routeName = 'image-gallery-connector';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ImageGalleryVm>(
      vm: () => ImageGalleryVmFactory(),
      builder: (_, vm) => ImageGalleryPage(
        onLoggedOut: vm.onLoggedOut,
        images: vm.getImages,
      ),
    );
  }
}
