import 'package:async_redux/async_redux.dart';
import 'package:image_gallery/api/isar/model/images.dart';
import 'package:image_gallery/features/single_image/single_image_connector.dart';
import 'package:image_gallery/state/actions/actions.dart';
import 'package:image_gallery/state/app_state.dart';
import 'package:image_gallery/utilities/app_starter.dart';
import 'package:image_gallery/utilities/providers/isar_provider.dart';
import 'package:isar/isar.dart';

class SingleImageVmFactory extends VmFactory<AppState, SingleImageConnector, SingleImageVm> {
  Isar get isar => providerContainer.read(isarInstanceProvider);

  @override
  SingleImageVm fromStore() => SingleImageVm(
        isTabA: isTabA,
        isInCarousel: isInCarousel,
        onTransferTab: onTransferTab,
        onCheckCarousel: onCheckCarousel,
      );

  Images? get getImages => isar.images.where().findFirstSync();

  Future<bool> isTabA(String imagePath) async {
    final images = getImages;

    return images?.tabA.any((e) => e == imagePath) ?? false;
  }

  Future<bool> isInCarousel(String imagePath) async {
    final images = getImages;

    return images?.carousel.any((element) => element == imagePath) ?? false;
  }

  Future<void> onTransferTab(String imagePath) async {
    final images = getImages;
    final isInTabA = images?.tabA.any((element) => element == imagePath);
    if (images == null || isInTabA == null) return;

    final tabA = images.tabA.toList();
    final tabB = images.tabB.toList();

    // clear images in db
    isar.writeTxnSync(() => isar.images.where().deleteAllSync());

    if (isInTabA) {
      // remove path from A
      tabA.removeWhere((element) => element == imagePath);
      // add path to B
      tabB.add(imagePath);
    }
    if (!isInTabA) {
      // remove path from B
      tabB.removeWhere((e) => e == imagePath);
      // add path to A
      tabA.add(imagePath);
    }

    // update tab images state
    dispatch(SetTabAImagesAction(images: tabA));

    dispatch(SetTabBImagesAction(images: tabB));

    // add new images to db
    isar.writeTxnSync(() {
      isar.images.putSync(Images(
        carousel: images.carousel,
        tabA: tabA,
        tabB: tabB,
      ));
    });
  }

  Future<void> onCheckCarousel(String imagePath, bool isChecked) async {
    final images = getImages;
    if (images == null) return;
    final carousel = images.carousel.toList();
    isChecked ? carousel.add(imagePath) : carousel.removeWhere((e) => e == imagePath);

    dispatch(SetCarouselImagesAction(images: carousel));

    isar.writeTxnSync(() => isar.images
      ..where().deleteAllSync()
      ..putSync(Images(
        carousel: carousel,
        tabA: images.tabA,
        tabB: images.tabB,
      )));
  }
}

class SingleImageVm extends Vm {
  SingleImageVm({
    required this.isTabA,
    required this.isInCarousel,
    required this.onTransferTab,
    required this.onCheckCarousel,
  }) : super(equals: []);

  final Future<bool> Function(String imagePath) isTabA;
  final Future<bool> Function(String imagePath) isInCarousel;
  final Future<void> Function(String imagePath) onTransferTab;
  final Future<void> Function(String imagePath, bool isChecked) onCheckCarousel;
}
