import 'package:async_redux/async_redux.dart';
import 'package:image_gallery/api/isar/model/images.dart';
import 'package:image_gallery/api/isar/model/user.dart';
import 'package:image_gallery/features/login/login_screen_connector.dart';
import 'package:image_gallery/state/app_state.dart';
import 'package:image_gallery/utilities/app_starter.dart';
import 'package:image_gallery/utilities/providers/isar_provider.dart';
import 'package:image_gallery/utilities/string_constants.dart';
import 'package:isar/isar.dart';

class LoginScreenVmFactory extends VmFactory<AppState, LoginScreenConnector, LoginScreenVm> {
  Isar get isar => providerContainer.read(isarInstanceProvider);

  LoginScreenVmFactory({required this.users});

  final List<User> users;

  @override
  LoginScreenVm fromStore() => LoginScreenVm(
        onAddUser: onAddUser,
        onLogin: onLogin,
        onCheckDup: onCheckDup,
        users: getUsers(),
      );

  List<User> getUsers() => users;

  Future<void> onAddUser(User user) async {
    if (user.userName != '' && user.password != '') isar.writeTxnSync(() => isar.users.putSync(user));
  }

  Future<bool> onLogin(User user) async {
    final userList = isar.users.where().findAllSync();
    final isAuthenticated = userList.any((e) => e.userName == user.userName && e.password == user.password);

    if (isAuthenticated) addInitialImages();

    return isAuthenticated;
  }

  Future<void> addInitialImages() async {
    final tabA = [
      '$rootImagePath/product_1.jpg',
      '$rootImagePath/product_2.png',
      '$rootImagePath/product_3.jpg',
      '$rootImagePath/product_4.png',
      '$rootImagePath/product_5.png',
    ];
    // tabB is the same as carousel at the start of the app
    final tabB = [
      '$rootImagePath/grocery_1.png',
      '$rootImagePath/grocery_2.jpg',
      '$rootImagePath/grocery_3.jpg',
      '$rootImagePath/grocery_4.jpg',
      '$rootImagePath/grocery_5.jpg',
    ];
    final images = Images(
      carousel: tabB,
      tabA: tabA,
      tabB: tabB,
    );

    isar.writeTxnSync(() {
      // clear db
      isar.images.where().deleteAllSync();
      // add initial values
      isar.images.putSync(images);
    });
  }

  Future<bool> onCheckDup(String name) async {
    final userList = isar.users.where().findAllSync();

    final hasDuplicate = userList.any((e) => e.userName == name);

    final isUserListNotEmpty = userList.isNotEmpty;

    return hasDuplicate && isUserListNotEmpty;
  }
}

class LoginScreenVm extends Vm {
  LoginScreenVm({
    required this.onAddUser,
    required this.onLogin,
    required this.users,
    required this.onCheckDup,
  }) : super(equals: [users]);

  final Future<void> Function(User user) onAddUser;
  final Future<bool> Function(User user) onLogin;
  final Future<bool> Function(String name) onCheckDup;
  final List<User> users;
}
