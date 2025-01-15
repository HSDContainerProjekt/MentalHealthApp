part of 'image_bloc.dart';

@immutable
sealed class ImageEvent {}

class ImageEventLoadImage extends ImageEvent {
  final int id;

  ImageEventLoadImage({required this.id});
}
