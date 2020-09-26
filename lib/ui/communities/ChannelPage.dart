import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:illinois/service/Styles.dart';

import 'MessagePage.dart';

class ChannelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Channels',
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ChannelCard(),
              ChannelCard(
                text: 'Social',
                description: 'Hop on in and have a chat!',
              ),
              ChannelCard(
                text: 'RSO meetings',
                description: 'Our weekly RSO meeting',
                time: '3-4 pm Wednesdays',
              ),
              ChannelCard(
                  text: 'Mentoring',
                  description: 'Get help from our great mentors!',
                  time: '5-6 pm Saturdays')
            ],
          ),
        ),
      ),
    );
  }
}

class ChannelCard extends StatelessWidget {
  final String text;
  final String description;
  final String time;
  const ChannelCard(
      {Key key,
      this.text = 'Front Desk',
      this.description = 'For help or general introductions',
      this.time = 'All days'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(builder: (context) {
          return MessagePage();
        }));
      },
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: Styles().colors.fillColorSecondary, width: 3)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(text, style: TextStyle(fontSize: 24)),
                    Row(
                      children: [
                        SizedBox(width: 8),
                        Icon(Icons.person),
                        Text('0',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        SizedBox(
                          width: 16,
                        ),
                        Icon(Icons.av_timer),
                        Text(time,
                            style: TextStyle(fontStyle: FontStyle.italic)),
                      ],
                    ),
                    Text(
                      description,
                      style: TextStyle(),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: IconButton(
                  icon: Icon(
                    Icons.chevron_right,
                    size: 48,
                  ),
                  onPressed: () {},
                ),
              )
            ],
          )),
    );
  }
}
