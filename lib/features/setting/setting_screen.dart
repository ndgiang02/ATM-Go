import 'package:atmgo/di/locator.dart';
import 'package:atmgo/features/setting/setting_viewmodel/setting_viewmodel.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = locator<SettingViewModel>();
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        color: theme.colorScheme.background,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          children: [
            // Banner/logo app
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: theme.colorScheme.primary,
                    child: const Icon(Icons.account_balance, size: 36, color: Colors.white),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("ATM-Go", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        SizedBox(height: 6),
                        Text(
                          "Tìm kiếm ATM thuận tiện, nhanh chóng.",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ShortcutButton(
                  icon: Icons.support_agent,
                  label: "Hỗ trợ",
                  onTap: () {},
                ),
                _ShortcutButton(
                  icon: Icons.info_outline,
                  label: "Giới thiệu",
                  onTap: () {},
                ),
                _ShortcutButton(
                  icon: Icons.star_border,
                  label: "Đánh giá",
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 22),

            ExpansionTile(
              leading: const Icon(Icons.language, color: Colors.blueAccent),
              title: const Text(
                "Ngôn ngữ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                vm.language == LanguageOption.vietnamese ? "Tiếng Việt" : "English",
                style: const TextStyle(color: Colors.grey),
              ),
              children: [
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
              ],
            ),

            ExpansionTile(
              leading: const Icon(Icons.color_lens_outlined, color: Colors.deepPurple),
              title: const Text(
                "Giao diện",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                vm.theme == ThemeOption.light ? "Sáng" : "Tối",
                style: const TextStyle(color: Colors.grey),
              ),
              children: [
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
              ],
            ),
            const Divider(height: 24),

            ListTile(
              leading: const Icon(Icons.policy_outlined, color: Colors.green),
              title: const Text("Chính sách dịch vụ"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.description_outlined, color: Colors.orange),
              title: const Text("Điều khoản sử dụng"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _ShortcutButton extends StatelessWidget {

  const _ShortcutButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            child: Icon(icon, color: Colors.blueAccent),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
