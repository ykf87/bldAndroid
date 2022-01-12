import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/base/base_stateful_widget.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/mime/user_center_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

///用户协议
class PrivacyPolicyPage extends BaseStatefulWidget {
  bool isPrivacy = false;

  PrivacyPolicyPage(this.isPrivacy);

  @override
  BaseStatefulState<BaseStatefulWidget> getState() {
    return _PrivacyPolicyPageState();
  }
}

class _PrivacyPolicyPageState extends BaseStatefulState<PrivacyPolicyPage> {

  String content = '';

  @override
  String navigatorTitle() {
    // TODO: implement navigatorTitle
    return widget.isPrivacy?'隐私政策':'用户协议';
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget initDefaultBuild(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Html(data:content,),
        )
      ],
    );
  }

  void getUserInfo() {
    Map<String, dynamic> map = Map();
    map['key'] = widget.isPrivacy ? "pris" : "aggs";
    ApiClient.instance.get(ApiUrl.getBLDBaseUrl() + ApiUrl.agreement,data: map,
        onSuccess: (data) {
      BaseEntity<UserCenterEntity> entity = BaseEntity.fromJson(data!);
      if (entity.isSuccess && entity.data != null) {
        setState(() {
          content = entity.data?.content??'';
        });
      }
    });
  }
}
