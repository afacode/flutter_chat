import 'package:flutter/material.dart';
import 'package:wechat_app/config/theme.dart';
import 'package:wechat_app/constants.dart';
import 'package:wechat_app/pages/chat/chat_screen.dart';
 
class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<Widget> _topBarActions;
  List<Widget> _functionActions;
  List<Widget> _pages;
  PageController _pageController;

  final List<BottomNavigationBarItem> botTabs = [
    BottomNavigationBarItem(
      icon: Icon(IconData(0xe608, fontFamily: Constants.IconFontFamily),), 
      activeIcon: Icon(IconData(0xe603, fontFamily: Constants.IconFontFamily),), 
      backgroundColor: Colors.blue, 
      title: Text('微信')),
    BottomNavigationBarItem(
      icon: Icon(IconData(0xe601, fontFamily: Constants.IconFontFamily)), 
      activeIcon: Icon(IconData(0xe656, fontFamily: Constants.IconFontFamily)), 
      title: Text('通讯录')
    ),
    BottomNavigationBarItem(
      icon: Icon(IconData(0xe600, fontFamily: Constants.IconFontFamily),), 
      activeIcon: Icon(IconData(0xe671, fontFamily: Constants.IconFontFamily)), 
      title: Text('发现')
    ),
    BottomNavigationBarItem(
      icon: Icon(IconData(0xe6c0, fontFamily: Constants.IconFontFamily),), 
      activeIcon: Icon(IconData(0xe626, fontFamily: Constants.IconFontFamily),), 
      title: Text('我')
    ),
  ];

  _buildPopupMunuItem(int icon, String title) {
    return Row(
      children: <Widget>[
      Icon(
        IconData(
          icon,
          fontFamily: Constants.IconFontFamily,
        ),
        size: 22.0,
        color: const Color(AppColors.AppBarPopupMenuColor)),
        Container(width: 12.0,),
        Text(title, style: TextStyle(color: Color(AppColors.AppBarPopupMenuColor)),)
    ],);
  }
  
  @override
  void initState() { 
    super.initState();
    _topBarActions = [
      IconButton(
        onPressed: () {},
        icon: Icon(
          IconData(
            0xe65e,
            fontFamily: Constants.IconFontFamily,
          ), 
          size: Constants.ActionIconSize,
          color: const Color(AppColors.ActionIconColor)
        )
      ),
      Container(width: 16.0,),
      Theme(data: ThemeData(cardColor: Color(AppColors.ActionMenuBgColor)), 
        child: PopupMenuButton(
          icon: Icon(IconData(0xe60e,
              fontFamily: Constants.IconFontFamily,), size: Constants.ActionIconSize + 4.0, color: const Color(AppColors.ActionIconColor),),
          itemBuilder: (BuildContext context) {
            return <PopupMenuItem> [
              PopupMenuItem(child: _buildPopupMunuItem(0xe69e, '发起群聊')),
              PopupMenuItem(child: _buildPopupMunuItem(0xe638, '添加朋友')),
              PopupMenuItem(child: _buildPopupMunuItem(0xe61b, '扫一扫')),
              PopupMenuItem(child: _buildPopupMunuItem(0xe62a, '首付款')),
              PopupMenuItem(child: _buildPopupMunuItem(0xe63d, '帮助与反馈')),
            ];
          }
        )
      ),
      Container(width: 16.0,),
    ];
    _functionActions = [
      IconButton(
        icon: Icon(
            IconData(
              0xe60a,
              fontFamily: Constants.IconFontFamily,
            ),
            size: Constants.ActionIconSize + 4.0,
            color: const Color(AppColors.ActionIconColor)),
        onPressed: () {
          print('打开相机拍短视频');
        },
      ),
      Container(width: 16.0),
    ];

    _pageController = PageController(initialPage: _currentIndex);
    _pages = [
      ChatScreen(),
      Container(color: Colors.yellow,),
      Container(color: Colors.blue,),
      Container(color: Colors.green,),
    ];
  }  

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = BottomNavigationBar(
      currentIndex: _currentIndex,
      fixedColor: Color(TabIconActive),
      selectedFontSize: 12.0,
      type: BottomNavigationBarType.fixed,
      items: botTabs,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
          _pageController.animateToPage(_currentIndex, duration: Duration(milliseconds: 200), curve: Curves.bounceIn);
        });
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
        elevation: 0.0,
        actions: _currentIndex == 3 ? _functionActions : _topBarActions,
      ),
      bottomNavigationBar: botNavBar,
      body: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _pages[index];
        },
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(_currentIndex, duration: Duration(milliseconds: 200), curve: Curves.bounceIn);
          });
        },
      ),
    );
  }
}

