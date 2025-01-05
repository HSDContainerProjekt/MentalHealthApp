import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'image_selector_event.dart';

part 'image_selector_state.dart';

class ImageSelectorBloc extends Bloc<ImageSelectorEvent, ImageSelectorState> {
  ImageSelectorBloc() : super(ImageSelectorInitial()) {
    on<ImageSelectorEvent>((event, emit) {});
  }
}
