import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vc_flutter_shop_plus/model/cart_info_model.dart';
import 'package:vc_flutter_shop_plus/provider/cart_provider.dart';
import 'package:vc_flutter_shop_plus/router/application.dart';

import 'count_page.dart';

class ItemPage extends StatelessWidget {
  final CartInfoModel item;

  ItemPage(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.black12),
        ),
      ),
      child: Row(
        children: <Widget>[
          _checkBt(context, item),
          _image(context, item),
          _goodsName(item),
          _price(context, item),
        ],
      ),
    );
  }

  Widget _checkBt(BuildContext context, CartInfoModel item) {
    return Container(
      child: Checkbox(
        value: item.isCheck,
        activeColor: Colors.pink,
        onChanged: (bool val) {
          item.isCheck = val;
          Provider.of<CartProvider>(context).changeCheckState(item);
        },
      ),
    );
  }

  Widget _image(BuildContext context, CartInfoModel item) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context, "detail?id=${item.goodsId}",
            transition: TransitionType.inFromRight);
      },
      child: Container(
        width: ScreenUtil().setWidth(150),
        padding: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: Colors.black12,
          ),
        ),
        child: Image.network(item.images),
      ),
    );
  }

  Widget _goodsName(CartInfoModel item) {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10.0),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(item.goodsName),
          CountPage(item),
        ],
      ),
    );
  }

  Widget _price(BuildContext context, CartInfoModel item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('¥${item.price}'),
          Container(
            child: InkWell(
              onTap: () {
                Provider.of<CartProvider>(context).deleteOneGoods(item.goodsId);
              },
              child: Icon(
                Icons.delete_forever,
                color: Colors.black26,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
