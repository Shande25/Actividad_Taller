import 'package:flutter/material.dart';
import 'package:nethub/main.dart';
import 'package:nethub/screens/loginScreen.dart';
import 'package:nethub/screens/registerScreen.dart';

class MyDrawer extends StatelessWidget {
  final ValueChanged<bool> cambiarTema;

  const MyDrawer({super.key, required this.cambiarTema});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // Item para la pantalla principal (bienvenida)
          ListTile(
            title: Text("Bienvenida"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => WelcomeScreen(cambiarTema: cambiarTema), // Pasamos la función cambiarTema
                ),
              );
            },
          ),
          // Item para la pantalla de login
          ListTile(
            title: Text("Iniciar sesión"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
          // Item para la pantalla de registro
          ListTile(
            title: Text("Registrarse"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => RegisterScreen()),
              );
            },
          ),
          // Separador
          Divider(),
          // Opción para cambiar el tema
          ListTile(
            title: Text("Cambiar tema"),
            onTap: () {
              // Verificar si el tema actual es oscuro o claro
              bool isDark = Theme.of(context).brightness == Brightness.dark;
              cambiarTema(!isDark); // Cambiar el tema
            },
          ),
        ],
      ),
    );
  }
}