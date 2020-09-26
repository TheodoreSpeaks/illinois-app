import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:illinois/service/Styles.dart';
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
        color: Colors.red,
      ),
      CommunityCard(color: Colors.yellow),
      CommunityCard(color: Colors.green),
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
  final Color color;

  CommunityCard({this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        width: 300,
        height: 600,
        decoration: BoxDecoration(
            color: color,
            image: DecorationImage(
                image: AssetImage('images/bnaacc.jpg'), fit: BoxFit.fitHeight)),
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
                        child: Text(
                            'Bruce D. Nesbitt African American Cultural Center',
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
                                return CommunityInfoPage();
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
