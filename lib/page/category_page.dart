import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vc_flutter_shop_plus/page/category/left_category_page.dart';
import 'package:vc_flutter_shop_plus/page/category/right_category_page.dart';
import 'package:vc_flutter_shop_plus/provider/category_provider.dart';

import 'category/category_goods_page.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('CategoryPage 111');
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    categoryProvider.getCategoryList();
    categoryProvider.getMallGoodsListByCgId();
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Center(
        child: Row(
          children: <Widget>[
            LeftCategoryPage(),
            Column(
              children: <Widget>[
                RightCategoryPage(),
                CategoryGoodsPage(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
