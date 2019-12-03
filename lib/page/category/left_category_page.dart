import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vc_flutter_shop_plus/model/category_model.dart';
import 'package:vc_flutter_shop_plus/provider/category_provider.dart';

class LeftCategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('LeftCategoryPage 000');
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(right: BorderSide(width: 1.0, color: Colors.black12)),
      ),
      child: ListView.builder(
          itemCount: categoryProvider.categoryList.length,
          itemBuilder: (context, index) {
            return _leftInkWell(categoryProvider, categoryProvider.categoryList[index], index);
          }),
    );
  }

  Widget _leftInkWell(CategoryProvider categoryProvider, CategoryData item, int index) {
    bool isClick = false;
    isClick = (index == categoryProvider.leftIndex) ? true : false;
    return InkWell(
      onTap: () {
        categoryProvider.changeLeftIndex(index);
        var childList = categoryProvider.categoryList[index].bxMallSubDto;
        var categoryId = categoryProvider.categoryList[index].mallCategoryId;
        categoryProvider.getChildCategory(childList, categoryId);
        categoryProvider.getMallGoodsListByCgId(categoryId: categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
          color: isClick ? Color.fromRGBO(236, 236, 236, 1) : Colors.white,
          border: Border(bottom: BorderSide(width: 1.0, color: Colors.black12)),
        ),
        child: Text(
          item.mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }
}
