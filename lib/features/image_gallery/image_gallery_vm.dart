import 'package:async_redux/async_redux.dart';
import 'package:image_gallery/api/isar/model/images.dart';
import 'package:image_gallery/features/image_gallery/image_gallery_connector.dart';
import 'package:image_gallery/state/app_state.dart';
import 'package:image_gallery/utilities/app_starter.dart';
import 'package:image_gallery/utilities/providers/isar_provider.dart';
import 'package:isar/isar.dart';

class ImageGalleryVmFactory extends VmFactory<AppState, ImageGalleryConnector, ImageGalleryVm> {
  Isar get isar => providerContainer.read(isarInstanceProvider);

  @override
  ImageGalleryVm fromStore() => ImageGalleryVm(
        getImages: getImages(),
        onLoggedOut: onLoggedOut,
      );

  Future<void> onLoggedOut() async {
    isar.writeTxnSync(() => isar.images.where().deleteAllSync());
  }

  Images getImages() {
    final images = isar.images.where().findFirstSync();

    return images ??
        Images(
          // cant possibly have this as image is initially defined
          carousel: List.empty(),
          tabA: List.empty(),
          tabB: List.empty(),
        );
  }
}

class ImageGalleryVm extends Vm {
  ImageGalleryVm({
    required this.getImages,
    required this.onLoggedOut,
  }) : super(equals: [
          getImages,
        ]);

  final Images getImages;
  final Future<void> Function() onLoggedOut;
}
