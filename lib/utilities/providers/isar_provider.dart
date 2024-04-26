import 'package:image_gallery/api/isar/model/images.dart';
import 'package:image_gallery/api/isar/model/user.dart';
import 'package:image_gallery/utilities/app_starter.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'isar_provider.g.dart';

@riverpod
Isar isarInstance(IsarInstanceRef ref) =>
    Isar.getInstance() ??
    Isar.openSync(
      [
        UserSchema,
        ImagesSchema,

        /// TODO: add other schemas
      ],
      directory: directory.path,
    );
