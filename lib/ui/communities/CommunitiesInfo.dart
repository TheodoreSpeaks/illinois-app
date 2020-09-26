import 'package:flutter/material.dart';
import 'package:illinois/model/Event.dart';
import 'package:illinois/model/Explore.dart';
import 'package:illinois/ui/explore/ExploreCard.dart';
import 'package:illinois/ui/widgets/HeaderBar.dart';
import 'package:illinois/ui/widgets/TabBarWidget.dart';

import 'CommunityExploreCard.dart';

class CommunityInfoPage extends StatelessWidget {
  final json = [
    {
      'id': '1',
      'title': 'MLK Day of Service',
      'timeString': 'January 18, 2021, 1-4 PM',
      'imageURL': 'images/mlk.jpg'
    },
    {
      'id': '1',
      'title': 'Black History Month',
      'timeString': 'February 2021',
      'imageURL': 'images/black_history_month.png'
    },
    {
      'id': '1',
      'title': 'Ebony Excellence Awards',
      'timeString': 'April 13, 2021 1-2 PM',
      'imageURL': 'images/excellence_awards.png'
    },
    {
      'id': '1',
      'title': '50th Anniversary Celebration',
      'timeString': 'April 13, 2021 1-2 PM',
      'imageURL': 'images/bnaacc.jpg'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SimpleHeaderBarWithBack(
          context: context,
          backVisible: true,
          onBackPressed: () => Navigator.pop(context),
          titleWidget: Text(
            "BNAACC",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0),
          ),
        ),
        bottomNavigationBar: TabBarWidget(),
        body: ListView.builder(
          itemCount: json.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CommunityExploreCard(
                showTopBorder: true,
                explore: Event(json: json[index]),
              ),
            );
          },
        )
        // body: Column(
        //   children: [
        //     CommunityExploreCard(
        //         showTopBorder: true,
        //         explore: Event(
        //           json: {
        //             'id': '1',
        //             'title': 'Fun Run',
        //             'placeID': 'Zoom',
        //             'timeString': 'Sunday, September 27 @ 2:00 PM',
        //             'imageURL': 'images/bnaacc.jpg'
        //           },
        //         ))
        //   ],
        // ),
        );
  }
}
