import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:one_futbol/componentes/provider.dart';
import 'package:one_futbol/widget/Servicio_widget.dart';
import 'package:one_futbol/widget/setting_item.dart';
import 'package:provider/provider.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ajustes',
        ),
        centerTitle: false,
        backgroundColor: const Color(0xFFAC0202),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body:
          Consumer<UiProvider>(builder: (context, UiProvider notifier, child) {
        return SafeArea(
          minimum: EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'Temas',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ListTile(
                  leading: const Icon(Icons.dark_mode),
                  title: const Text('Tema Claro - Oscuro'),
                  trailing: Switch(
                      value: notifier.isDark,
                      onChanged: (value) => notifier.changeTheme()),
                ),
              const SizedBox(height: 20),
              Text(
                'Settings',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // const SizedBox(height: 20),
              // SettingItem(
              //   title: '  Language',
              //   icon: Ionicons.earth,
              //   bgColor: Colors.red.shade100,
              //   iconColor: Colors.red,
              //   value: 'English',
              //   onTap: () {},
              // ),
              // const SizedBox(height: 20),
              // SettingItem(
              //   title: '  Notifications',
              //   icon: Ionicons.notifications,
              //   bgColor: Colors.blue.shade100,
              //   iconColor: Colors.blue,
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context)=> const ServicioWidget()));
              //   },
              // ),
              const SizedBox(height: 20),
              SettingItem(
                title: '  Help',
                icon: Ionicons.warning_outline,
                bgColor: Colors.red.shade100,
                iconColor: Colors.red,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const ServicioWidget()));
                },
              ),
              const SizedBox(height: 40),
              SafeArea(
                left: true,
                right: true,
                minimum: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Version de la Aplicación',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('1.0')
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
