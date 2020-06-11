import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_app/constants.dart';
import 'package:wechat_app/pages/home/home_screen.dart';
import 'package:wechat_app/provider/about_provider.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'wechat',
  theme: ThemeData.light().copyWith(
    primaryColor: Color(AppColors.AppBarColor)
  ),
  home: MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AboutProvider())
    ],
    child: HomeScreen(),
  ),
  // home: HomeScreen(),
));