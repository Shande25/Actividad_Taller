
import 'package:flutter/material.dart';
import 'package:nethub/main.dart';
import 'package:nethub/screens/catalogoScreen.dart';
import 'package:nethub/screens/loginScreen.dart';
import 'package:nethub/screens/registerScreen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // Item para la pantalla principal (bienvenida)
          
            ListTile(
            title: Text("Iniciar sesión"),
            onTap: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => WelcomeScreen())),
          ),
          // Item para la pantalla de login
          ListTile(
            title: Text("Iniciar sesión"),
            onTap: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginScreen())),
          ),
          // Item para la pantalla de registro
          ListTile(
            title: Text("Registrarse"),
            onTap: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => RegisterScreen())),
          ),
          ListTile(
            title: Text("Catalogo"),
            onTap: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => CatalogoScreen())),
          ),
  
        ],
      ),
    );
  }
}
