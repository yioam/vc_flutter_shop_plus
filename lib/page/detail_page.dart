import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vc_flutter_shop_plus/provider/detail_provider.dart';

import 'detail/bottom_page.dart';
import 'detail/expain_page.dart';
import 'detail/tabbar_page.dart';
import 'detail/top_area_page.dart';
import 'detail/web_page.dart';

class DetailPage extends StatelessWidget {
  final String goodsId;

  DetailPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    print('DetailPage 000');
    DetailProvider detailProvider = Provider.of<DetailProvider>(context, listen: false);
    //_getGoodsDetail(detailProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            print('返回上一页');
            Navigator.pop(context);
          },
        ),
        title: Text('商品详细页'),
      ),
      body: FutureBuilder(
        future: _getGoodsDetail(detailProvider),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                Container(
                  child: ListView(
                    children: <Widget>[
                      TopAreaPage(),
                      ExplainPage(),
                      TabBarPage(),
                      WebPage(),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  child: BottomPage(),
                )
              ],
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

  Future _getGoodsDetail(DetailProvider detailProvider) async {
    print('_getGoodsDetail');
    await detailProvider.getGoodsDetail(goodsId);
    return '加载完成';
  }
}
