import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:vc_flutter_shop_plus/page/detail_page.dart';

Handler detailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String goodsId = params['id'].first;
  print('index => detail goodsId is $goodsId');
  return DetailPage(goodsId);
});
