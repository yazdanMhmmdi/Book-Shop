import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/presentation/animation/fade_in_animation.dart';
import 'package:book_shop/presentation/ui/vertical_card_support.dart';
import 'package:book_shop/presentation/widgets/my_tool_bar.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 23,
            ),
            FadeInAnimation(0.25, MyToolBar(title: Strings.chatLabel)),
            SizedBox(
              height: 16,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  VerticalCardSupport(
                      id: "1",
                      image: "image",
                      name: "name",
                      writer: "writer",
                      thumbImage:
                          "/book_shop/v1.1/image/what_if_serious_scientific_answers_to_absurd_hypothetical_questions.png",
                      voteCount: 2.1,
                      pagesCount: "pagesCount",
                      coverType: "coverType",
                      language: "language",
                      description: "description",
                      price: "20000")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
