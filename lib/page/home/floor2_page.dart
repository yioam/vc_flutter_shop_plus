import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vc_flutter_shop_plus/model/content_model.dart';
import 'package:vc_flutter_shop_plus/provider/home_provider.dart';
import 'package:vc_flutter_shop_plus/router/application.dart';

class Floor2TitlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    String pictureAddress = homeProvider.content.floor2Pic.pICTUREADDRESS;
    return Container(
      //height: ScreenUtil().setHeight(200),
      padding: EdgeInsets.all(8.0),
      child: Image.network(pictureAddress),
    );
  }
}

class Floor2ContentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    List<Floor2> list = homeProvider.content.floor2;
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(context, list),
          _otherGoods(context, list),
        ],
      ),
    );
  }

  Widget _firstRow(BuildContext context, List<Floor2> list) {
    return Row(
      children: <Widget>[
        _goodsItem(context, list[0]),
        Column(
          children: <Widget>[
            _goodsItem(context, list[1]),
            _goodsItem(context, list[2]),
          ],
        ),
      ],
    );
  }

  Widget _otherGoods(BuildContext context, List<Floor2> list) {
    return Row(
      children: <Widget>[
        _goodsItem(context, list[3]),
        _goodsItem(context, list[4]),
      ],
    );
  }

  Widget _goodsItem(BuildContext context, Floor2 item) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {
          Application.router.navigateTo(context, "detail?id=${item.goodsId}",
              transition: TransitionType.inFromRight);
        },
        child: Image.network(item.image),
      ),
    );
  }
}
