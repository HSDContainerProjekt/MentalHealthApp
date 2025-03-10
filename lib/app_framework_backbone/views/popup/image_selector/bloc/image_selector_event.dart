part of 'image_selector_bloc.dart';

@immutable
sealed class ImageSelectorEvent {}

class ImageSelectorLoadImageIDList extends ImageSelectorEvent {}

class ImageSelectorAddImage extends ImageSelectorEvent {}

class ImageSelectorSelectId extends ImageSelectorEvent {
  final int id;

  ImageSelectorSelectId({required this.id});
}
