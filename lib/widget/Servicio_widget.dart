import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ServicioWidget extends StatefulWidget {
  const ServicioWidget({super.key});

  @override
  State<ServicioWidget> createState() => _ServicioWidgetState();
}

class _ServicioWidgetState extends State<ServicioWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sin Servicio',
        ),
        centerTitle: false,
        backgroundColor: const Color(0xFFAC0202),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
    );
  }
}
