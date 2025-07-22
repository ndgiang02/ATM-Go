import 'package:atmgo/di/locator.dart';
import 'package:atmgo/features/setting/setting_viewmodel/setting_viewmodel.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = locator<SettingViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Thiết lập")),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          const SizedBox(height: 8),
          const Text("Ngôn ngữ", style: TextStyle(fontWeight: FontWeight.bold)),
          RadioListTile<LanguageOption>(
            title: const Text("Tiếng Việt"),
            value: LanguageOption.vietnamese,
            groupValue: vm.language,
            onChanged: vm.setLanguage,
          ),
          RadioListTile<LanguageOption>(
            title: const Text("English"),
            value: LanguageOption.english,
            groupValue: vm.language,
            onChanged: vm.setLanguage,
          ),

          const Divider(height: 32),

          const Text(
            "Giao diện",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          RadioListTile<ThemeOption>(
            title: const Text("Sáng"),
            value: ThemeOption.light,
            groupValue: vm.theme,
            onChanged: vm.setTheme,
          ),
          RadioListTile<ThemeOption>(
            title: const Text("Tối"),
            value: ThemeOption.dark,
            groupValue: vm.theme,
            onChanged: vm.setTheme,
          ),

          const Divider(height: 32),

          ListTile(
            leading: const Icon(Icons.policy_outlined),
            title: const Text("Chính sách dịch vụ"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text("Điều khoản sử dụng"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
