import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_gallery/api/isar/model/user.dart';
import 'package:image_gallery/utilities/providers/isar_provider.dart';
import 'package:isar/isar.dart';

final userStreamProvider = StreamProvider.autoDispose<void>((ref) {
  final isar = ref.watch(isarInstanceProvider);

  return isar.users.where().watchLazy(fireImmediately: true);
});
