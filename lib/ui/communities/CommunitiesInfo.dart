import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:illinois/model/Event.dart';
import 'package:illinois/model/Explore.dart';
import 'package:illinois/ui/communities/call.dart';
import 'package:illinois/ui/explore/ExploreCard.dart';
import 'package:illinois/ui/widgets/HeaderBar.dart';
import 'package:illinois/ui/widgets/TabBarWidget.dart';
import 'package:permission_handler/permission_handler.dart';

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

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }

  Future<void> onJoin(BuildContext context) async {
    // update input validation

    // await for camera and mic permissions before pushing video page
    await _handleCameraAndMic();
    // push video page with given channel name
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CallPage(
          channelName: 'communities',
          role: ClientRole.Broadcaster,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "BNAACC",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.message, color: Colors.white),
            ),
            IconButton(
              icon: Icon(
                Icons.videocam,
                color: Colors.white,
              ),
              onPressed: () => onJoin(context),
            )
          ],
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
