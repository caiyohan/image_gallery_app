import 'package:async_redux/async_redux.dart';
import 'package:image_gallery/state/app_state.dart';

/// Sets the carousel images
class SetCarouselImagesAction extends ReduxAction<AppState> {
  SetCarouselImagesAction({required this.images});

  final List<String> images;

  @override
  AppState reduce() => state.copyWith(carousel: images);
}

/// Sets the Tab A images
class SetTabAImagesAction extends ReduxAction<AppState> {
  SetTabAImagesAction({required this.images});

  final List<String> images;

  @override
  AppState reduce() => state.copyWith(tabA: images);
}

/// Sets the Tab B images
class SetTabBImagesAction extends ReduxAction<AppState> {
  SetTabBImagesAction({required this.images});

  final List<String> images;

  @override
  AppState reduce() => state.copyWith(tabB: images);
}
