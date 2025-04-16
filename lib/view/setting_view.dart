import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:one_futbol/componentes/box.dart';
import 'package:one_futbol/componentes/button.dart';
import 'package:one_futbol/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(),
        title: const Text(
          'Settings',
          style: TextStyle(),
        ),
        centerTitle: false,
        backgroundColor: const Color.fromARGB(255, 112, 119, 249),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: MyBox(
          color: Theme.of(context).colorScheme.background, 
          child: MyButton(color: Theme.of(context).colorScheme.secondary,
           onTap: (){
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
           }
           ),
        )
      ),
    );
  }}