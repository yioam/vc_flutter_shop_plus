import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vc_flutter_shop_plus/model/category_model.dart';
import 'package:vc_flutter_shop_plus/provider/category_provider.dart';

class RightCategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('RightCategoryPage 000');
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    return Container(
      height: ScreenUtil().setHeight(80),
      width: ScreenUtil().setWidth(570),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
      ),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoryProvider.childCategoryList.length,
          itemBuilder: (context, index) {
            return _rightInkWell(categoryProvider, categoryProvider.childCategoryList[index], index);
          }),
    );
  }

  Widget _rightInkWell(CategoryProvider categoryProvider, BxMallSubDto item, int index) {
    bool isCheck = false;
    isCheck = (index == categoryProvider.childIndex) ? true : false;
    return InkWell(
      onTap: () {
        categoryProvider.changeChildIndex(index, item.mallSubId);
        categoryProvider.getMallGoodsListByCgSubId(categorySubId: item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: isCheck ? Colors.pink : Colors.black),
        ),
      ),
    );
  }
}
