import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vc_flutter_shop_plus/model/content_model.dart';
import 'package:vc_flutter_shop_plus/provider/home_provider.dart';
import 'package:vc_flutter_shop_plus/router/application.dart';

class RecommendPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('RecommendPage 000');
    return Container(
      height: ScreenUtil().setHeight(330),
      margin: EdgeInsets.only(top: 8.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommendList(context),
        ],
      ),
    );
  }

  Widget _titleWidget() {
    return Container(
      height: ScreenUtil().setHeight(50),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0.0, 2.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.6, color: Colors.black12),
        ),
      ),
      child: Text(
        '商品推荐',
        style: TextStyle(
          color: Colors.pink,
        ),
      ),
    );
  }

  Widget _recommendList(context) {
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    List<Recommend> list = homeProvider.content.recommend;
    return Container(
      height: ScreenUtil().setHeight(280),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return _item(context, list, index);
          }),
    );
  }

  Widget _item(BuildContext context, List<Recommend> list, int index) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(
            context, "detail?id=${list[index].goodsId}",
            transition: TransitionType.inFromRight);
      },
      child: Container(
        height: ScreenUtil().setHeight(280),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 1.0, color: Colors.black12),
          ),
        ),
        child: Column(
          children: <Widget>[
            Image.network(list[index].image),
            Text('¥${list[index].mallPrice}'),
            Text(
              '¥${list[index].price}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
