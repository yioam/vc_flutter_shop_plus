import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vc_flutter_shop_plus/page/index_page.dart';
import 'package:vc_flutter_shop_plus/provider/cart_provider.dart';
import 'package:vc_flutter_shop_plus/provider/category_provider.dart';
import 'package:vc_flutter_shop_plus/provider/detail_provider.dart';
import 'package:vc_flutter_shop_plus/provider/home_provider.dart';
import 'package:vc_flutter_shop_plus/provider/index_provider.dart';
import 'package:vc_flutter_shop_plus/router/application.dart';
import 'package:vc_flutter_shop_plus/router/router.dart';

void main() {
  final router = Router();
  Routes.configureRouter(router);
  Application.router = router;

  Provider.debugCheckInvalidValueType = null;
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => IndexProvider()),
      ChangeNotifierProvider(create: (_) => HomeProvider()),
      ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ChangeNotifierProvider(create: (_) => DetailProvider()),
      ChangeNotifierProvider(create: (_) => CartProvider()),
    ],
    child: MyApp(),
  ));
  
  //runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        onGenerateRoute: Application.router.generator,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.pink),
        home: IndexPage(),
      ),
    );
  }
}
