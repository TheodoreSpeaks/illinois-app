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
  final String title;
  final List<dynamic> json;

  CommunityInfoPage({this.title, this.json});

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
          channelName: title,
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
            title,
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
        ));
  }
}
