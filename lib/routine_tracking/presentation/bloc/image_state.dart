part of 'image_bloc.dart';

@immutable
sealed class ImageState {}

final class ImageInitial extends ImageState {}

final class ImageLoading extends ImageState {}

final class ImageLoaded extends ImageState {
  final Image image;

  ImageLoaded({required this.image});
}
