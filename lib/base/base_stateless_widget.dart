import 'package:flutter/material.dart';

abstract class BaseStatelessWidget extends StatelessWidget {

  const BaseStatelessWidget({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return initDefaultBuild(context);
  }

  ///界面构建
  Widget initDefaultBuild(BuildContext context);
}