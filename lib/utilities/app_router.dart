import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_gallery/features/image_gallery/image_gallery_connector.dart';
import 'package:image_gallery/features/login/login_screen_connector.dart';
import 'package:image_gallery/features/single_image/single_image_connector.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rootNavigatorKey');

final router = GoRouter(
  observers: [routeObservers],
  initialLocation: LoginScreenConnector.route,
  navigatorKey: rootNavigatorKey,
  // TODO(yohan): add redirection if session expired or logged out
  redirect: (context, rooteState) => null,
  routes: <GoRoute>[
    GoRoute(
      path: ImageGalleryConnector.route,
      name: ImageGalleryConnector.routeName,
      builder: (_, __) => const ImageGalleryConnector(),
      routes: [
        GoRoute(
          path: SingleImageConnector.route,
          name: SingleImageConnector.routeName,
          builder: (_, state) => SingleImageConnector(imagePath: state.extra as String),
        ),
      ],
    ),
    GoRoute(
      path: LoginScreenConnector.route,
      name: LoginScreenConnector.routeName,
      builder: (_, __) => const LoginScreenConnector(),
      routes: const [
        /// TODO: add routes here
      ],
    ),
  ],
);

// Register the RouteObserver as a navigation observer.
final RouteObserver<ModalRoute<void>> routeObservers = RouteObserver<ModalRoute<void>>();
