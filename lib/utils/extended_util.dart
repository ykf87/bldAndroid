// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

double pw(BuildContext context){
  return MediaQuery.of(context).size.width;
}

double ph(BuildContext context){
  return MediaQuery.of(context).size.height;
}

double bodyHeight(BuildContext context){
  return ph(context) - kToolbarHeight - MediaQueryData.fromWindow(window).padding.top;
}
