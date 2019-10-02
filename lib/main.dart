import 'package:flutter/material.dart';
import 'package:band_names/pages/home.dart';
import 'package:band_names/pages/add_name.dart';

void main() => runApp(MaterialApp(
  routes: {
    '/add-new': (context) => AddName(),
  },
  home: MyApp(),
  debugShowCheckedModeBanner: false,
));
ؤ
