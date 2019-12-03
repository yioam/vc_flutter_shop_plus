import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:vc_flutter_shop_plus/router/router_handler.dart';

class Routes {
  static String root = '/';
  static String detailPage = '/detail';

  static void configureRouter(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('error => route was not found');
      return null;
    });

    router.define(detailPage, handler: detailHandler);
  }
}
