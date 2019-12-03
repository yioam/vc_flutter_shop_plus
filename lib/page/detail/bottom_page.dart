import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vc_flutter_shop_plus/model/detail_model.dart';
import 'package:vc_flutter_shop_plus/provider/cart_provider.dart';
import 'package:vc_flutter_shop_plus/provider/detail_provider.dart';
import 'package:vc_flutter_shop_plus/provider/index_provider.dart';

class BottomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DetailProvider detailProvider = Provider.of<DetailProvider>(context);
    GoodInfo goodInfo = detailProvider.detail.goodInfo;
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(80),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          _myStack(context),
          _myLeftInkWell(context, goodInfo),
          _myRightInkWell(context),
        ],
      ),
    );
  }

  Widget _myStack(BuildContext context) {
    int allGoodsCount = Provider.of<CartProvider>(context).allGoodsCount;
    return Stack(
      children: <Widget>[
        InkWell(
          onTap: () {
            Provider.of<IndexProvider>(context).changeCurrentIndex(2);
            Navigator.pop(context);
          },
          child: Container(
            width: ScreenUtil().setWidth(150),
            alignment: Alignment.center,
            child: Icon(
              Icons.shopping_cart,
              size: 35,
              color: Colors.red,
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 10,
          child: allGoodsCount != 0
              ? Container(
                  padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    border: Border.all(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    '$allGoodsCount',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(22),
                    ),
                  ),
                )
              : Container(),
        ),
      ],
    );
  }

  Widget _myLeftInkWell(BuildContext context, GoodInfo goodInfo) {
    return InkWell(
      onTap: () async {
        await Provider.of<CartProvider>(context).save(goodInfo.goodsId,
            goodInfo.goodsName, 1, goodInfo.presentPrice, goodInfo.image1);
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(300),
        height: ScreenUtil().setHeight(80),
        color: Colors.green,
        child: Text(
          '加入购物车',
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenUtil().setSp(28),
          ),
        ),
      ),
    );
  }

  Widget _myRightInkWell(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Provider.of<CartProvider>(context).remove();
      },
      child: Container(
        child: Container(
          alignment: Alignment.center,
          width: ScreenUtil().setWidth(300),
          height: ScreenUtil().setHeight(80),
          color: Colors.red,
          child: Text(
            '立即购买',
            style: TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(28),
            ),
          ),
        ),
      ),
    );
  }
}
