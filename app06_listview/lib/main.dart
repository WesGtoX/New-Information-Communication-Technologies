import 'package:flutter/material.dart';

import 'ListViewBuilder.dart';
import 'ListViewSepareted.dart';
import 'MenuPrincipal.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ListView',
      initialRoute: '/menu',
      routes: {
        '/menu': (context) => MenuPrincipal(),
        '/list1': (context) => ListViewBuilder(),
        '/list2': (context) => ListViewSepareted(),
      },
    )
  );
}
