
import 'package:SDZ/api/api_status.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/jutuike/goods_entity.dart';
import 'package:dio/dio.dart';

import 'api_client.dart';
import 'api_url.dart';

class JtkApi{
  ///聚推客id
  static String pub_id = "8155";
  ///来源 jd-京东,vip-唯品会,pdd-拼多多,kaola-考拉,taobao-淘宝 默认vip
  static String source = "taobao-淘宝";

  ///商品列表 source：来源
  static List<GoodsEntity>? getGoodsList(String source, Function callBack,{int page =1,int pageSize = 20})  {
    // http://api.act.jutuike.com/union/query_goods
    List<GoodsEntity>? list;
    Map<String, dynamic> map = Map();
    map['pub_id'] = pub_id;
    map['source'] = source;
    // map['cat'] = pub_id;//分类
    // map['sub_share_rate'] = sub_share_rate;//分成比例 1代表100%，0.9代表90%，默认1
    map['page'] = page;
    map['pageSize'] = pageSize;

    ApiClient.instance.get(ApiUrl.query_goods,data: map,isJTK: true, onSuccess: (data) {
      BaseEntity<List<GoodsEntity>> entity = BaseEntity.fromJson(data!);
      if (entity.code == ApiStatus.JTKSUCCESS && entity.data != null) {
        callBack.call(entity.data);
      }
    });
  }


  // 组装数据，开始上传
  static void jtkHttp(Map<String, dynamic> map,String api) async {
    String path = '';

    var options = BaseOptions(
      method: "post",
      receiveTimeout: 3000,
      followRedirects: true,
    );
    options.responseType = ResponseType.plain;
    Dio _dio = Dio(options);
    try {
      Response response = await _dio.post(ApiUrl.getBaseUrl()+api, data: map);
      if (response.statusCode == 200) {

      } else {
      }
    } on DioError catch (e) {

    }
  }
}