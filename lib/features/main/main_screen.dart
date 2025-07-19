import 'package:atmgo/core/common/asset/app_assets.dart';
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
                icon: CustomIcon(iconPath: AppAssets.iconHome, isActive: false),
                activeIcon: CustomIcon(
                  iconPath: AppAssets.iconHomeActive,
                  isActive: true,
                ),
                label: "Trang chủ",
              ),
              BottomNavigationBarItem(
                icon: CustomIcon(iconPath: AppAssets.iconMap, isActive: false),
                activeIcon: CustomIcon(
                  iconPath: AppAssets.iconMapActive,
                  isActive: true,
                ),
                label: "Bản đồ",
              ),
              BottomNavigationBarItem(
                icon: CustomIcon(
                  iconPath: AppAssets.iconSetting,
                  isActive: false,
                ),
                activeIcon: CustomIcon(
                  iconPath: AppAssets.iconSettingActive,
                  isActive: true,
                ),
                label: "Thiết lập",
              ),
            ],
          ),
        );
      },
    );
  }
}
