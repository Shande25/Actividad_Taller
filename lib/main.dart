import 'package:flutter/material.dart';
import 'package:nethub/screens/loginScreen.dart';
import 'package:nethub/screens/navegacion/drawer.dart';
import 'package:nethub/screens/registerScreen.dart';
// Pantalla de registro

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovieStream',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false, // Desactivar banner de debug
      home: WelcomeScreen(),  // Pantalla inicial
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("¡Bienvenido a MovieStream!"),
        backgroundColor: Colors.black,
      ),
      drawer: MyDrawer(), // Aquí incluimos el Drawer
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/portada.jpeg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.darken,
            ),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Título destacado
                Text(
                  "¡Bienvenido a MovieStream!",
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 2),
                        blurRadius: 6,
                        color: Colors.black87,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                // Subtítulo
                Text(
                  "Explora y transmite tus películas favoritas al instante.",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                // Botón de "Iniciar sesión"
                ElevatedButton(
                  onPressed: () {
                    // Acción para ir a la pantalla de login
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.redAccent,
                    elevation: 5,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    "Iniciar sesión",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20), // Espaciado entre botones
                // Botón de "Registrarse"
                OutlinedButton(
                  onPressed: () {
                    // Acción para ir a la pantalla de registro
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.redAccent, width: 2),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    "Registrarse",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
