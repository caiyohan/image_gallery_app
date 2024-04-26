import 'package:crimson/crimson.dart';
import 'package:isar/isar.dart';

part 'user.g.dart';

@collection
@json
class User {
  @jsonIgnore
  Id localID = Isar.autoIncrement;

  @Index(type: IndexType.value)
  int? id;
  late String userName;
  late String password;

  User({
    this.id,
    required this.userName,
    required this.password,
  });

  factory User.fromJson(Uint8List json) => _$UserFromJson(json);
}
