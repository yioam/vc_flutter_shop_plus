import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vc_flutter_shop_plus/provider/detail_provider.dart';

class TabBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DetailProvider detailProvider = Provider.of<DetailProvider>(context);
    bool isLeft = detailProvider.isLeft;
    bool isRight = detailProvider.isRight;
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Row(
        children: <Widget>[
          _myTabBarLeft(detailProvider, isLeft),
          _myTabBarRight(detailProvider, isRight),
        ],
      ),
    );
  }

  Widget _myTabBarLeft(DetailProvider detailProvider, bool isLeft) {
    return InkWell(
      onTap: () {
        detailProvider.changeLeftAndRight('left');
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: isLeft ? Colors.pink : Colors.black12,
            ),
          ),
        ),
        child: Text(
          '详情',
          style: TextStyle(
            color: isLeft ? Colors.pink : Colors.black12,
          ),
        ),
      ),
    );
  }

  Widget _myTabBarRight(DetailProvider detailProvider, bool isRight) {
    return InkWell(
      onTap: () {
        detailProvider.changeLeftAndRight('right');
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: isRight ? Colors.pink : Colors.black12,
            ),
          ),
        ),
        child: Text(
          '评论',
          style: TextStyle(
            color: isRight ? Colors.pink : Colors.black12,
          ),
        ),
      ),
    );
  }
}
