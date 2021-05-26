import 'package:flutter/material.dart';

import 'searchWidget.dart';
import 'strings.dart';


void main() => runApp(GHFlutterApp());

class GHFlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appTitle,
      home: SearchWidget(),
    );
  }
}