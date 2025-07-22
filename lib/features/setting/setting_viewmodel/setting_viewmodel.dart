import 'package:flutter/material.dart';

enum LanguageOption { vietnamese, english }

enum ThemeOption { light, dark }

class SettingViewModel extends ChangeNotifier {
  LanguageOption _language = LanguageOption.vietnamese;
  ThemeOption _theme = ThemeOption.light;

  LanguageOption get language => _language;
  ThemeOption get theme => _theme;

  void setLanguage(LanguageOption? lang) {
    if (lang == null) return;
    _language = lang;
    notifyListeners();
  }

  void setTheme(ThemeOption? theme) {
    if (theme == null) return;
    _theme = theme;
    notifyListeners();
  }

  bool get isDarkMode => _theme == ThemeOption.dark;
}
