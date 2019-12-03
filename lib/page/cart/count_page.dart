import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vc_flutter_shop_plus/model/cart_info_model.dart';
import 'package:vc_flutter_shop_plus/provider/cart_provider.dart';

class CountPage extends StatelessWidget {
  final CartInfoModel item;

  CountPage(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      margin: EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.black12),
      ),
      child: Row(
        children: <Widget>[
          _reduceBtn(context),
          _countArea(context),
          _addBtn(context),
        ],
      ),
    );
  }

  Widget _reduceBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<CartProvider>(context).addOrReduceAction(item, 'reduce');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: item.count > 1 ? Colors.white : Colors.black12,
          border: Border(right: BorderSide(width: 1.0, color: Colors.black12)),
        ),
        child: item.count > 1 ? Text('-') : Text(' '),
      ),
    );
  }

  Widget _addBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<CartProvider>(context).addOrReduceAction(item, 'add');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 1.0, color: Colors.black12),
          ),
        ),
        child: Text('+'),
      ),
    );
  }

  Widget _countArea(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('${item.count}'),
    );
  }
}
