import 'package:flutter/material.dart';
import 'package:illinois/service/Styles.dart';

class MessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Messages',
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
                  children: [
                    ChatBubble(text: 'Hi guys!', user: 'Angie Smith'),
                    ChatBubble(
                        text: 'Our first meeting will be this Tuesday at 7'),
                    ChatBubble(text: 'See you there!'),
                  ],
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
