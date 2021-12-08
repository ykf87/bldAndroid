/// @Author: ljx
/// @CreateDate: 2021/9/3 11:57
/// @Description: 

import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart' show CupertinoTextField;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'double_click.dart';

typedef OnDone = void Function(String text);
typedef PinBoxDecoration = BoxDecoration Function(
    Color borderColor,
    Color pinBoxColor, {
    double borderWidth,
    double radius,
    });

/// class to provide some standard PinBoxDecoration such as standard box or underlined
class ProvidedPinBoxDecoration {
  /// Default BoxDecoration
  static PinBoxDecoration defaultPinBoxDecoration = (
      Color borderColor,
      Color pinBoxColor, {
        double borderWidth = 2.0,
        double radius = 5.0,
      }) {
    return BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
        color: pinBoxColor,
        borderRadius: BorderRadius.circular(radius));
  };

  /// Underlined BoxDecoration
  static PinBoxDecoration underlinedPinBoxDecoration = (
      Color borderColor,
      Color pinBoxColor, {
        double borderWidth = 2.0,
        double radius = 0,
      }) {
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: borderColor,
          width: borderWidth,
        ),
      ),
    );
  };

  static PinBoxDecoration roundedPinBoxDecoration = (
      Color borderColor,
      Color pinBoxColor, {
        double borderWidth = 2.0,
        double radius = 0,
      }) {
    return BoxDecoration(
      border: Border.all(
        color: borderColor,
        width: borderWidth,
      ),
      shape: BoxShape.circle,
      color: pinBoxColor,
    );
  };
}

class ProvidedPinBoxTextAnimation {
  /// A combination of RotationTransition, DefaultTextStyleTransition, ScaleTransition
  static AnimatedSwitcherTransitionBuilder awesomeTransition =
      (Widget child, Animation<double> animation) {
    return RotationTransition(
        child: DefaultTextStyleTransition(
          style: TextStyleTween(
              begin: TextStyle(color: Colors.pink),
              end: TextStyle(color: Colors.blue))
              .animate(animation),
          child: ScaleTransition(
            child: child,
            scale: animation,
          ),
        ),
        turns: animation);
  };

  /// Simple Scaling Transition
  static AnimatedSwitcherTransitionBuilder scalingTransition =
      (child, animation) {
    return ScaleTransition(
      child: child,
      scale: animation,
    );
  };

  /// No transition
  static AnimatedSwitcherTransitionBuilder defaultNoTransition =
      (Widget child, Animation<double> animation) {
    return child;
  };

  /// Rotate Transition
  static AnimatedSwitcherTransitionBuilder rotateTransition =
      (Widget child, Animation<double> animation) {
    return RotationTransition(child: child, turns: animation);
  };
}

class PinCodeTextField extends StatefulWidget {
  final bool isCupertino;
  final int maxLength;
  final TextEditingController? controller;
  final bool hideCharacter;
  final bool highlight;
  final bool highlightAnimation;
  final Color highlightAnimationBeginColor;
  final Color highlightAnimationEndColor;
  final Duration? highlightAnimationDuration;
  final Color highlightColor;
  final Color defaultBorderColor;
  final Color pinBoxColor;
  final Color? highlightPinBoxColor;
  final double pinBoxBorderWidth;
  final double pinBoxRadius;
  final bool hideDefaultKeyboard;
  final PinBoxDecoration? pinBoxDecoration;
  final String maskCharacter;
  final TextStyle? pinTextStyle;
  final double pinBoxHeight;
  final double pinBoxWidth;
  final OnDone? onDone;
  final bool hasError;
  final Color errorBorderColor;
  final Color hasTextBorderColor;
  final Function(String)? onTextChanged;
  final bool autofocus;
  final FocusNode? focusNode;
  final AnimatedSwitcherTransitionBuilder? pinTextAnimatedSwitcherTransition;
  final Duration pinTextAnimatedSwitcherDuration;
  final WrapAlignment wrapAlignment;
  final TextDirection textDirection;
  final TextInputType keyboardType;
  final EdgeInsets pinBoxOuterPadding;
  final bool hasUnderline;
  final bool showCursor;
  final Color? cursorColor;

  const PinCodeTextField({
    Key? key,
    this.isCupertino: false,
    this.maxLength: 4,
    this.controller,
    this.hideCharacter: false,
    this.highlight: false,
    this.highlightAnimation: false,
    this.highlightAnimationBeginColor: Colors.white,
    this.highlightAnimationEndColor: Colors.black,
    this.highlightAnimationDuration,
    this.highlightColor: Colors.black,
    this.pinBoxDecoration,
    this.maskCharacter: "\u25CF",
    this.pinBoxWidth: 70.0,
    this.pinBoxHeight: 70.0,
    this.pinTextStyle,
    this.onDone,
    this.defaultBorderColor: Colors.black,
    this.hasTextBorderColor: Colors.black,
    this.pinTextAnimatedSwitcherTransition,
    this.pinTextAnimatedSwitcherDuration: const Duration(),
    this.hasError: false,
    this.errorBorderColor: Colors.red,
    this.onTextChanged,
    this.autofocus: false,
    this.focusNode,
    this.wrapAlignment: WrapAlignment.start,
    this.textDirection: TextDirection.ltr,
    this.keyboardType: TextInputType.number,
    this.pinBoxOuterPadding = const EdgeInsets.symmetric(horizontal: 4.0),
    this.pinBoxColor = Colors.white,
    this.highlightPinBoxColor,
    this.pinBoxBorderWidth = 2.0,
    this.pinBoxRadius = 0,
    this.hideDefaultKeyboard = false,
    this.hasUnderline = false,
    this.showCursor = false,
    this.cursorColor = Colors.transparent,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PinCodeTextFieldState();
  }
}

class PinCodeTextFieldState extends State<PinCodeTextField>
    with SingleTickerProviderStateMixin {
  AnimationController? _highlightAnimationController;
  Animation? _highlightAnimationColorTween;
  FocusNode? focusNode;
  String text = "";
  int currentIndex = 0;
  List<String> strList = [];
  bool hasFocus = false;
  Timer? timer;
  Color? cursorColor;

  @override
  void didUpdateWidget(PinCodeTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    focusNode = widget.focusNode ?? focusNode;

    if (oldWidget.maxLength < widget.maxLength) {
      setState(() {
        currentIndex = text.length;
      });
      widget.controller?.text = text;
      widget.controller?.selection =
          TextSelection.collapsed(offset: text.length);
    } else if (oldWidget.maxLength > widget.maxLength &&
        widget.maxLength > 0 &&
        text.length > 0 &&
        text.length > widget.maxLength) {
      setState(() {
        text = text.substring(0, widget.maxLength);
        currentIndex = text.length;
      });
      widget.controller?.text = text;
      widget.controller?.selection =
          TextSelection.collapsed(offset: text.length);
    }
  }

  _calculateStrList() async {
    if (strList.length > widget.maxLength) {
      strList.length = widget.maxLength;
    }
    while (strList.length < widget.maxLength) {
      strList.add("");
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.highlightAnimation) {
      var highlightAnimationController = AnimationController(
          vsync: this,
          duration:
          widget.highlightAnimationDuration ?? Duration(milliseconds: 500));
      var animationController = highlightAnimationController;

      highlightAnimationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          highlightAnimationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          highlightAnimationController.forward();
        }
      });
      _highlightAnimationColorTween = ColorTween(
          begin: widget.highlightAnimationBeginColor,
          end: widget.highlightAnimationEndColor)
          .animate(animationController);
      highlightAnimationController.forward();
      _highlightAnimationController = highlightAnimationController;
    }
    focusNode = widget.focusNode ?? FocusNode();

    _initTextController();
    _calculateStrList();
    widget.controller?.addListener(_controllerListener);
    focusNode?.addListener(_focusListener);

    if(widget.showCursor) {
      cursorColor = widget.cursorColor;
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        cursorColor = Colors.transparent;
        if(mounted){
          setState(() {});
        }
        Future.delayed(Duration(milliseconds: 500), () {
          cursorColor = widget.cursorColor;
          if(mounted){
            setState(() {});
          }
        });
      });
    }
  }

  void _controllerListener() {
    if (mounted == true) {
      setState(() {
        _initTextController();
      });
      var onTextChanged = widget.onTextChanged;
      if (onTextChanged != null) {
        onTextChanged(widget.controller?.text ?? "");
      }
    }
  }

  void _focusListener() {
    if (mounted == true) {
      setState(() {
        hasFocus = focusNode?.hasFocus ?? false;
      });
    }
  }

  void _initTextController() {
    if (widget.controller == null) {
      return;
    }
    strList.clear();
    var text = widget.controller?.text ?? "";
    if (text.isNotEmpty) {
      if (text.length > widget.maxLength) {
        throw Exception("TextEditingController length exceeded maxLength!");
      }
    }
    for (var i = 0; i < text.length; i++) {
      strList.add(widget.hideCharacter ? widget.maskCharacter : text[i]);
    }
  }

  double get _width {
    var width = 0.0;
    for (var i = 0; i < widget.maxLength; i++) {
      width += widget.pinBoxWidth;
      if (i == 0) {
        width += widget.pinBoxOuterPadding.left;
      } else if (i + 1 == widget.maxLength) {
        width += widget.pinBoxOuterPadding.right;
      } else {
        width += widget.pinBoxOuterPadding.left;
      }
    }
    return width;
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      // Only dispose the focus node if it's internal.  Don't dispose the passed
      // in focus node as it's owned by the parent not this child widget.
      focusNode?.dispose();
    } else {
      focusNode?.removeListener(_focusListener);
    }
    _highlightAnimationController?.dispose();
    widget.controller?.removeListener(_controllerListener);
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        !widget.isCupertino ? _fakeTextInput() : _fakeTextInputCupertino(),
        _touchPinBoxRow(),
      ],
    );
  }

  Widget _touchPinBoxRow() {
    return widget.hideDefaultKeyboard
        ? _pinBoxRow(context)
        : DoubleClick(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (hasFocus) {
          FocusScope.of(context).requestFocus(FocusNode());
          Future.delayed(Duration(milliseconds: 100), () {
            FocusScope.of(context).requestFocus(focusNode);
          });
        } else {
          FocusScope.of(context).requestFocus(focusNode);
        }
      },
      child: _pinBoxRow(context),
    );
  }

  Widget _fakeTextInput() {
    var transparentBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
        width: 0.0,
      ),
    );
    return Container(
      width: _width,
      height: widget.pinBoxHeight,
      child: TextField(
        autofocus: !kIsWeb ? widget.autofocus : false,
        enableInteractiveSelection: false,
        focusNode: focusNode,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.keyboardType == TextInputType.number
            ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
            : null,
        style: TextStyle(
          height: 0.1, color: Colors.transparent,
//          color: Colors.transparent,
        ),
        decoration: InputDecoration(
          focusedErrorBorder: transparentBorder,
          errorBorder: transparentBorder,
          disabledBorder: transparentBorder,
          enabledBorder: transparentBorder,
          focusedBorder: transparentBorder,
          counterText: null,
          counterStyle: null,
          helperStyle: TextStyle(
            height: 0.0,
            color: Colors.transparent,
          ),
          labelStyle: TextStyle(height: 0.1),
          fillColor: Colors.transparent,
          border: InputBorder.none,
        ),
        cursorColor: Colors.transparent,
        showCursor: false,
        maxLength: widget.maxLength,
        onChanged: _onTextChanged,
      ),
    );
  }

  Widget _fakeTextInputCupertino() {
    return Container(
      width: _width,
      height: widget.pinBoxHeight,
      child: CupertinoTextField(
        autofocus: !kIsWeb ? widget.autofocus : false,
        focusNode: focusNode,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.keyboardType == TextInputType.number
            ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
            : null,
        style: TextStyle(
          color: Colors.transparent,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: null,
        ),
        cursorColor: Colors.transparent,
        showCursor: false,
        maxLength: widget.maxLength,
        onChanged: _onTextChanged,
      ),
    );
  }

  void _onTextChanged(text) {
    var onTextChanged = widget.onTextChanged;
    if (onTextChanged != null) {
      onTextChanged(text);
    }
    setState(() {
      this.text = text;
      if (text.length >= currentIndex) {
        for (int i = currentIndex; i < text.length; i++) {
          strList[i] = widget.hideCharacter ? widget.maskCharacter : text[i];
        }
      }
      currentIndex = text.length;
    });
    if (text.length == widget.maxLength) {
      FocusScope.of(context).requestFocus(FocusNode());
      var onDone = widget.onDone;
      if (onDone != null) {
        onDone(text);
      }
    }
  }

  Widget _pinBoxRow(BuildContext context) {
    _calculateStrList();
    List<Widget> pinCodes = List.generate(widget.maxLength, (int i) {
      return _buildPinCode(i, context);
    });
    return Wrap(
      direction: Axis.horizontal,
      alignment: widget.wrapAlignment,
      verticalDirection: VerticalDirection.down,
      textDirection: widget.textDirection,
      children: pinCodes,
    );
  }

  Widget _buildPinCode(int i, BuildContext context) {
    Color borderColor;
    Color pinBoxColor = widget.pinBoxColor;
    BoxDecoration boxDecoration;
    var highlightPinBoxColor = widget.highlightPinBoxColor;
    var highlightAnimationController = _highlightAnimationController;
    if (widget.hasError) {
      borderColor = widget.errorBorderColor;
    } else if (widget.highlightAnimation &&
        _shouldHighlight(i) &&
        highlightAnimationController != null) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: AnimatedBuilder(
              animation: highlightAnimationController,
              builder: (BuildContext context, Widget? child) {
                var pinBoxDecoration = widget.pinBoxDecoration;
                if (pinBoxDecoration != null) {
                  boxDecoration = pinBoxDecoration(
                    _highlightAnimationColorTween?.value,
                    pinBoxColor,
                    borderWidth: widget.pinBoxBorderWidth,
                    radius: widget.pinBoxRadius,
                  );
                } else {
                  boxDecoration =
                      ProvidedPinBoxDecoration.defaultPinBoxDecoration(
                        _highlightAnimationColorTween?.value,
                        pinBoxColor,
                        borderWidth: widget.pinBoxBorderWidth,
                        radius: widget.pinBoxRadius,
                      );
                }

                return Container(
                  key: ValueKey<String>("container$i"),
                  child: Center(child: _animatedTextBox(strList[i], i)),
                  decoration: boxDecoration,
                  width: widget.pinBoxWidth,
                  height: widget.pinBoxHeight,
                );
              }));
    } else if (widget.highlight && _shouldHighlight(i)) {
      borderColor = widget.highlightColor;
      if (highlightPinBoxColor != null) {
        pinBoxColor = highlightPinBoxColor;
      }
    } else if (i < text.length) {
      borderColor = widget.hasTextBorderColor;
      if (highlightPinBoxColor != null) {
        pinBoxColor = highlightPinBoxColor;
      }
    } else {
      borderColor = widget.defaultBorderColor;
      pinBoxColor = widget.pinBoxColor;
    }
    var pinBoxDecoration = widget.pinBoxDecoration;
    if (pinBoxDecoration != null) {
      boxDecoration = pinBoxDecoration(
        borderColor,
        pinBoxColor,
        borderWidth: widget.pinBoxBorderWidth,
        radius: widget.pinBoxRadius,
      );
    } else {
      boxDecoration = ProvidedPinBoxDecoration.defaultPinBoxDecoration(
        borderColor,
        pinBoxColor,
        borderWidth: widget.pinBoxBorderWidth,
        radius: widget.pinBoxRadius,
      );
    }
    EdgeInsets insets;
    if (i == 0) {
      insets = EdgeInsets.only(
        left: 0,
        top: widget.pinBoxOuterPadding.top,
        right: widget.pinBoxOuterPadding.right,
        bottom: widget.pinBoxOuterPadding.bottom,
      );
    } else if (i == strList.length - 1) {
      insets = EdgeInsets.only(
        left: widget.pinBoxOuterPadding.left,
        top: widget.pinBoxOuterPadding.top,
        right: 0,
        bottom: widget.pinBoxOuterPadding.bottom,
      );
    } else {
      insets = widget.pinBoxOuterPadding;
    }
    return Padding(
      padding: insets,
      child: Container(
        key: ValueKey<String>("container$i"),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
          child: Container(
            child: Center(child: _animatedTextBox(strList[i], i)),
            decoration: widget.hasUnderline
                ? BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: borderColor,
                ),
              ),
            )
                : null,
          ),
        ),
        decoration: boxDecoration,
        width: widget.pinBoxWidth,
        height: widget.pinBoxHeight,
      ),
    );
  }

  bool _shouldHighlight(int i) {
    return hasFocus &&
        (i == text.length ||
            (i == text.length - 1 && text.length == widget.maxLength));
  }

  Widget _animatedTextBox(String text, int i) {
    if (widget.pinTextAnimatedSwitcherTransition != null) {
      return AnimatedSwitcher(
        duration: widget.pinTextAnimatedSwitcherDuration,
        transitionBuilder: widget.pinTextAnimatedSwitcherTransition ??
                (Widget child, Animation<double> animation) {
              return child;
            },
        child: widget.showCursor ? Stack(
          alignment: Alignment.center,
          children: [
            AnimatedOpacity(
              duration: Duration(milliseconds: 0),
              opacity: _shouldHighlight(i) && text.isEmpty ? 1.0 : 0.0,
              child: Center(
                child: VerticalDivider(
                  color: cursorColor,
                  width: 2,
                  indent: 5,
                  endIndent: 5,
                ),
              ) ,
            ),
            Text(
              text,
              key: ValueKey<String>("${strList[i]}$i"),
              style: widget.pinTextStyle,
            ),
          ],
        ) :  Text(
          text,
          key: ValueKey<String>("$text$i"),
          style: widget.pinTextStyle,
        ),
      );
    } else {
      return widget.showCursor ? Stack(
        alignment: Alignment.center,
        children: [
          AnimatedOpacity(
            duration: Duration(milliseconds: 0),
            opacity: _shouldHighlight(i) && text.isEmpty ? 1.0 : 0.0,
            child: Center(
              child: VerticalDivider(
                color: cursorColor,
                width: 2,
                indent: 5,
                endIndent: 5,
              ),
            ) ,
          ),
          Text(
            text,
            key: ValueKey<String>("${strList[i]}$i"),
            style: widget.pinTextStyle,
          ),
        ],
      ) : Text(
        text,
        key: ValueKey<String>("${strList[i]}$i"),
        style: widget.pinTextStyle,
      );
    }
  }
}
