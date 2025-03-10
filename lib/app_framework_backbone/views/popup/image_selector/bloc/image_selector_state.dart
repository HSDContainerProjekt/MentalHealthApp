part of 'image_selector_bloc.dart';

@immutable
sealed class ImageSelectorState {}

final class ImageSelectorInitial extends ImageSelectorState {}

final class ImageSelectorLoading extends ImageSelectorState {}

final class ImageSelectorLoaded extends ImageSelectorState {
  final List<int> imageIDs;
  final int selectedImageId;

  ImageSelectorLoaded({
    required this.imageIDs,
    required this.selectedImageId,
  });
}
