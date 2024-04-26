import 'package:crimson/crimson.dart';
import 'package:isar/isar.dart';

part 'images.g.dart';

@collection
@json
class Images {
  @jsonIgnore
  Id localID = Isar.autoIncrement;

  @Index(type: IndexType.value)
  int? id;
  late List<String> carousel;
  late List<String> tabA;
  late List<String> tabB;

  Images({
    this.id,
    required this.carousel,
    required this.tabA,
    required this.tabB,
  });

  factory Images.fromJson(Uint8List json) => _$ImagesFromJson(json);
}
