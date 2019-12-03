import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vc_flutter_shop_plus/provider/home_provider.dart';

class LeaderPhonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    String leaderImage = homeProvider.content.shopInfo.leaderImage;
    String leaderPhone = homeProvider.content.shopInfo.leaderPhone;
    return Container(
      height: ScreenUtil().setHeight(200),
      child: InkWell(
        onTap: () {
          _launchURL(leaderPhone);
        },
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launchURL(leaderPhone) async {
    String url = 'tel:' + leaderPhone;
    //String url = 'https://baidu.com';
    print('url:$url');
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'could not lanch $url';
    }
  }
}
