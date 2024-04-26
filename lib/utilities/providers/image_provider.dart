import 'package:image_gallery/api/isar/model/images.dart';
import 'package:image_gallery/utilities/providers/image_stream_provider.dart';
import 'package:image_gallery/utilities/providers/isar_provider.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_provider.g.dart';

@riverpod
List<Images> images(ImagesRef ref) {
  final isar = ref.watch(isarInstanceProvider);
  final imagesStream = ref.watch(imageStreamProvider);

  return imagesStream.maybeWhen(
    data: (_) => isar.images.where().findAllSync(),
    orElse: List.empty,
  );
}
