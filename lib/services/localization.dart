import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocalizationService {
  static final List<Locale> supportedLocales = [const Locale('en'), const Locale('cs')];

  static void changeLocale(BuildContext context, int index) {
    Locale newLocale = supportedLocales[index];
    EasyLocalization.of(context)!.setLocale(newLocale);
  }
}
