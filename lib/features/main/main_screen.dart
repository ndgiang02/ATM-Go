// lib/features/main/view/main_screen.dart
import 'dart:ui';

import 'package:atmgo/core/common/asset/app_assets.dart';
import 'package:atmgo/core/utils/responsive.dart';
import 'package:atmgo/features/home/home_screen.dart';
import 'package:atmgo/features/main/viewmodel/main_viewmodel.dart';
import 'package:atmgo/features/main/widget/icon.dart';
import 'package:atmgo/features/map/map_screen.dart';
import 'package:atmgo/features/setting/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  // Gắn PageStorageKey để giữ scroll position/state cho từng page
  final List<Widget> _pages = [
    HomeScreen(key: const PageStorageKey('page_home')),
    MapScreen(key: const PageStorageKey('page_map')),
    SettingsScreen(key: const PageStorageKey('page_settings')),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewModel>(
      builder: (context, bottomNavViewModel, child) {
        final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
        final navHeight = 70.0 + bottomPadding;

        return Scaffold(
          extendBody: true,

          body: IndexedStack(
            index: bottomNavViewModel.currentIndex,
            children: _pages,
          ),

          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
              child: Container(
                height: navHeight,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.06),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.18),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),

                child: SafeArea(
                  top: false,
                  child: BottomNavigationBar(
                    currentIndex: bottomNavViewModel.currentIndex,
                    onTap: (index) => bottomNavViewModel.setIndex(index),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    type: BottomNavigationBarType.fixed,
                    selectedFontSize: Responsive.fontSize(14, context),
                    unselectedFontSize: Responsive.fontSize(12, context),
                    selectedItemColor: Theme.of(context).primaryColor,
                    unselectedItemColor: Colors.white70,
                    showUnselectedLabels: true,
                    items: [
                      BottomNavigationBarItem(
                        icon: CustomIcon(
                          iconPath: AppAssets.iconHome,
                          isActive: false,
                        ),
                        activeIcon: CustomIcon(
                          iconPath: AppAssets.iconHomeActive,
                          isActive: true,
                        ),
                        label: "Trang chủ",
                      ),
                      BottomNavigationBarItem(
                        icon: CustomIcon(
                          iconPath: AppAssets.iconMap,
                          isActive: false,
                        ),
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
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
