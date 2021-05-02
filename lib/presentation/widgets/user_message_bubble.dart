import 'package:book_shop/constants/colors.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:flutter/material.dart';

class UserMessageBubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
              color: IColors.boldGreen,
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'سلام این یک متن ساده است',
              style: TextStyle(
                fontFamily: Strings.fontIranSans,
                color: IColors.white90,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}