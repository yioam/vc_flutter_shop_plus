import 'package:flutter/material.dart';

import 'mine/action_list_page.dart';
import 'mine/order_title_page.dart';
import 'mine/order_type_page.dart';
import 'mine/top_header_page.dart';

class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人中心'),
      ),
      body: ListView(
        children: <Widget>[
          TopHeaderPage(),
          OrderTitlePage(),
          OrderTypePage(),
          OrderListPage(),
        ],
      ),
    );
  }
}
