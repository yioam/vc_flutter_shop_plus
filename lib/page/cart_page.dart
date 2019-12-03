import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vc_flutter_shop_plus/model/cart_info_model.dart';
import 'package:vc_flutter_shop_plus/page/cart/item_page.dart';
import 'package:vc_flutter_shop_plus/provider/cart_provider.dart';

import 'cart/bottom_page.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('CartPage 000');
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context, snapshot) {
          print('CartPage 111');
          List<CartInfoModel> cartList = Provider.of<CartProvider>(context).cartList;
          print('cartList:${cartList.length}');
          if (snapshot.hasData && cartList != null) {
            return Stack(
              children: <Widget>[
                ListView.builder(
                    itemCount: cartList.length,
                    itemBuilder: (context, index) {
                      return ItemPage(cartList[index]);
                    }),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  child: BottomPage(),
                ),
              ],
            );
          } else {
            return Center(
              child: Text('加载中...'),
            );
          }
        },
      ),
    );
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provider.of<CartProvider>(context, listen: false).getCartInfo();
    return '加载完成';
  }
}
