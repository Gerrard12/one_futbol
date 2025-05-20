import 'package:flutter/material.dart';
import 'package:one_futbol/componentes/provider.dart';
import 'package:one_futbol/mianwrapper.dart';
import 'package:provider/provider.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return ChangeNotifierProvider(
          create: (BuildContext context)=>UiProvider()..init(),
          child: Consumer<UiProvider>(
            builder: (context, UiProvider notifier, child) {
              return MaterialApp(
                themeMode: notifier.isDark? ThemeMode.dark : ThemeMode.light,
                darkTheme: notifier.isDark? notifier.darkTheme : notifier.lightTheme,
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFAC0202)),
                  useMaterial3: true,
                ),
                title: 'Una Pichanga Demo',
                home: MainWrapper(),
              );
            },
          ),
        );
      }
    );
  }
}
