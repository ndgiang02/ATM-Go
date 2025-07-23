import 'package:atmgo/core/common/asset/app_assets.dart';
import 'package:atmgo/core/common/theme/app_color.dart';
import 'package:atmgo/di/locator.dart';
import 'package:atmgo/features/setting/setting_viewmodel/setting_viewmodel.dart';
import 'package:atmgo/features/setting/widget/setting_widget.dart';
import 'package:atmgo/features/setting/widget/shortcut_widget.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = locator<SettingViewModel>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 100,
              pinned: true,
              backgroundColor: AppColors.primary,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final double shrinkOffset =
                      constraints.maxHeight - kToolbarHeight;
                  final bool isCollapsed = shrinkOffset < 40;

                  return FlexibleSpaceBar(
                    centerTitle: true,
                    title:
                        isCollapsed
                            ? const Text(
                              "ATM Go",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            )
                            : null,
                    background: Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        bottom: 32.0,
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "ATM-Go",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Tìm kiếm ATM thuận tiện, nhanh chóng",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ];
        },
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 20),

            const Text(
              "Cài đặt ứng dụng",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),

            SettingWidget(
              child: ExpansionTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.language,
                    color: Colors.blue,
                    size: 20,
                  ),
                ),
                title: const Text(
                  "Ngôn ngữ",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                subtitle: Text(
                  vm.language == LanguageOption.vietnamese
                      ? "Tiếng Việt"
                      : "English",
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                children: [
                  RadioListTile<LanguageOption>(
                    title: const Text("Tiếng Việt"),
                    value: LanguageOption.vietnamese,
                    groupValue: vm.language,
                    onChanged: vm.setLanguage,
                    activeColor: Colors.blue,
                  ),
                  RadioListTile<LanguageOption>(
                    title: const Text("English"),
                    value: LanguageOption.english,
                    groupValue: vm.language,
                    onChanged: vm.setLanguage,
                    activeColor: Colors.blue,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// Theme Setting
            SettingWidget(
              child: ExpansionTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(
                    AppAssets.iconLanguage,
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                ),
                title: const Text(
                  "Giao diện",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                subtitle: Text(
                  vm.theme == ThemeOption.light ? "Sáng" : "Tối",
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                children: [
                  RadioListTile<ThemeOption>(
                    title: const Text("Sáng"),
                    value: ThemeOption.light,
                    groupValue: vm.theme,
                    onChanged: vm.setTheme,
                    activeColor: AppColors.primary,
                  ),
                  RadioListTile<ThemeOption>(
                    title: const Text("Tối"),
                    value: ThemeOption.dark,
                    groupValue: vm.theme,
                    onChanged: vm.setTheme,
                    activeColor: AppColors.primary,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Thông tin pháp lý",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 14),

            SettingWidget(
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(
                    AppAssets.iconPolicy,
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                ),
                title: const Text(
                  "Điều khoản & Chính sách",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                subtitle: Text(
                  "Xem chi tiết",
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                trailing: const Icon(Icons.chevron_right, size: 18),
                onTap: () {},
              ),
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ShortcutButton(
                  icon: AppAssets.iconSupport,
                  label: "Hỗ trợ",
                  color: Colors.blue.shade400,
                  onTap: () {},
                ),
                ShortcutButton(
                  icon: AppAssets.iconInfo,
                  label: "Giới thiệu",
                  color: Colors.green,
                  onTap: () {},
                ),
                ShortcutButton(
                  icon: AppAssets.iconVote,
                  label: "Đánh giá",
                  color: Colors.orange,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
