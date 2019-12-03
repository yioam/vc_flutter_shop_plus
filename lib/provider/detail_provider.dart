import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vc_flutter_shop_plus/model/detail_model.dart';
import 'package:vc_flutter_shop_plus/service/method_service.dart';

class DetailProvider with ChangeNotifier {
  Detail _detail;

  Detail get detail => _detail;

  getGoodsDetail(String id) async {
    print('getGoodsDetail start');
    var formData = {'goodId': id};

    await request('getGoodDetailById', formData: formData).then((val) {
      var respData = json.decode(val.toString());
      DetailsRespModel respModel = DetailsRespModel.fromJson(respData);
      if (respModel != null && respModel.data != null) {
        _detail = respModel.data;
        notifyListeners();
      }
    });
    print('getGoodsDetail end');
  }

  bool _isLeft = true;
  bool _isRight = false;

  bool get isLeft => _isLeft;

  bool get isRight => _isRight;

  changeLeftAndRight(String changeState) {
    if (changeState == 'left') {
      _isLeft = true;
      _isRight = false;
    } else {
      _isLeft = false;
      _isRight = true;
    }
    notifyListeners();
  }
}
