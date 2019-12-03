import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vc_flutter_shop_plus/provider/detail_provider.dart';

class WebPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DetailProvider detailProvider = Provider.of<DetailProvider>(context);
    String goodsDetail = detailProvider.detail.goodInfo.goodsDetail;
    bool isLeft = detailProvider.isLeft;
    if (isLeft) {
      return Container(
        child: Html(
          data: goodsDetail,
        ),
      );
    } else {
      return Container(
        width: ScreenUtil().setWidth(750),
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        child: Text('暂时没有数据'),
      );
    }
  }
}
