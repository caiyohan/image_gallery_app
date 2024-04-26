import 'package:image_gallery/api/isar/model/user.dart';
import 'package:image_gallery/utilities/providers/isar_provider.dart';
import 'package:image_gallery/utilities/providers/user_stream_provider.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
List<User> user(UserRef ref) {
  final isar = ref.watch(isarInstanceProvider);
  final userStream = ref.watch(userStreamProvider);

  return userStream.maybeWhen(
    data: (_) => isar.users.where().findAllSync(),
    orElse: List.empty,
  );
}
