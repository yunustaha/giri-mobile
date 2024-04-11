import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giri/screens/Home/pages/Customer/AddCustomer/index.dart';
import 'package:giri/screens/Home/pages/Customer/index.dart';
import 'package:giri/screens/Home/pages/Main/index.dart';
import 'package:giri/utils/index.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeScreen extends StatelessWidget with GiriMixin {
  HomeScreen({super.key});

  Size size = PlatformDispatcher.instance.views.first.physicalSize / PlatformDispatcher.instance.views.first.devicePixelRatio;

  final GlobalKey<ScaffoldState> _globalkey = GlobalKey<ScaffoldState>();

  List<Widget> _buildScreens() {
    return [
      const MainPage(),
      const MainPage(),
      Container(),
      CustomerPage(),
      const MainPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context) {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Anasayfa"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.bag_fill),
        title: ("İşler"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          CupertinoIcons.add,
          color: Colors.white,
        ),
        title: ("Müşteri Ekle"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        onPressed: (_) {
          openBottomSheet(context, AddCustomerForm());
        },
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person_2_fill),
        title: ("Müşteriler"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.settings),
        title: ("Ayarlar"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalkey,
      appBar: _buildAppBar(context),
      drawer: _buildDrawer(context),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(45),
      child: AppBar(
        title: const Text(
          'Giri',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 24),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          iconSize: 30,
          icon: const Icon(CupertinoIcons.list_bullet),
          color: Colors.white,
          tooltip: 'Menu',
          onPressed: () {
            _globalkey.currentState?.openDrawer();
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(context),
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      // screenTransitionAnimation: const ScreenTransitionAnimation(
      //   // Screen transition animation on change of selected tab.
      //   animateTabTransition: true,
      //   curve: Curves.ease,
      //   duration: Duration(milliseconds: 200),
      // ),
      navBarStyle: NavBarStyle.style16,
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: FlutterLogo(),
            accountName: Text("Flutter"),
            accountEmail: Text("https://flutter.dev"),
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
          ),
          ListTile(
            title: Text('Mesajlar'),
            subtitle: Text("Mesajlarınızı okuyun"),
            leading: Icon(Icons.question_answer),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Ayarlar'),
            subtitle: Text("Uygulamayı kişiselleştirin"),
            leading: Icon(Icons.settings),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
