import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('en', 'US'),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('en', 'GB'),
        Locale('en', 'US'),
        Locale('ar'),
        Locale('zh'),
      ],
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 400,
                    child: RangeDatePicker(
                      centerLeadingDate: true,
                      minDate: DateTime(2024, 4, 10),
                      maxDate: DateTime(2024, 10, 30),
                      disabledDates: [DateTime(2024, 6, 14), DateTime(2024, 6, 17), DateTime(2024, 6, 26)],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
