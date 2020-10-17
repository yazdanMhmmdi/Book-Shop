import 'package:book_shop/constants/assets.dart';
import 'package:book_shop/constants/colors.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/ui/vertical_card.dart';
import 'package:book_shop/widgets/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:worm_indicator/indicator.dart';
import 'package:worm_indicator/shape.dart';

import 'horizontal_card.dart';

class HomeTab extends StatelessWidget {
  PageController _carouselController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 28,
            ),
            Container(
              child: Column(
                children: [
                  CarouselSlider.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 18),
                                child: Container(
                                  height: 147,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 10),
                                            spreadRadius: -2,
                                            blurRadius: 20,
                                            color: IColors.boldGreen
                                                .withOpacity(0.75))
                                      ]),
                                ),
                              ),
                              Container(
                                height: 147,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: IColors.green),
                                    child: Row(
                                      children: [
                                        Image.asset(Assets.sampleBanner),
                                      ],
                                    ),
                              )
                            ],
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: 175,
                          viewportFraction: 0.8,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          autoPlay: true,
                          initialPage: 0,
                          enlargeCenterPage: true)),
                  
                ],
              ),
            ),
            titleText(Strings.homeMostSales),
            SizedBox(height: 16),
            Container(
              height: 160,
              child: ListView.builder(
                padding: EdgeInsets.only(right: 8),
                itemCount: 41,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return HorizontalCard();
                },
              ),
            ),
            SizedBox(height: 16),
            titleText(Strings.homeFresh),
            SizedBox(
              height: 16,
            ),
            VerticalCard(
              image: Assets.sampleImage_1,
            ),
          ],
        ),
      ),
    );
  }

  Widget titleText(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        '$title',
        style: TextStyle(
            color: Colors.black87,
            fontFamily: "IranSans",
            fontSize: 20,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}
