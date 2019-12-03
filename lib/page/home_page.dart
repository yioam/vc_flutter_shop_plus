import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:provider/provider.dart';
import 'package:vc_flutter_shop_plus/model/below_conten_model.dart';
import 'package:vc_flutter_shop_plus/page/home/ad_banner_page.dart';
import 'package:vc_flutter_shop_plus/page/home/leader_phone_page.dart';
import 'package:vc_flutter_shop_plus/page/home/top_navigator_page.dart';
import 'package:vc_flutter_shop_plus/provider/home_provider.dart';

import 'home/floor1_page.dart';
import 'home/floor2_page.dart';
import 'home/floor3_page.dart';
import 'home/hot_goods_page.dart';
import 'home/recommend_page.dart';
import 'home/swiper_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('HomePage 111');
    return Scaffold(
      appBar: AppBar(
        title: Text('百姓生活+'),
      ),
      body: FutureBuilder(
        future: _getContent(context),
        builder: (context, snapshot) {
          print('HomePage 222');
          if (snapshot.hasData) {
            return EasyRefresh(
              header: MaterialHeader(),
              footer: MaterialFooter(),
              child: ListView(
                children: <Widget>[
                  SwiperDiyPage(),
                  TopNavigatorPage(),
                  AdBannerPage(),
                  LeaderPhonePage(),
                  RecommendPage(),
                  Floor1TitlePage(),
                  Floor1ContentPage(),
                  Floor2TitlePage(),
                  Floor2ContentPage(),
                  Floor3TitlePage(),
                  Floor3ContentPage(),
                  HotGoodsPage(),
                ],
              ),
              onRefresh: () async {
                print('重新刷新');
                _getContent(context);
              },
              onLoad: () async {
                print('加载更多数据');
                _getBelowConten(context);
              },
            );
          } else {
            return Center(
              child: Text('加载中...'),
            );
          }
        },
      ),
    );
  }

  Future _getContent(BuildContext context) async {
    print('homePage _getContent');
    await Provider.of<HomeProvider>(context, listen: false).getContent();
    print('homePage end');
    return '完成加载';
  }

  Future _getBelowConten(BuildContext context) async {
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    int page = homeProvider.page;
    print('page:$page');
    var formData = {'page': page};
    await homeProvider.getHotGoodsList(formData: formData);
    homeProvider.addPage();
    return '完成加载';
  }
}
