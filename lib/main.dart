import 'package:flutter/material.dart';
import 'package:one_futbol/database/database_helper.dart';
import 'package:one_futbol/mianwrapper.dart';
import 'package:one_futbol/theme/theme_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.init();
  runApp(
      ChangeNotifierProvider(create: (context) => ThemeProvider(),
      child: const MyApp(),
      )
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Una Pichanga Demo',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: MainWrapper(),
    );
  }
}
