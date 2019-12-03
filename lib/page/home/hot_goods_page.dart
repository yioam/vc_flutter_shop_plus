import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vc_flutter_shop_plus/model/below_conten_model.dart';
import 'package:vc_flutter_shop_plus/provider/home_provider.dart';
import 'package:vc_flutter_shop_plus/router/application.dart';

class HotGoodsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _hotTitle(),
          _wrapList(context),
        ],
      ),
    );
  }

  Widget _hotTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      alignment: Alignment.center,
      color: Colors.transparent,
      padding: EdgeInsets.all(5.0),
      child: Text('火爆专区'),
    );
  }

  Widget _wrapList(BuildContext context) {
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    List<BelowConten> list = homeProvider.allHotGoodsList;
    print('_wrapList allHotGoodsList length:${list.length}');
    if (list.length > 0) {
      List<Widget> listWidget = list.map((item) {
        return InkWell(
          onTap: () {
            Application.router.navigateTo(context, "detail?id=${item.goodsId}",
                transition: TransitionType.inFromRight);
          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                _image(item),
                _name(item),
                _price(item),
              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Container(
        child: Text('暂时没有数据'),
      );
    }
  }

  Widget _image(BelowConten item) {
    return Container(
      child: Image.network(
        item.image,
        width: ScreenUtil().setWidth(370),
      ),
    );
  }

  Widget _name(BelowConten item) {
    return Container(
      child: Text(
        item.name,
        maxLines: 1,
        // 过长用省略号
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.pink,
          fontSize: ScreenUtil().setSp(26),
        ),
      ),
    );
  }

  Widget _price(BelowConten item) {
    return Container(
      padding: EdgeInsets.only(left: 40),
      child: Row(
        children: <Widget>[
          Text('¥${item.mallPrice}'),
          Text(' '),
          Text(
            '¥${item.price}',
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
