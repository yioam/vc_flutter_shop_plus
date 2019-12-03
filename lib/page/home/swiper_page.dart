import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:vc_flutter_shop_plus/model/content_model.dart';
import 'package:vc_flutter_shop_plus/provider/home_provider.dart';
import 'package:vc_flutter_shop_plus/router/application.dart';

class SwiperDiyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('SwiperDiyPage 000');
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    List<Slides> slidesList = homeProvider.content.slides;
    return Container(
      height: ScreenUtil().setHeight(350),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemCount: slidesList.length,
        pagination: SwiperPagination(),
        autoplay: true,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Application.router.navigateTo(
                  context, "detail?id=${slidesList[index].goodsId}",
                  transition: TransitionType.inFromRight);
            },
            child: Image.network(
              '${slidesList[index].image}',
              fit: BoxFit.fill,
            ),
          );
        },
      ),
    );
  }
}
