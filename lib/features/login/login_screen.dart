import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_gallery/api/isar/model/user.dart';
import 'package:image_gallery/features/image_gallery/image_gallery_connector.dart';
import 'package:image_gallery/features/login/widget/warning_dialog.dart';
import 'package:image_gallery/features/widgets/text_field_label.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    required this.onAddUser,
    required this.onLogin,
    required this.onCheckDup,
    required this.users,
    super.key,
  });

  final Future<void> Function(User user) onAddUser;
  final Future<bool> Function(User user) onLogin;
  final Future<bool> Function(String name) onCheckDup;
  final List<User> users;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController userNameController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    userNameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void resetTextFields() {
    userNameController.text = '';
    passwordController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFieldLabel(
              title: 'Username',
              textEditingController: userNameController,
            ),
            TextFieldLabel(
              title: 'Password',
              textEditingController: passwordController,
              obscureText: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final userName = userNameController.text;

                    // checking of users with duplicate or same username
                    // TODO: add fallback or snackbar informing user why register failed
                    if (await widget.onCheckDup(userName)) {
                      resetTextFields();
                      return;
                    }

                    await widget
                        .onAddUser(
                          User(
                            userName: userName,
                            password: passwordController.text,
                          ),
                        )
                        .then((_) => resetTextFields());
                  },
                  child: const Text('Register'),
                ),
                const SizedBox(width: 32.0),
                ElevatedButton(
                  onPressed: () => widget
                      .onLogin(
                    User(
                      userName: userNameController.text,
                      password: passwordController.text,
                    ),
                  )
                      .then((value) {
                    value
                        ? context.goNamed(ImageGalleryConnector.routeName)
                        : showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => WarningDialog(
                              title: 'Credential does not match',
                              okButton: TextButton(
                                onPressed: context.pop,
                                child: const Text('OK'),
                              ),
                            ),
                          );
                  }),
                  child: const Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
