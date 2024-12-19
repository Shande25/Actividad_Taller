import 'package:flutter/material.dart';
import 'package:nethub/screens/loginScreen.dart';
import 'package:nethub/screens/navegacion/drawer.dart';
import 'package:nethub/screens/registerScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = true; // Estado inicial del tema

  // Función para cambiar el tema
  void cambiarTema(bool isDark) {
    setState(() {
      isDarkMode = isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovieStream',
      theme: isDarkMode
          ? ThemeData.dark().copyWith(
              scaffoldBackgroundColor: Colors.black,
            )
          : ThemeData.light().copyWith(
              scaffoldBackgroundColor: Colors.white,
            ),
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(cambiarTema: cambiarTema), // Pasamos la función cambiarTema
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  final ValueChanged<bool> cambiarTema;

  const WelcomeScreen({Key? key, required this.cambiarTema}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark; // Verifica el tema actual

    return Scaffold(
      appBar: AppBar(
        title: Text("¡Bienvenido a MovieStream!"),
        backgroundColor: isDarkMode ? Colors.black : Colors.redAccent, // Cambia color según tema
      ),
      drawer: MyDrawer(cambiarTema: cambiarTema), // Incluye el Drawer con el botón de tema
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
                    color: isDarkMode ? Colors.white : Colors.black, // Cambiar color del texto según tema
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
                    color: isDarkMode ? Colors.white70 : Colors.black87, // Cambiar color del subtítulo
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                // Botón de "Iniciar sesión"
                ElevatedButton(
                  onPressed: () {
                    // Navegar a la pantalla de login
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
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
                    // Navegar a la pantalla de registro
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
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