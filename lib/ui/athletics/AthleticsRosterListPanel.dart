/*
 * Copyright 2020 Board of Trustees of the University of Illinois.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:illinois/model/sport/SportDetails.dart';
import 'package:illinois/service/Sports.dart';
import 'package:illinois/service/Localization.dart';
import 'package:illinois/service/Analytics.dart';
import 'package:illinois/ui/athletics/AthleticsRosterDetailPanel.dart';
import 'package:illinois/ui/widgets/HeaderBar.dart';
import 'package:illinois/ui/widgets/TabBarWidget.dart';
import 'package:illinois/ui/widgets/RoundedTab.dart';
import 'package:illinois/model/Roster.dart';
import 'package:illinois/utils/Utils.dart';
import 'package:illinois/service/Styles.dart';


class AthleticsRosterListPanel extends StatefulWidget {
  final SportDefinition sport;
  final List<Roster> allRosters;

  AthleticsRosterListPanel(this.sport,this.allRosters);

  @override
  _AthleticsRosterListPanelState createState() => _AthleticsRosterListPanelState(allRosters);
}

class _AthleticsRosterListPanelState extends State<AthleticsRosterListPanel> implements RoundedTabListener, _RosterItemListener{

  final String _tabFilterByName = Localization().getStringEx("panel.athletics_roster_list.button.by_name.title", "By Name") ;
  final String _tabFilterByPosition = Localization().getStringEx("panel.athletics_roster_list.button.by_position.title", "By Position");
  final String _tabFilterByNumber = Localization().getStringEx("panel.athletics_roster_list.button.by_number.title", "By Number");

  int _selectedTabIndex = 0;
  List<RoundedTab> _tabs;
  List<String> _tabStrings;
  List<Roster> allRosters;

  _AthleticsRosterListPanelState(this.allRosters);

  @override
  void initState() {
    if (allRosters == null || allRosters.length == 0) {
      _loadAllRosters();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _tabs = _constructTabWidgets();
    return Scaffold(
      appBar: SimpleHeaderBarWithBack(
        context: context,
        titleWidget: Text(
          Localization().getStringEx('panel.athletics_roster_list.header.title', 'Roster'),
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0),
        ),
      ),
      body: _buildContent(),
      backgroundColor: Styles().colors.background,
      bottomNavigationBar: TabBarWidget(),
    );
  }

  Widget _buildContent() {
    _tabs = _constructTabWidgets();
    return allRosters != null && allRosters.length > 0 ? Column(
        children: <Widget>[
          _RosterListHeading(widget.sport),
          _tabs.isNotEmpty ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(padding: EdgeInsets.all(12),
                child: Row(
                  children: _tabs,
                )
            ),
          ) : Container(),
          Expanded(
            child: ListView(
              children: _constructRostersList(),
            ),
          )
        ],
      ) : Center(child: CircularProgressIndicator(),);
  }

  void _loadAllRosters() {
    Future<List<dynamic>> result = Sports().loadRosters(widget.sport.shortName);
    result.then((list) {
      setState(() {
        allRosters = list;
      });
    });
  }

  List<RoundedTab> _constructTabWidgets() {
    _tabStrings = List<String>();
    List<RoundedTab> tabs = new List<RoundedTab>();

    if(widget.sport != null) {
      _tabStrings.add(_tabFilterByName);
      if (widget.sport.hasSortByPosition || widget.sport.hasSortByNumber) {
        if (widget.sport.hasSortByPosition) {
          _tabStrings.add(_tabFilterByPosition);
        }
        if (widget.sport.hasSortByNumber) {
          _tabStrings.add(_tabFilterByNumber);
        }
      }
    }

    // Tabs will be visible if there are more than 1
    if(_tabStrings.length > 1) {
      for (int i = 0; i < _tabStrings.length; i++) {
        tabs.add(
            new RoundedTab(title: _tabStrings[i], tabIndex: i, listener: this, selected: (i == _selectedTabIndex)));
      }
    }
    return tabs;
  }

  List<Widget> _constructRostersList(){
    if(_tabStrings.isNotEmpty) {
      if (_tabFilterByName == _tabStrings[_selectedTabIndex]) {
        return _constructRostersByNameList();
      }
      else if (_tabFilterByPosition == _tabStrings[_selectedTabIndex]) {
        return _constructRostersByPositionList();
      }
      else if (_tabFilterByNumber == _tabStrings[_selectedTabIndex]) {
        return _constructRostersByNumberList();
      }
      else {
        return List();
      }
    }
    return List();
  }

  List<Widget> _constructRostersByNameList(){
    List<Widget> widgets = List<Widget>();
    if(allRosters != null) {
      List<Roster> clonedRosters = allRosters.map((r) => r).toList();
      clonedRosters.sort((r1, r2) => r1.name.compareTo(r2.name));
      clonedRosters.forEach((roster) =>
      {
        widgets.add(_RosterItem(roster, widget.sport, this, showTopGrey: false,))
      });
    }

    return widgets;
  }

  List<Widget> _constructRostersByPositionList(){
    List<Widget> widgets = List<Widget>();
    Map<String,List<Roster>> categoryMap = Map<String,List<Roster>>();
    for (Roster roster in allRosters){
      if(!categoryMap.containsKey(roster.position)){
        categoryMap[roster.position] = List<Roster>();
      }
      categoryMap[roster.position].add(roster);
    }

    for(String category in categoryMap.keys){
      if(widgets.length > 0) {
        widgets.add(Container(height: 20,));
      }
      widgets.add(_HeadingItem(category));
      List<Roster> rosters = categoryMap[category];
      for(int i = 0; i < rosters.length; i++){
        widgets.add(_RosterItem(rosters[i], widget.sport, this, showTopGrey: i==0,));
      }
    }

    return widgets;
  }

  List<Widget> _constructRostersByNumberList(){
    List<Widget> widgets = List<Widget>();
    if(allRosters != null) {
      List<Roster> clonedRosters = allRosters.map((r) => r).toList();
      clonedRosters.sort((r1, r2) => r1.number >= r2.number ? 1 : -1);
      clonedRosters.forEach((roster) =>
      {
        widgets.add(_RosterItem(roster, widget.sport, this, showTopGrey: false,))
      });
    }

    return widgets;
  }

  void _onRosterItemTap(Roster roster){
    Analytics.instance.logSelect(target: "Roster: "+roster.name);
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => new AthleticsRosterDetailPanel(widget.sport, roster)));
  }

  @override
  void onTabClicked(int tabIndex, RoundedTab caller) {
    Analytics.instance.logSelect(target: caller.title) ;
    setState(() {
      _selectedTabIndex = tabIndex;
      _tabs = _constructTabWidgets();
    });
  }
}

class _RosterListHeading extends StatelessWidget{
  final SportDefinition sport;

  _RosterListHeading(this.sport);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: Container(
          color: Styles().colors.fillColorPrimaryVariant,
          padding: EdgeInsets.only(left: 16, right: 16, top:12, bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(sport.iconPath, width: 16, height: 16,),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(sport.name,
                      style: TextStyle(
                          color: Styles().colors.surfaceAccent,
                          fontFamily: Styles().fontFamilies.medium,
                          fontSize: 16
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0,),
              Text(Localization().getStringEx("panel.athletics_roster_list.label.heading.title", '2019-2020 Roster') ,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: Styles().fontFamilies.extraBold,
                    fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
    );
  }
}


class _HeadingItem extends StatelessWidget {
  final String heading;

  _HeadingItem(this.heading);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Styles().colors.backgroundVariant,
      child: Text(heading,
        style: TextStyle(
            color: Styles().colors.fillColorPrimary,
            fontFamily: Styles().fontFamilies.extraBold,
            fontSize: 20
        ),
      ),
    );
  }
}

abstract class _RosterItemListener{
  _onRosterItemTap(Roster roster);
}

class _RosterItem extends StatelessWidget{
  final _horizontalMargin = 16.0;
  final _photoMargin = 10.0;
  final _photoWidth = 80.0;
  final _blueHeight = 48.0;

  final _RosterItemListener listener;
  final bool showTopGrey;
  final Roster roster;
  final SportDefinition sportConfig;

  _RosterItem(this.roster, this.sportConfig, this.listener, {this.showTopGrey = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>{
        listener._onRosterItemTap(roster)
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only( bottom: 8),
            child: Stack(
              children: <Widget>[
                _buildGrayHeading(),
                Container(
                  color: Styles().colors.fillColorPrimary,
                  height: _blueHeight,
                  margin: EdgeInsets.only(top: _photoMargin*2, left: _horizontalMargin, right: _horizontalMargin,),
                  child: Container(
                    margin: EdgeInsets.only(right:(_photoWidth + (_photoMargin + _horizontalMargin))),
                    child: Padding(
                      padding: EdgeInsets.only(left:8,right:8),
                      child: Align(
                        alignment: Alignment.center,
                        child:  Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Text(roster.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: Styles().fontFamilies.bold,
                                    fontSize: 20
                                ),
                              ),
                            ),
                            Text(roster.numberString,
                              style: TextStyle(
                                  color: Styles().colors.whiteTransparent06,
                                  fontFamily: Styles().fontFamilies.medium,
                                  fontSize: 20
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.zero,
                        topEnd: Radius.zero,
                        bottomStart: Radius.circular(5),
                        bottomEnd: Radius.circular(5),
                      ),
                      boxShadow: [
                        BoxShadow(color: Styles().colors.fillColorPrimary,blurRadius: 4,),
                      ]

                  ),
                  constraints: BoxConstraints(
                      minHeight: 85
                  ),
                  margin: EdgeInsets.only(top: _blueHeight + _photoMargin*2,left: _horizontalMargin, right: _horizontalMargin,),
                  child: Padding(
                    padding: EdgeInsets.only(left: 8, top: 8, bottom: 8, right:(_photoWidth + (_photoMargin + _horizontalMargin))),
                    child: Column(
                      children: _buildRosterInfoWidgets(),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.only(right: _horizontalMargin + _photoMargin, top: _photoMargin),
                    decoration: BoxDecoration(border: Border.all(color: Styles().colors.fillColorPrimary,width: 2, style: BorderStyle.solid)),
                    child: (AppString.isStringNotEmpty(roster.rosterPhotoUrl) ?
                      Image.network(roster.rosterPhotoUrl, width: _photoWidth, fit: BoxFit.cover, alignment: Alignment.topCenter,) :
                      Container(height: 96, width: 80, color: Colors.white,)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildRosterInfoWidgets(){
    List<Widget> list = List<Widget>();
    if(sportConfig != null) {
      if (sportConfig.hasPosition) {
        list.add(_RosterInfoLine(Localization().getStringEx("panel.athletics_roster_list.label.position.title", 'Position'), roster.position));
      }
      if (sportConfig.hasWeight || sportConfig.hasHeight) {
        list.add(_buildHeightWeightWidget());
      }
      list.add(_RosterInfoLine(Localization().getStringEx("panel.athletics_roster_list.label.year.title", 'Year'), roster.year));
    }
    return list;
  }

  Widget _buildHeightWeightWidget(){
    if(sportConfig != null) {
      if (sportConfig.hasWeight && sportConfig.hasHeight) {
        return _RosterInfoLine(Localization().getStringEx("panel.athletics_roster_list.label.htwt.title",'Ht./Wt.'), '${roster.height} / ${roster.weight}');
      }
      else if (sportConfig.hasHeight) {
        return _RosterInfoLine(Localization().getStringEx("panel.athletics_roster_list.label.ht.title",'Ht.'), roster.height);
      }
      else if (sportConfig.hasWeight) {
        return _RosterInfoLine(Localization().getStringEx("panel.athletics_roster_list.label.wt.title",'Wt.'), roster.weight);
      }
      else {
        return Container();
      }
    }
    else{return Container();}
  }

  Widget _buildGrayHeading(){
    return showTopGrey ? Container(
        color: Styles().colors.backgroundVariant,
        height: _photoMargin*2,
        margin: EdgeInsets.only(top: 0, left: 0, right: 0),
    ) : Container();
  }
}

class _RosterInfoLine extends StatelessWidget{
  final String name;
  final String value;

  _RosterInfoLine(this.name, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppString.isStringNotEmpty(value) ?
      Row(
        children: <Widget>[
          Container(
            width: 80,
            child: Text(name,
              style: TextStyle(
                  color: Styles().colors.textBackground,
                  fontFamily: Styles().fontFamilies.medium,
                  fontSize: 14
              ),
            ),
          ),
          Expanded(child:
            Text(value,
                style: TextStyle(
                    color: Styles().colors.textBackground,
                    fontFamily: Styles().fontFamilies.bold,
                    fontSize: 14
                )
            ),
          )
        ],
      ) : Container()
    );
  }

}