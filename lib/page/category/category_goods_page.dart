import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vc_flutter_shop_plus/model/mall_goods_model.dart';
import 'package:vc_flutter_shop_plus/provider/category_provider.dart';
import 'package:vc_flutter_shop_plus/router/application.dart';

class CategoryGoodsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('CategoryGoodsPage 000');
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    List<MallGoods> mallGoodsList = categoryProvider.mallGoodsList;
    if (mallGoodsList.length > 0) {
      return Expanded(
        child: Container(
          width: ScreenUtil().setWidth(570),
          child: EasyRefresh(
            header: MaterialHeader(enableHapticFeedback: true),
            footer: MaterialFooter(enableHapticFeedback: true, enableInfiniteLoad: false),
            child: ListView.builder(
                itemCount: mallGoodsList.length,
                itemBuilder: (context, index) {
                  return _listWidget(context, mallGoodsList, index);
                }),
            onRefresh: () async {
              print('重新刷新');
              categoryProvider.getMallGoodsListByCgSubId();
            },
            onLoad: () async {
              print('CategoryGoodsPage 加载更多数据');
              categoryProvider.getMoreMallGoodsList();
            },
          ),
        ),
      );
    } else {
      return Text('暂时没有数据');
    }
  }

  Widget _listWidget(BuildContext context, List<MallGoods> list, int index) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(
            context, "detail?id=${list[index].goodsId}",
            transition: TransitionType.inFromRight);
      },
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.black12),
          ),
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(list, index),
            Column(
              children: <Widget>[
                _goodsName(list, index),
                _goodsPrice(list, index),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _goodsImage(List<MallGoods> list, int index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(list[index].image),
    );
  }

  Widget _goodsName(List<MallGoods> list, int index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        list[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  Widget _goodsPrice(List<MallGoods> list, int index) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: ScreenUtil().setWidth(370),
      child: Row(
        children: <Widget>[
          Text(
            '价格:¥${list[index].presentPrice}',
            style: TextStyle(
              color: Colors.pink,
              fontSize: ScreenUtil().setSp(30),
            ),
          ),
          Text(
            '  ¥${list[index].oriPrice}',
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
