import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vc_flutter_shop_plus/provider/home_provider.dart';

class AdBannerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        HomeProvider homeProvider = Provider.of<HomeProvider>(context);
        String adPicture = homeProvider.content.advertesPicture.pICTUREADDRESS;
        return Container(
          height: ScreenUtil().setHeight(80),
          child: Image.network(adPicture),
        );
  }
}
