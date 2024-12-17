import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Importa FirebaseAuth
import 'package:nethub/screens/loginScreen.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance; // Instancia de FirebaseAuth

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          // Fondo con imagen
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://media.a24.com/p/a9caa1675e4e534b7b3929029cacf7e6/adjuntos/296/imagenes/009/055/0009055684/1200x675/smart/imagepng.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Contenido dentro de SingleChildScrollView para permitir desplazamiento
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Image.network(
                      'https://static.vecteezy.com/system/resources/previews/017/396/804/non_2x/netflix-mobile-application-logo-free-png.png',
                      height: 100,
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    "Crear una cuenta",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Completa tus datos para continuar",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[300],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  
                  // Campo de correo electrónico
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Correo Electrónico",
                      labelStyle: TextStyle(color: Colors.grey[300]),
                      prefixIcon: Icon(Icons.email, color: Colors.red),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),

                  // Campo de contraseña
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: "Contraseña",
                      labelStyle: TextStyle(color: Colors.grey[300]),
                      prefixIcon: Icon(Icons.lock, color: Colors.red),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                  ),
                  SizedBox(height: 30),

                  // Botón de registrarse
                  ElevatedButton(
                    onPressed: () async {
                      String email = _emailController.text;
                      String password = _passwordController.text;

                      if (email.isNotEmpty && password.isNotEmpty) {
                        try {
                          // Registro del usuario en Firebase
                          UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("¡Usuario registrado exitosamente!")),
                          );
                          // Navega a LoginScreen después de registro exitoso
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error al registrar: $e")),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Por favor llena todos los campos")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      "Registrarse",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      "¿Ya tienes cuenta? Inicia sesión aquí",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
