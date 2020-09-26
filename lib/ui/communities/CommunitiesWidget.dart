import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:illinois/service/Styles.dart';
import 'package:illinois/ui/communities/ArtSplashPage.dart';
import 'package:illinois/ui/explore/ExplorePanel.dart';
import 'package:illinois/ui/widgets/HeaderBar.dart';
import 'package:illinois/ui/widgets/SectionTitlePrimary.dart';
import 'package:illinois/ui/widgets/TabBarWidget.dart';

import 'CommunitiesInfo.dart';

class CommunitiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      CommunityCard(
        name: 'BNAACC',
        fullName: 'Bruce D. Nesbitt African American Cultural Center',
        asset: 'images/bnaacc.jpg',
        splashInfo: SplashInfo(
            title: 'Still We Rise',
            artist: 'Arvie Smith',
            asset: 'images/stillwerise.jpg'),
        json: [
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
        ],
      ),
      CommunityCard(
        name: 'La Casa',
        fullName: 'La Casa Cultural Latina',
        asset: 'images/la_casa.jpg',
        splashInfo: SplashInfo(
            artist: 'Juan Sánchez',
            title: 'Escrito en Piedra',
            asset: 'images/escrito.jpg'),
        json: [
          {
            'id': '1',
            'title': "Black and Latina Womxn's Summit",
            'timeString': 'January 18, 2021, 1-4 PM',
            'imageURL': 'images/escrito.jpg'
          },
          {
            'id': '1',
            'title': 'Dia De Las Madres',
            'timeString': 'April 9, 2021',
            'imageURL': 'images/la_casa.jpg'
          },
        ],
      ),
      CommunityCard(
        name: 'AACC',
        fullName: 'Asian American Cultural Center',
        asset: 'images/aacc.jpg',
        splashInfo: SplashInfo(
            artist: 'Yayoi Kuusama',
            asset: 'images/fire_art.jpg',
            title: 'Fire'),
        json: [
          {
            'id': '1',
            'title': 'Lunar New Year Celebration',
            'timeString': 'February 12, 2021',
            'imageURL': 'images/lunar_new_year.jpg'
          },
          {
            'id': '1',
            'title': 'South Asian American Leadership Conference',
            'timeString': 'February 22 2021',
            'imageURL': 'images/aa_leadership.png'
          },
          {
            'title': 'Asia Fest 2021',
            'timeString': 'April 28, 2021 1-4 pm',
            'imageURL': 'images/asiafest.jpg'
          },
          {
            'id': '1',
            'title': 'Asiantation',
            'timeString': 'September 8, 2021',
            'imageURL': 'images/asiantation.jpg'
          },
          {
            'id': '1',
            'title': 'Diwali Celebration',
            'timeString': 'November 4, 2021',
            'imageURL': 'images/diwali.jpg'
          },
        ],
      ),
    ];
    return Scaffold(
      appBar: SimpleHeaderBarWithBack(
        context: context,
        backVisible: true,
        onBackPressed: () => Navigator.pop(context),
        titleWidget: Text(
          "Communities",
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0),
        ),
      ),
      bottomNavigationBar: TabBarWidget(),
      body: SectionTitlePrimary(
        title: 'Explore',
        children: [
          Container(
            height: 590,
            child: Swiper(
                index: 0,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return pages[index];
                }),
          ),
        ],
      ),
    );
  }
}

class CommunityCard extends StatelessWidget {
  final String fullName;
  final String name;
  final String asset;
  final dynamic json;
  final SplashInfo splashInfo;

  CommunityCard(
      {this.fullName, this.name, this.asset, this.json, this.splashInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        width: 300,
        height: 600,
        decoration: BoxDecoration(
            color: Styles().colors.fillColorPrimary,
            image: DecorationImage(
                image: AssetImage(asset), fit: BoxFit.fitHeight)),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 150,
            child: CustomPaint(
              painter: SlantPainter(),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(fullName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 80),
                      child: MaterialButton(
                          color: Colors.white,
                          onPressed: () => Navigator.push(context,
                                  CupertinoPageRoute(builder: (context) {
                                return CommunityInfoPage(
                                  title: name,
                                  json: json,
                                  splashInfo: splashInfo,
                                );
                              })),
                          child: Text('Visit', style: TextStyle())),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class SlantPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Styles().colors.fillColorPrimary;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2.0;

    var path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 40);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
