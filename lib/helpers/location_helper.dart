const GOOGLE_API_KEY = 'AIzaSyC1zYxooT-oaNoGwqoIZI9AcZMHD4cDAqE';

class LocationHelper {
  static String generateLocationPreviewImage({double lat, double long}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$long&key=$GOOGLE_API_KEY';
  }
}
