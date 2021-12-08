
import 'package:flutter/material.dart';
import 'package:SDZ/res/colors.dart';

class GoodsSortMenu extends StatefulWidget {

  const GoodsSortMenu({
    Key? key,
    this.data,
    this.sortIndex,
    this.height,
    this.onSelected,
  }): super(key: key);

  final List<String>? data;
  final int? sortIndex;
  final double? height;
  final Function(int, String)? onSelected;

  @override
  _GoodsSortMenuState createState() => _GoodsSortMenuState();
}

class _GoodsSortMenuState extends State<GoodsSortMenu> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
     _controller  = AnimationController(
        vsync:this, duration: const Duration(milliseconds: 300));

     _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCubic,
      reverseCurve: Curves.easeOutCubic,
    );
    _animation.addStatusListener(_statusListener);
  }

  void _statusListener(AnimationStatus status) {
    if (status == AnimationStatus.dismissed) {
      /// 菜单动画停止，关闭菜单。
      // NavigatorUtils.goBack(context);

    }
  }

  @override
  void dispose() {
    _animation.removeStatusListener(_statusListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = Colours.bg_ffffff;

    final Widget listView = ListView.builder(
      itemCount: widget.data!.length ,
      itemBuilder: (context, index) => _buildItem(index,backgroundColor),
    );

    return Container(
      height: widget.height! -25,
      color: const Color(0x99000000),
      child:Column(
        children: [
          Container(
            height: 250,
            child: listView,
          )
        ],
      ),
    );

    // return FadeTransition(
    //   opacity: _animation,
    //   child: Container(
    //     color: const Color(0x99000000),
    //     height: widget.height - 12.0,
    //     child: ScaleTransition(
    //       scale: _animation,
    //       alignment: Alignment.topCenter,
    //       child: listView,
    //     ),
    //   ),
    // );
  }

  Widget myItem(int index){
    return Row(
      children: [
        Text(widget.data![index])
      ],
    );
  }

  Widget _buildItem(int index, Color backgroundColor) {
    final TextStyle textStyle = TextStyle(
      fontSize: 14,
      color: Theme.of(context).primaryColor,
    );
    return Material(
      color: backgroundColor,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.data![index],
                style: index == widget.sortIndex ? textStyle : null,
              ),
              Text(
                '($index)',
                style: index == widget.sortIndex ? textStyle : null,
              ),
            ],
          ),
        ),
        onTap: () {
          widget.onSelected!(index, widget.data![index]);
          _controller.reverse();
        },
      ),
    );
  }
}
