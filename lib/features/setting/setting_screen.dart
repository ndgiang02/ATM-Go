import 'package:atmgo/core/common/asset/app_assets.dart';
import 'package:atmgo/core/common/widget/glass_widget.dart';
import 'package:atmgo/di/locator.dart';
import 'package:atmgo/features/setting/setting_viewmodel/setting_viewmodel.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = locator<SettingViewModel>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blueGrey.shade900.withAlpha(30),
                  Colors.blueGrey.shade700,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 100,
                  pinned: true,
                  backgroundColor: Colors.blueGrey,
                  flexibleSpace: LayoutBuilder(
                    builder: (
                      BuildContext context,
                      BoxConstraints constraints,
                    ) {
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
                              children: [
                                Text(
                                  "ATM-Go",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Phiên bản 1.0.1",
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(color: Colors.white),
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
              padding: const EdgeInsets.all(10),
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 20),

                GlassContainer(
                  child: ListTile(
                    leading: Image.asset(
                      AppAssets.iconLanguage,
                      width: 20,
                      height: 20,
                      color: Colors.blue,
                    ),
                    title: const Text("Ngôn ngữ"),
                    subtitle: Text(
                      vm.language == LanguageOption.vietnamese
                          ? "Tiếng Việt"
                          : "English",
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: const Icon(Icons.chevron_right, size: 18),
                    onTap: () {},
                  ),
                ),

                const SizedBox(height: 20),

                GlassContainer(
                  child: ListTile(
                    leading: Image.asset(
                      AppAssets.iconThemes,
                      width: 20,
                      height: 20,
                      color: Colors.tealAccent,
                    ),
                    title: const Text("Giao diện"),
                    subtitle: Text(
                      vm.theme == ThemeOption.light ? "Sáng" : "Tối",
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: const Icon(Icons.chevron_right, size: 18),
                    onTap: () {},
                  ),
                ),

                const SizedBox(height: 20),

                GlassContainer(
                  child: ListTile(
                    leading: Image.asset(
                      AppAssets.iconPolicy,
                      width: 20,
                      height: 20,
                      color: Colors.white,
                    ),
                    title: const Text("Điều khoản"),
                    trailing: const Icon(Icons.chevron_right, size: 18),
                    onTap: () {},
                  ),
                ),

                const SizedBox(height: 20),

                GlassContainer(
                  child: ListTile(
                    leading: Image.asset(
                      AppAssets.iconVote,
                      width: 20,
                      height: 20,
                      color: Colors.yellow,
                    ),
                    title: const Text("Đánh giá"),
                    trailing: const Icon(Icons.chevron_right, size: 18),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
