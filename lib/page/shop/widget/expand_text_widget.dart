import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:SDZ/res/colors.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText(
      this.text, {
        Key? key,
        required this.expandText,
        required this.collapseText,
        this.expanded = false,
        this.linkColor,
        this.style,
        this.textDirection,
        this.textAlign,
        this.textScaleFactor,
        this.maxLines = 2,
        this.semanticsLabel,
        this.onExpandedChanged,
        this.textHeight,
      })  : assert(text != null),
        assert(expandText != null),
        assert(collapseText != null),
        assert(expanded != null),
        assert(maxLines != null && maxLines > 0),
        super(key: key);

  final String text;
  final String expandText;
  final String collapseText;
  final bool expanded;
  final Color? linkColor;
  final TextStyle? style;
  final TextDirection? textDirection;
  final TextAlign? textAlign;
  final double? textScaleFactor;
  final int maxLines;
  final String? semanticsLabel;
  final ValueChanged<bool>? onExpandedChanged;
  final ValueChanged<double>? textHeight;

  @override
  ExpandableTextState createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText> {
  bool _expanded = false;
  late TapGestureRecognizer _tapGestureRecognizer;
  GlobalKey personalDesTextKey = GlobalKey();//个人简介
  @override
  void initState() {
    super.initState();

    _expanded = widget.expanded;
    _tapGestureRecognizer = TapGestureRecognizer()..onTap = _toggleExpanded;
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() => _expanded = !_expanded);

      widget.textHeight!.call(personalDesTextKey.currentContext!.size!.height);
    Future.delayed(Duration(milliseconds: 100), () {
    });
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle effectiveTextStyle = widget.style!;
    if (widget.style == null || widget.style!.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(widget.style);
    }

    final textAlign =
        widget.textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start;

    final textDirection = widget.textDirection ?? Directionality.of(context);

    final textScaleFactor =
        widget.textScaleFactor ?? MediaQuery.textScaleFactorOf(context);

    final locale = Localizations.localeOf(context);

    final linkText =
    _expanded ? ' ${widget.collapseText}' : '${widget.expandText}';

    final linkColor = widget.linkColor ?? Theme.of(context).accentColor;

    final link = TextSpan(
      text: _expanded ? '' : '\u2026 ',
      style: effectiveTextStyle,
      children: [
        TextSpan(
          text: linkText,
          style: effectiveTextStyle.copyWith(
            color: linkColor,
          ),
          recognizer: _tapGestureRecognizer,
        ),
        // WidgetSpan(
        //   child: Image.asset('assets/images/ic_arrow_right.png'),
        // ),
      ],
    );
    final linkImg = TextSpan(
      children: [
        WidgetSpan(
          child: Image.asset('assets/images/ic_arrow_right.png',width: 15,height: 15,),
        ),
      ],
    );

    final text = TextSpan(
      text: widget.text,
      style: effectiveTextStyle,
    );

    Widget result = LayoutBuilder(
      key: personalDesTextKey,
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;

        TextPainter textPainter = TextPainter(
          text: link,
          textAlign: textAlign,
          textDirection: textDirection,
          textScaleFactor: textScaleFactor,
          maxLines: widget.maxLines,
          locale: locale,
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;
        final linkWidth = textPainter.width;
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;
        // print(
        //     'linkSize-width:${linkSize.width} linkSize-height:${linkSize.height} textSize-width:${textSize.width} textSize-height:${textSize.height} linkWidth${linkWidth}');
        final position = textPainter.getPositionForOffset(Offset(
          textSize.width - linkWidth,
          textSize.height,
        ));
        final endOffset = textPainter.getOffsetBefore(position.offset-widget.expandText.length-2);

        TextSpan textSpan;
        if (textPainter.didExceedMaxLines) {
          textSpan = TextSpan(
            style: effectiveTextStyle,
            text: _expanded ? widget.text : widget.text.substring(0, endOffset),
            children: <TextSpan>[
              link,
            ],
          );
        } else {
          textSpan = text;
        }
        final finalLink = TextSpan(
          children: [
            textSpan,linkImg
          ],
        );

        return RichText(
          text: finalLink,
          softWrap: true,
          textDirection: textDirection,
          textAlign: textAlign,
          textScaleFactor: textScaleFactor,
          overflow: TextOverflow.clip,
        );
      },
    );

    if (widget.semanticsLabel != null) {
      result = Semantics(
        textDirection: widget.textDirection,
        label: widget.semanticsLabel,
        child: ExcludeSemantics(
          child: result,
        ),
      );
    }

    return result;
  }
}