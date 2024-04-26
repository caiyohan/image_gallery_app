import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_gallery/api/isar/model/images.dart';
import 'package:image_gallery/utilities/providers/isar_provider.dart';
import 'package:isar/isar.dart';

final imageStreamProvider = StreamProvider.autoDispose<void>((ref) {
  final isar = ref.watch(isarInstanceProvider);

  return isar.images.where().watchLazy(fireImmediately: true);
});
