import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:one_futbol/componentes/provider.dart';
import 'package:provider/provider.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ajustes',
        ),
        centerTitle: false,
        backgroundColor: const Color.fromARGB(255, 112, 119, 249),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body:
          Consumer<UiProvider>(builder: (context, UiProvider notifier, child) {
        return SafeArea(
          left: true,
          right: true,
          minimum: EdgeInsets.all(15.0),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.dark_mode),
                title: const Text('Tema Claro/Oscuro'),
                trailing: Switch(
                    value: notifier.isDark,
                    onChanged: (value) => notifier.changeTheme()),
              ),
              SizedBox(height: 40),
              Text(
                'Settings',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red.shade200
                      ),
                      child: Icon(
                        Ionicons.earth,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Language',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      ),
                      const Spacer(),
                      Text(
                        'English',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Version de la Aplicación',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('1.0')
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
