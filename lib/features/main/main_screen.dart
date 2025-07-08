import 'package:atmgo/core/constant/constants.dart';
import 'package:atmgo/core/utils/responsive.dart';
import 'package:atmgo/features/home/home_screen.dart';
import 'package:atmgo/features/main/viewmodel/main_viewmodel.dart';
import 'package:atmgo/features/main/widget/icon.dart';
import 'package:atmgo/features/map/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final List<Widget> _pages = [HomeScreen(), MapScreen(), HomeScreen()];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewModel>(
      builder: (context, bottomNavViewModel, child) {
        return Scaffold(
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: _pages[bottomNavViewModel.currentIndex],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: bottomNavViewModel.currentIndex,
            onTap: (index) {
              bottomNavViewModel.setIndex(index);
            },
            selectedFontSize: Responsive.fontSize(14, context),
            unselectedFontSize: Responsive.fontSize(12, context),
            items: [
              BottomNavigationBarItem(
                icon: CustomIcon(iconPath: iconHome, isActive: false),
                activeIcon: CustomIcon(
                  iconPath: iconHomeActive,
                  isActive: true,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: CustomIcon(iconPath: iconMap, isActive: false),
                activeIcon: CustomIcon(iconPath: iconMapActive, isActive: true),
                label: "Map",
              ),
              BottomNavigationBarItem(
                icon: CustomIcon(iconPath: iconSetting, isActive: false),
                activeIcon: CustomIcon(
                  iconPath: iconSettingActive,
                  isActive: true,
                ),
                label: "Setting",
              ),
            ],
          ),
        );
      },
    );
  }
}
