import 'package:intl/intl.dart';

class PostInfo {
  String dateStr;
  String dateRaw;
  String photoURL;
  int itemCount;
  var lat;
  var long;

  PostInfo(
      {this.dateStr,
      this.dateRaw,
      this.photoURL,
      this.itemCount,
      this.lat,
      this.long});

  fromDB(dbInfo) {
    this.dateStr = new DateFormat.yMMMMd('en_US')
        .format(DateTime.parse(dbInfo['date']))
        .toString();
    this.photoURL = dbInfo['photoURL'];
    this.itemCount = dbInfo['itemCount'];
    this.lat = dbInfo['lat'];
    this.long = dbInfo['long'];
  }

  setDate() {
    this.dateRaw = DateTime.now().toString();
  }

  setPhotoURL(URL) {
    this.photoURL = URL;
  }

  setItemCount(count) {
    this.itemCount = count;
  }

  setLat(lat) {
    this.lat = lat;
  }

  setLong(long) {
    this.long = long;
  }
}
