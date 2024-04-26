import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_gallery/features/login/login_screen_vm.dart';
import 'package:image_gallery/state/app_state.dart';
import 'package:image_gallery/utilities/providers/user_provider.dart';

import 'login_screen.dart';

class LoginScreenConnector extends ConsumerWidget {
  const LoginScreenConnector({super.key});

  static const route = '/login-screen';
  static const routeName = 'login-screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StoreConnector<AppState, LoginScreenVm>(
      vm: () => LoginScreenVmFactory(users: ref.watch(userProvider)),
      builder: (_, vm) => LoginScreen(
        onAddUser: vm.onAddUser,
        onLogin: vm.onLogin,
        onCheckDup: vm.onCheckDup,
        users: vm.users,
      ),
    );
  }
}
