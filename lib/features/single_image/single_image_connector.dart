import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_gallery/features/single_image/single_image.dart';
import 'package:image_gallery/features/single_image/single_image_vm.dart';
import 'package:image_gallery/state/app_state.dart';

class SingleImageConnector extends ConsumerWidget {
  const SingleImageConnector({
    required this.imagePath,
    super.key,
  });

  final String imagePath;

  static const route = 'single-image-connector';
  static const routeName = 'single-image-connector';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StoreConnector<AppState, SingleImageVm>(
      vm: () => SingleImageVmFactory(),
      builder: (_, vm) => SingleImage(
        isTabA: vm.isTabA,
        isInCarousel: vm.isInCarousel,
        onTransferTab: vm.onTransferTab,
        onCheckCarousel: vm.onCheckCarousel,
        imagePath: imagePath,
      ),
    );
  }
}
