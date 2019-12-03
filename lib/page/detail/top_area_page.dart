import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vc_flutter_shop_plus/model/detail_model.dart';
import 'package:vc_flutter_shop_plus/provider/detail_provider.dart';

class TopAreaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DetailProvider detailProvider = Provider.of<DetailProvider>(context);
    GoodInfo goodInfo = detailProvider.detail.goodInfo;
    if (goodInfo != null) {
      return Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            _goodsImage(goodInfo.image1),
            _goodsName(goodInfo.goodsName),
            _goodNum(goodInfo.goodsSerialNumber),
            _goodPrice(goodInfo.presentPrice, goodInfo.oriPrice),
          ],
        ),
      );
    } else {
      return Center(
        child: Text('加载中...'),
      );
    }
  }

  Widget _goodsImage(String url) {
    return Image.network(url, width: ScreenUtil().setWidth(740));
  }

  Widget _goodsName(String name) {
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15.0),
      child: Text(
        name,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(30.0),
        ),
      ),
    );
  }

  Widget _goodNum(String num) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Text(
        '编号: $num',
        style: TextStyle(color: Colors.black26),
      ),
    );
  }

  Widget _goodPrice(double presentPrice, double oriPrice) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Row(
        children: <Widget>[
          Text(
            '¥$presentPrice',
            style: TextStyle(
              color: Colors.pinkAccent,
              fontSize: ScreenUtil().setSp(40.0),
            ),
          ),
          Text(
            ' 市场价:¥$oriPrice',
            style: TextStyle(
              color: Colors.black26,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }
}
