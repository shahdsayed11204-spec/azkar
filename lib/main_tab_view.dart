
import 'package:azkar/feature/quran/presentation/view/quran_view.dart';
import 'package:azkar/feature/theme/presentation/view/setting_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'core/shared/custom_text/custom_glassbottom_nav.dart';
import 'feature/azkar/presentation/view/azkar_home_view.dart';



class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> with TickerProviderStateMixin {
  late List<Widget> screens;
  int currentScreen = 0;
  late List<AnimationController> iconControllers;

  @override
  void initState() {
    super.initState();
    screens = [
    AzkarHomeView(),
      QuranView(),
      SettingsView(),
    ];

    iconControllers = List.generate(
     3,
          (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    );
    iconControllers[currentScreen].forward();
  }

  @override
  void dispose() {
    for (var c in iconControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _onTabTapped(int index) {
    if (index == currentScreen) return;

    setState(() => currentScreen = index);

    iconControllers[index].forward();
    for (var i = 0; i < iconControllers.length; i++) {
      if (i != index) iconControllers[i].reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        extendBody: true,
        body: IndexedStack(index: currentScreen, children: screens),
        bottomNavigationBar: GlassBottomNavBar(
          currentIndex: currentScreen,
          onTap: _onTabTapped,
          items: [
            BottomNavItemData(
              label: 'الأذكار',
              icon: const Icon(CupertinoIcons.sun_haze),
              filledIcon: const Icon(CupertinoIcons.sun_haze_fill),
            ),
            BottomNavItemData(
              label: 'القراًن',
              icon: const Icon(CupertinoIcons.book),
              filledIcon:
              const Icon(CupertinoIcons.book_solid),
            ),
            BottomNavItemData(
              label: 'الأعدادات',
              icon: const Icon(CupertinoIcons.brightness),
              filledIcon:
              const Icon(CupertinoIcons.brightness_solid),
            ),
          ],
        ),
      ),
    );
  }
}