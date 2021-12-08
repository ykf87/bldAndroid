import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/res/gaps.dart';
import 'package:SDZ/widget/double_click.dart';

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  final String backImg;
  final String hintText;
  final Function(String) onPressed;
  final Function() onPressedBack;

  const SearchBar({
    Key? key,
    this.hintText = '',
    this.backImg = 'assets/images/ic_back_black.png',
    required this.onPressed,
    required this.onPressedBack,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(48.0);
}

class _SearchBarState extends State<SearchBar> {
  final FocusNode _focus = FocusNode();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Widget back = Semantics(
      label: '返回',
      child: SizedBox(
        width: 48.0,
        height: 48.0,
        child: InkWell(
          onTap: () {
            _focus.unfocus();
            widget.onPressedBack.call();
          },
          borderRadius: BorderRadius.circular(24.0),
          child: Padding(
            key: const Key('search_back'),
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(
              widget.backImg,
              color: Colours.text,
            ),
          ),
        ),
      ),
    );

    final Widget textField = Expanded(
        child: Container(
      height: 32,
      decoration: BoxDecoration(
        color: Colours.bg_gray,
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: TextField(
        key: const Key('search'),
        controller: _controller,
        focusNode: _focus,
        maxLines: 1,
        textInputAction: TextInputAction.search,
        onSubmitted: (String value) {
          _focus.unfocus();
          if (widget.onPressed != null) {
            widget.onPressed.call(value);
          }
        },
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(top: 0, left: -8, right: -16, bottom: 14),
          border: InputBorder.none,
          icon: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
            child: Image(
              image: AssetImage("assets/images/goods_search.png"),
              width: 20,
              height: 20,
            ),
          ),
          hintText: widget.hintText,
          suffixIcon: DoubleClick(
            child: Semantics(
              label: '清空',
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
                child: Image(
                  image: AssetImage("assets/images/goods_delete.png"),
                  width: 20,
                  height: 20,
                ),
              ),
            ),
            onTap: () {
              _controller.text = '';
            },
          ),
        ),
      ),
    ));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Material(
        color: Colours.bg_ffffff,
        child: SafeArea(
          child: Row(
            children: [
              back,
              textField,
              Gaps.hGap16,
              IconButton(
                onPressed: () {
                  if (widget.onPressed != null) {
                    widget.onPressed.call(_controller.text);
                  }
                },
                icon: Icon(Icons.search),
                color: Colors.black,
              ),
              Gaps.hGap16,
            ],
          ),
        ),
      ),
    );
  }
}
