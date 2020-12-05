import 'package:flutter/material.dart';
import 'package:tea_app/generated/l10n.dart';
import 'package:tea_app/local_storage/user_preferences.dart';

class SettingsTab extends StatefulWidget {
  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    const americanDolar = 'USD';
    const pound = "GBP";
    const zloty = "PLN";
    const euro = "Euro";

    return Container(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      '${delegate.LanguageText}',
                      style: TextStyle(
                          fontSize: 30, color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Center(
                    child: DropdownButton(
                        dropdownColor: Colors.white,
                        value: UserPreferences().getLang(),
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20),
                        underline: Container(
                          height: 2,
                          color: Theme.of(context).primaryColor,
                        ),
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.public,
                            size: 20,
                          ),
                        ),
                        items: AppLocalizationDelegate()
                            .supportedLocales
                            .map<DropdownMenuItem<String>>((Locale locale) {
                          return DropdownMenuItem<String>(
                              value: locale.languageCode,
                              child: Text(locale.languageCode));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            S.load(Locale(value));
                          });
                          UserPreferences().setLang(value);
                        }),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      '${delegate.CurrencyText}',
                      style: TextStyle(
                          fontSize: 30, color: Theme.of(context).primaryColor),
                    ),
                  ),
                  DropdownButton(
                      dropdownColor: Colors.white,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                      underline: Container(
                        height: 2,
                        color: Theme.of(context).primaryColor,
                      ),
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(Icons.payments),
                      ),
                      value: UserPreferences().getCurrency(),
                      items: <String>[americanDolar, pound, zloty, euro]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          child: Text(value),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          UserPreferences().setCurrency(value);
                        });
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
