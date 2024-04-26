import 'dart:async';
import 'dart:io';

import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:image_gallery/image_gallery_app.dart';
import 'package:image_gallery/state/app_state.dart';
import 'package:image_gallery/state/persistor.dart';
import 'package:path_provider/path_provider.dart';

final getIt = GetIt.instance;
late final ProviderContainer providerContainer;
late final Directory directory;

Future<void> startApp() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    directory = await getApplicationDocumentsDirectory();

    final persistor = AppPersistor();

    AppState? state;
    try {
      state = await persistor.readState();
    } catch (e) {
      debugPrint(e.toString());
    }

    final store = Store<AppState>(
      initialState: state ?? AppState.init(),
      actionObservers: [if (kDebugMode) Log.printer(formatter: Log.multiLineFormatter)],
    );

    providerContainer = ProviderContainer();

    runApp(
      UncontrolledProviderScope(
        container: providerContainer,
        child: StoreProvider<AppState>(
          store: store,
          child: const ImageGalleryApp(),
        ),
      ),
    );
  }, (error, stack) {
    /// TODO: add fallback when it fails
  });
}
