import 'package:mental_health_app/routine_tracking/data/image_dao.dart';
import 'package:mental_health_app/routine_tracking/model/picture.dart';

class ImageRepository {
  final ImageDAO imageDAO;

  ImageRepository({required this.imageDAO});

  Future<Picture> imageBy(int imageID) {
    if (imageID > 0) {
      return imageDAO.imageBy(imageID);
    } else {
      // IDs smaller 0 are app images
      throw UnimplementedError("No app images available");
    }
  }

  Future<int> upsert(Picture newPicture) {
    return imageDAO.upsert(newPicture);
  }
}
