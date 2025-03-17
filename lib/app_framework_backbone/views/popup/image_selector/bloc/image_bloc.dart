import 'package:flutter/widgets.dart';

import 'package:bloc/bloc.dart';
import 'package:mental_health_app/app_framework_backbone/views/custom_image/image_repository.dart';
import 'package:mental_health_app/app_framework_backbone/views/custom_image/picture.dart';

part 'image_event.dart';

part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final bool isSelected;
  final ImageRepository imageRepository;

  ImageBloc({required this.isSelected, required this.imageRepository})
      : super(ImageInitial()) {
    on<ImageEventLoadImage>(_loadImage);
  }

  Future<void> _loadImage(
    ImageEventLoadImage event,
    Emitter<ImageState> emit,
  ) async {
    emit(ImageLoading());
    emit(ImageLoaded(picture: await imageRepository.imageBy(event.id)));
  }
}
