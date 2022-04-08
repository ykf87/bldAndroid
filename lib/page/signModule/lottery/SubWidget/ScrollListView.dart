
import 'package:flutter/material.dart';
import 'dart:async';

const double _ITEM_HEIGHT = 32.0;

class ListModel {
  const ListModel({required this.userIcon, required this.desc});
  final String userIcon;
  final String desc;
}

class ScrollListView extends StatefulWidget {

  @override
  ScrollListViewState createState() => new ScrollListViewState();
}

class ScrollListViewState extends State<ScrollListView> {

  late List<ListModel> _itemLists;
  late PageController  _controller;
  int _currentIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _itemLists = <ListModel>[
      ListModel(
        userIcon: 'assets/images/userHead@3x.png',
        desc: '小叮当抽中了悠悠球1',
      ),
      ListModel(
        userIcon: 'assets/images/userHead@3x.png',
        desc: '小叮当抽中了悠悠球2',
      ),
      ListModel(
        userIcon: 'assets/images/userHead@3x.png',
        desc: '小叮当抽中了悠悠球3',
      ),
      ListModel(
        userIcon: 'assets/images/userHead@3x.png',
        desc: '小叮当抽中了悠悠球4',
      ),
      ListModel(
        userIcon: 'assets/images/userHead@3x.png',
        desc: '小叮当抽中了悠悠球5',
      ),
    ];
    _controller = PageController();
    Timer.periodic(const Duration(seconds:3), (Timer timer){
      if (_controller.page!.round() >= _itemLists.length) {
        _controller.jumpToPage(0);
      }
      _controller.nextPage(
          duration: Duration(seconds: 1), curve: Curves.ease);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _controller,
        itemCount: _itemLists.length+1,
       itemBuilder: (buildContext, index) {
         return index < _itemLists.length?
         itemBuild(index):itemBuild(0);
       },
      ),
    );
  }

  Widget itemBuild(int index){
    return Container(
      height: _ITEM_HEIGHT,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 22,
            height: 22,
            child: CircleAvatar(
              backgroundImage: AssetImage(
                _itemLists[index].userIcon,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 6.0,),
            child: Text(
              _itemLists[index].desc,
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      /**
          child: ListTile(
          leading: CircleAvatar(
          backgroundImage: AssetImage(
          item.userIcon,
          ),
          ),
          title: Text(
          item.desc,
          style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 13,
          fontWeight: FontWeight.normal,
          ),
          ),
          ),
       */
    );
  }
}