import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:illinois/service/Styles.dart';
import 'package:illinois/ui/communities/ArtSplashPage.dart';

class MessagePage extends StatefulWidget {
  final List<Widget> children;
  final String title;
  final SplashInfo splashInfo;

  MessagePage({this.children, this.title = 'Messages', this.splashInfo});
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<Widget> children = [
    ChatBubble(text: 'Hi guys!', user: 'Angie Shaw'),
    ChatBubble(text: 'Our first meeting will be this Tuesday at 7'),
    ChatBubble(text: 'See you there!'),
    ChatBubbleUser(text: 'Sounds good!')
  ];

  @override
  void initState() {
    if (widget.children != null) {
      this.children = widget.children;
    }
  }

  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.videocam,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return ArtSplashPage(
                    name: widget.title,
                    splashInfo: widget.splashInfo,
                  );
                }));

                // onJoin(context);
              },
            )
          ],
          title: Text(
            widget.title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0),
          ),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all()),
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (value) => setState(() {
                        children.add(ChatBubbleUser(
                          text: value,
                        ));
                        _controller.clear();
                      }),
                      decoration: InputDecoration(
                          hintText: 'Type message',
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.only(left: 20, top: 12, bottom: 5),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {},
                          )),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final String user;
  const ChatBubble({Key key, this.text, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0, left: 12.0, right: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          user != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(user,
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 10)),
                )
              : Container(),
          SizedBox(height: 6.0),
          Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: Styles().colors.fillColorPrimary, width: 2)),
              child: Text(text,
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 14))),
        ],
      ),
    );
  }
}

class ChatBubbleUser extends StatelessWidget {
  final String text;
  const ChatBubbleUser({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        Padding(
          padding: EdgeInsets.only(top: 8.0, left: 12.0, right: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Styles().colors.accentColor1, width: 2)),
                  child: Text(text,
                      style: TextStyle(
                          color: Styles().colors.accentColor1,
                          fontWeight: FontWeight.normal,
                          fontSize: 14))),
            ],
          ),
        ),
      ],
    );
  }
}
