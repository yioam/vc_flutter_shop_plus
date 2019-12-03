import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:vc_flutter_shop_plus/model/below_conten_model.dart';
import 'package:vc_flutter_shop_plus/model/content_model.dart';
import 'package:vc_flutter_shop_plus/service/method_service.dart';

class HomeProvider with ChangeNotifier {
  Content _content;

  Content get content => _content;

  getContent() async{
    print('getContent start');
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    await request('homePageContent', formData: formData).then((val) {
      var respData = json.decode(val.toString());
      ContentRespModel contentRespModel = ContentRespModel.fromJson(respData);
      if (contentRespModel != null && contentRespModel.data != null) {
        _content = contentRespModel.data;
        notifyListeners();
      }
    });
    print('getContent end');
  }

  getContent4EasyRefresh() async{
    print('getContent4EasyRefresh start');
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    await request('homePageContent', formData: formData).then((val) {
      var respData = json.decode(val.toString());
      ContentRespModel contentRespModel = ContentRespModel.fromJson(respData);
      if (contentRespModel != null && contentRespModel.data != null) {
        _content = contentRespModel.data;
        //notifyListeners();
      }
    });
    reset4EasyRefresh();
    print('getContent4EasyRefresh end');
  }

  int _page = 0;
  List<BelowConten> _hotGoodsList = [];
  List<BelowConten> _allHotGoodsList = [];

  int get page => _page;

  List<BelowConten> get hotGoodsList => _hotGoodsList;

  List<BelowConten> get allHotGoodsList => _allHotGoodsList;

  addPage() {
    _page++;
    print('addPage page:$_page');
    notifyListeners();
  }

  reset4EasyRefresh() {
    _page = 0;
    _hotGoodsList = [];
    _allHotGoodsList = [];
    notifyListeners();
  }

  getHotGoodsList({formData}) async {
    print('getHotGoodsList start');
    await request('homePageBelowConten', formData: formData).then((val) {
      var respData = json.decode(val.toString());
      BelowContenRespModel belowContenRespModel = BelowContenRespModel.fromJson(respData);
      if (belowContenRespModel != null && belowContenRespModel.data != null) {
        _hotGoodsList = belowContenRespModel.data;
        getAllHotGoodsList(_hotGoodsList);
        print('getHotGoodsList end');
      }
    });
  }

  getAllHotGoodsList(List<BelowConten> newList) {
    _allHotGoodsList.addAll(newList);
    print('page: $_page, allHotGoodsList length:${_allHotGoodsList.length}');
    notifyListeners();
  }
}
