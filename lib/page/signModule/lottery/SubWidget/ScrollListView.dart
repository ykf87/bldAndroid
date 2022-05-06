
import 'package:SDZ/res/colors.dart';
import 'package:flutter/material.dart';
import 'dart:async';

const double _ITEM_HEIGHT = 32.0;

class ListModel {
  const ListModel({required this.userIcon, required this.desc});
  final String userIcon;
  final String desc;
}

class ScrollListView extends StatefulWidget {
  List<String> list;
  @override
  ScrollListViewState createState() => new ScrollListViewState();

  ScrollListView({required this.list});
}

class ScrollListViewState extends State<ScrollListView> with WidgetsBindingObserver{

  // late List<ListModel> _itemLists;
  late PageController  _controller;
  int _currentIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _itemLists = <ListModel>[
    //   ListModel(
    //     userIcon: 'assets/images/userHead@3x.png',
    //     desc: '小叮当抽中了悠悠球1',
    //   ),
    //   ListModel(
    //     userIcon: 'assets/images/userHead@3x.png',
    //     desc: '小叮当抽中了悠悠球2',
    //   ),
    //   ListModel(
    //     userIcon: 'assets/images/userHead@3x.png',
    //     desc: '小叮当抽中了悠悠球3',
    //   ),
    //   ListModel(
    //     userIcon: 'assets/images/userHead@3x.png',
    //     desc: '小叮当抽中了悠悠球4',
    //   ),
    //   ListModel(
    //     userIcon: 'assets/images/userHead@3x.png',
    //     desc: '小叮当抽中了悠悠球5',
    //   ),
    // ];
    _controller = PageController();
    WidgetsBinding.instance?.addObserver(this);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        Timer.periodic(const Duration(seconds:3), (Timer timer){
          if (_controller.page!.round() >= widget.list.length) {
            _controller.jumpToPage(0);
          }
          _controller.nextPage(
              duration: Duration(seconds: 1), curve: Curves.ease);
        });
    });

  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance?.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _controller,
        itemCount: widget.list.length+1,
       itemBuilder: (buildContext, index) {
         return index < widget.list.length?
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
          // Container(
          //   width: 22,
          //   height: 22,
          //   child: CircleAvatar(
          //     backgroundImage: AssetImage(
          //       widget.list[index].userIcon,
          //     ),
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(left: 0.0,),
            child: Text(
              widget.list[index],
              style: TextStyle(
                color: Colours.color_text_7A5F2B,
                fontSize: 15,
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