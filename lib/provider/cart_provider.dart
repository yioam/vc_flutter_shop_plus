import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vc_flutter_shop_plus/model/cart_info_model.dart';

class CartProvider with ChangeNotifier {
  String _cartString = '[]';
  List<CartInfoModel> _cartList = [];
  double _allPrice = 0;
  int _allGoodsCount = 0;
  bool _isAllCheck = true;

  String get cartString => _cartString;

  List<CartInfoModel> get cartList => _cartList;

  double get allPrice => _allPrice;

  int get allGoodsCount => _allGoodsCount;

  bool get isAllCheck => _isAllCheck;

  save(goodsId, goodsName, count, price, images) async {
    print('save 111');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _cartString = prefs.getString('cartInfo');
    var temp = _cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    var isHave = false;
    int iVal = 0;
    _allPrice = 0;
    _allGoodsCount = 0;
    print('save tempList size:${tempList.length}');
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        item['count'] += 1;
        _cartList[iVal].count++;
        isHave = true;
      }
      if (item['isCheck']) {
        _allPrice += _cartList[iVal].price * cartList[iVal].count;
        _allGoodsCount += cartList[iVal].count;
      }
      iVal++;
    });

    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck': true,
      };

      tempList.add(newGoods);
      _cartList.add(CartInfoModel.fromJson(newGoods));

      _allPrice += price * count;
      _allGoodsCount += count;
    }
    _cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    print('添加完成');
    notifyListeners();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    _cartList = [];
    print('清空完成');
    await getCartInfo();
  }

  getCartInfo() async {
    //print('getCartInfo start');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _cartString = prefs.getString('cartInfo');
    _cartList = [];
    _allPrice = 0;
    _allGoodsCount = 0;
    if (_cartString == null) {
      _cartList = [];
    } else {
      List<Map> tempList = (json.decode(_cartString.toString()) as List).cast();
      _isAllCheck = true;
      tempList.forEach((item) {
        if (item['isCheck']) {
          _allPrice += item['count'] * item['price'];
          _allGoodsCount += item['count'];
        } else {
          _isAllCheck = false;
        }
        _cartList.add(CartInfoModel.fromJson(item));
      });
    }
    notifyListeners();
    //print('getCartInfo end');
  }

  deleteOneGoods(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(_cartString.toString()) as List).cast();
    int tempIndex = 0;
    int delIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        delIndex = tempIndex;
      }
      tempIndex++;
    });

    tempList.removeAt(delIndex);
    _cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', _cartString);
    await getCartInfo();
  }

  changeCheckState(CartInfoModel cartItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(_cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });

    tempList[changeIndex] = cartItem.toJson();
    _cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', _cartString);
    await getCartInfo();
  }

  changeAllCheckBtnState(bool isCheck) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(_cartString.toString()) as List).cast();
    List<Map> newList = [];
    for (var item in tempList) {
      var newItem = item;
      newItem['isCheck'] = isCheck;
      newList.add(newItem);
    }
    _cartString = json.encode(newList).toString();
    prefs.setString('cartInfo', _cartString);
    await getCartInfo();
  }

  addOrReduceAction(CartInfoModel cartItem, String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(_cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });

    if (type == 'add') {
      cartItem.count++;
    } else if (cartItem.count > 1) {
      cartItem.count--;
    }

    tempList[changeIndex] = cartItem.toJson();
    _cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', _cartString);
    await getCartInfo();
  }
}
