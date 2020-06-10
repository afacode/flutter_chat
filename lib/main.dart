import 'package:flutter/material.dart';
import 'package:wechat_app/constants.dart';
import 'package:wechat_app/pages/home/home_screen.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'wechat',
  theme: ThemeData.light().copyWith(
    primaryColor: Color(AppColors.AppBarColor)
  ),
  home: HomeScreen(),
));