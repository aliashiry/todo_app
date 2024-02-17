import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:todo_app/theme/my_theme.dart';

import '../settings/language_bottom_sheet.dart';
import '../settings/theme_bottom_sheet.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: provider.isDarkMode()
                      ? MyTheme.whiteColor
                      : MyTheme.blackColor,
                ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: provider.isDarkMode()
                    ? MyTheme.backgroundDarkColor
                    : MyTheme.whiteColor,
                border: Border.all(color: MyTheme.primaryColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  provider.appLanguage == "en"
                      ? AppLocalizations.of(context)!.english
                      : AppLocalizations.of(context)!.arabic,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: provider.isDarkMode()
                            ? MyTheme.whiteColor
                            : MyTheme.blackColor,
                        fontSize: 20,
                      ),
                ),
                IconButton(
                    onPressed: () {
                      showLanguageBottomSheet();
                    },
                    icon: const Icon(Icons.arrow_drop_down_outlined))
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Text(
            AppLocalizations.of(context)!.theme,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: provider.isDarkMode()
                      ? MyTheme.whiteColor
                      : MyTheme.blackColor,
                ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: provider.isDarkMode()
                    ? MyTheme.backgroundDarkColor
                    : MyTheme.whiteColor,
                border: Border.all(color: MyTheme.primaryColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  provider.isDarkMode()
                      ? AppLocalizations.of(context)!.dark
                      : AppLocalizations.of(context)!.light,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: provider.isDarkMode()
                            ? MyTheme.whiteColor
                            : MyTheme.blackColor,
                        fontSize: 20,
                      ),
                ),
                IconButton(
                    onPressed: () {
                      showThemeBottomSheet();
                    },
                    icon: const Icon(Icons.arrow_drop_down_outlined))
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const LanguageBottomSheet(),
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const ThemeBottomSheet(),
    );
  }
}
