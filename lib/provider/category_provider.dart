import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vc_flutter_shop_plus/model/category_model.dart';
import 'package:vc_flutter_shop_plus/model/mall_goods_model.dart';
import 'package:vc_flutter_shop_plus/service/method_service.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryData> _categoryList = [];

  List<CategoryData> get categoryList => _categoryList;

  getCategoryList() async {
    await request('getCategory').then((val) {
      var respData = json.decode(val.toString());
      CategoryRespModel respModel = CategoryRespModel.fromJson(respData);
      if (respModel != null && respModel.data != null) {
        _categoryList = respModel.data;
        getChildCategory(_categoryList[0].bxMallSubDto, _categoryList[0].mallCategoryId);
        //print('3333');
      }
    });
  }

  int _leftIndex = 0;

  int get leftIndex => _leftIndex;

  changeLeftIndex(int newLeftIndex) {
    _leftIndex = newLeftIndex;
    notifyListeners();
  }

  List<BxMallSubDto> _childCategoryList = [];
  int _childIndex = 0;
  String _categoryId = '4';
  String _subId = '';
  int _page = 0;

  List<BxMallSubDto> get childCategoryList => _childCategoryList;

  int get childIndex => _childIndex;

  String get categoryId => _categoryId;

  String get subId => _subId;

  int get page => _page;

  getChildCategory(List<BxMallSubDto> list, String id) {
    _childIndex = 0;
    _categoryId = id;
    _subId = ''; // 点击大类 把子类清空

    _page = 0;

    BxMallSubDto item = BxMallSubDto();
    item.mallSubId = '';
    item.mallCategoryId = '00';
    item.mallSubName = '全部';
    item.comments = 'null';
    _childCategoryList = [item];
    _childCategoryList.addAll(list);
    notifyListeners();
  }

  changeChildIndex(int index, String id) {
    _childIndex = index;
    print('changeChildIndex _childIndex $_childIndex');
    _subId = id;
    _page = 0;
    notifyListeners();
  }

  List<MallGoods> _mallGoodsList = [];

  List<MallGoods> get mallGoodsList => _mallGoodsList;

  getMallGoodsListByCgId({String categoryId}) async {
    print('getMallGoodsListByCgId start');
    var data = {
      'categoryId': categoryId == null ? '4' : categoryId,
      'categorySubId': '',
      'page': 0,
    };

    print('getMallGoodsListByCgId data ${data.toString()}');

    await request('getMallGoods', formData: data).then((val) {
      var respData = json.decode(val.toString());
      MallGoodsRespModel respModel = MallGoodsRespModel.fromJson(respData);
      if (respModel != null && respModel.data != null) {
        _mallGoodsList = respModel.data;
      } else {
        _mallGoodsList = [];
      }
    });

    notifyListeners();
    print('getMallGoodsListByCgId end');
  }

  getMallGoodsListByCgSubId() async {
    print('getMallGoodsListByCgSubId start');
    _page = 0;
    var data = {
      'categoryId': _categoryId,
      'categorySubId': _subId,
      'page': _page,
    };

    print('getMallGoodsListByCgSubId data ${data.toString()}');

    await request('getMallGoods', formData: data).then((val) {
      var respData = json.decode(val.toString());
      MallGoodsRespModel respModel = MallGoodsRespModel.fromJson(respData);
      if (respModel != null && respModel.data != null) {
        _mallGoodsList = respModel.data;
      } else {
        _mallGoodsList = [];
      }
    });

    notifyListeners();
    print('getMallGoodsListByCgSubId end');
  }

  getMoreMallGoodsList() async {
    print('getMoreMallGoodsList start');
    _page++;
    var data = {
      'categoryId': _categoryId,
      'categorySubId': _subId,
      'page': _page
    };

    await request('getMallGoods', formData: data).then((val) {
      var respData = json.decode(val.toString());
      MallGoodsRespModel respModel = MallGoodsRespModel.fromJson(respData);
      print('getMoreMallGoodsList respModel data:${respModel.data}');
      if (respModel != null && respModel.data != null) {
        _mallGoodsList.addAll(respModel.data);
        notifyListeners();
      }
    });

    print('getMoreMallGoodsList end; page:$_page, size: ${_mallGoodsList.length}');
  }
}
