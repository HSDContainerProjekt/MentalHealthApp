part of 'image_bloc.dart';

@immutable
sealed class ImageEvent {}

class ImageSelectImage extends ImageEvent {
  final bool value;

  ImageSelectImage({required this.value});
}

class ImageEventLoadImage extends ImageEvent {
  final int id;

  ImageEventLoadImage({required this.id});
}
