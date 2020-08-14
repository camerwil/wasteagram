import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/models/post_information.dart';

void main() {
  test('Post created from Map should have appropriate values', () {
    final date = DateTime.now().toString();
    const url = 'www.test.com';
    const itemCount = 1;
    const lat = 2.0;
    const long = 1.0;

    final PostInfo post = PostInfo();
    post.fromDB({
      'date': date,
      'photoURL': url,
      'itemCount': itemCount,
      'lat': lat,
      'long': long
    });

    expect(post.dateStr,
        new DateFormat.yMMMMd('en_US').format(DateTime.parse(date)).toString());
    expect(post.photoURL, url);
    expect(post.itemCount, itemCount);
    expect(post.lat, lat);
    expect(post.long, long);
  });

  test('Individual Post setters should have appropriate values', () {
    const url = 'www.test.com';
    const itemCount = 1;
    const lat = 2.0;
    const long = 1.0;
    PostInfo post = PostInfo();

    post.setPhotoURL(url);
    post.setItemCount(itemCount);
    post.setLat(lat);
    post.setLong(long);

    expect(post.photoURL, url);
    expect(post.itemCount, itemCount);
    expect(post.lat, lat);
    expect(post.long, long);
  });
}
