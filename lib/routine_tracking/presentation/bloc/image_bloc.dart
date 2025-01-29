import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';

import '../../../app_framework_backbone/views/popup/image_selector/image_repository.dart';

part 'image_event.dart';

part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImageRepository imageRepository;

  ImageBloc({required this.imageRepository}) : super(ImageInitial()) {
    on<ImageEventLoadImage>(_loadImage);
  }

  Future<void> _loadImage(
    ImageEventLoadImage event,
    Emitter<ImageState> emit,
  ) async {
    emit(ImageLoading());
    print('Redraw ${event.id}');
    emit(ImageLoaded(image: await imageRepository.imageBy(event.id)));
  }
}
