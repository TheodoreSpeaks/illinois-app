import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'call.dart';

class ArtSplashPage extends StatefulWidget {
  final String art = 'images/la_casa.jpg';
  final String name = 'La casa';
  @override
  _ArtSplashPageState createState() => _ArtSplashPageState();
}

class _ArtSplashPageState extends State<ArtSplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () => onJoin(context),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.contain, image: AssetImage(widget.art))),
            child: Stack(
              children: [
                Positioned(
                  bottom: 30,
                  left: 20,
                  child: Row(
                    children: [
                      CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Interior of La Casa',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24)),
                          Text('by Theodore Li',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w200,
                                  fontStyle: FontStyle.italic))
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

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
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CallPage(
          channelName: widget.name,
          role: ClientRole.Broadcaster,
        ),
      ),
    );
  }
}
