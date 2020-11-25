import 'package:book_shop/networking/api_provider.dart';
import 'package:book_shop/networking/image_address_provider.dart';
import 'package:book_shop/presentation/widgets/rating_bar.dart';
import 'package:flutter/material.dart';

class HorizontalCard extends StatelessWidget {
  String id;
  String writer;
  String name;
  String thumbPicture;
  double voteCount;
  HorizontalCard({
    @required this.id,
    @required this.name,
    @required this.thumbPicture,
    @required this.writer,
    @required this.voteCount,
  });
  @override
  Widget build(BuildContext context) {
    print("picture : ${ApiProvider.URL_IP + thumbPicture}");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 71,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.black12,
                  onTap: () => Navigator.pushNamed(context, '/details',
                      arguments: <String, String>{
                        'post_id': "${id}"
                      }),
                  child: Image.network(
                      ImageAddressProvider.imageURL + thumbPicture),
                ),
              ),
            ),
            Container(
              width: 71,
              child: Text(
                '${writer}',
                style: TextStyle(
                    color: Colors.black38,
                    fontFamily: "IranSans",
                    fontSize: 14),
              ),
            ),
            Container(
              width: 111,
              child: Text(
                '${name}',
                style: TextStyle(
                    color: Colors.black87,
                    fontFamily: "IranSans",
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
            MyRatingBar(voteCount, 13),
          ],
        ),
      ),
    );
  }
}
