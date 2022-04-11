import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flutter/cupertino.dart';
import 'package:taniku/View/profile_screen.dart';
import 'package:taniku/View/news_screen.dart';
class BotNavBar extends StatelessWidget {
  const BotNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;
    _controller = PersistentTabController(initialIndex: 0);

    List<Widget> _buildScreens() {
      return [
        const NewsScreen(),
        const ProfileScreen(),
        // const HomePage(),
        // const HomePage()
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: ("Home"),
          inactiveIcon: const Icon(Icons.home_outlined),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.indigo,
        ),
        // PersistentBottomNavBarItem(
        //   icon: const Icon(CupertinoIcons.person_2_fill),
        //   title: ("Kontak"),
        //   inactiveIcon: const Icon(CupertinoIcons.person_2),
        //   activeColorPrimary: Colors.white,
        //   inactiveColorPrimary: Colors.blueGrey,
        // ),
        // PersistentBottomNavBarItem(
        //   icon: const Icon(CupertinoIcons.envelope_fill),
        //   title: ("Inbox"),
        //   inactiveIcon:  const Icon(CupertinoIcons.envelope),
        //   activeColorPrimary: Colors.white,
        //   inactiveColorPrimary: Colors.blueGrey,
        // ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          title: ("Profil"),
          inactiveIcon: const Icon(Icons.person_outline),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.indigo,
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.black, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(16.0),
        // colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
}