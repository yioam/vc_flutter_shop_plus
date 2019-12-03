import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vc_flutter_shop_plus/model/content_model.dart';
import 'package:vc_flutter_shop_plus/provider/home_provider.dart';

class TopNavigatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('TopNavigatorPage 000');
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    List<Category> list = homeProvider.content.category;
    if (list.length > 10) {
      list.removeRange(10, list.length);
    }
    return Container(
      height: ScreenUtil().setHeight(250),
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: list.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }

  Widget _gridViewItemUI(BuildContext context, Category item) {
    return InkWell(
      onTap: () {
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item.image,
            width: ScreenUtil().setWidth(95),
          ),
          Text(item.mallCategoryName),
        ],
      ),
    );
  }
}
