import '../data/data_model/picture.dart';
import '../data/image_dao.dart';

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
