import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nethub/screens/catalogoScreen.dart';
import 'RegisterScreen.dart'; // Asegúrate de importar la pantalla de Registro

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Función para iniciar sesión
  Future<void> _loginUser(BuildContext context) async {
    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        // Mostrar mensaje de error si alguno de los campos está vacío
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Por favor ingresa todos los campos")),
        );
        return;
      }

      // Intentar iniciar sesión con Firebase Auth
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Si el login es exitoso, redirigir a la siguiente pantalla (por ejemplo, a un catálogo)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CatalogoScreen()), // Cambiar por tu pantalla de catálogo
      );
    } on FirebaseAuthException catch (e) {
      // Mostrar mensaje de error si las credenciales son incorrectas o hay otro error
      String errorMessage = e.message ?? 'Ocurrió un error desconocido.';

      // Si el error es debido a credenciales incorrectas
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        errorMessage = 'Credenciales incorrectas, por favor revisa tu correo o contraseña.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Iniciar Sesión",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Bienvenido de nuevo",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Inicia sesión para continuar",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[500],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
                  labelStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.email, color: Colors.red),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
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
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.lock, color: Colors.red),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
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
              ElevatedButton(
                onPressed: () => _loginUser(context), // Llama a la función de login
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  "Iniciar Sesión",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Texto en blanco
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  // Redirigir a la pantalla de registro
                  Navigator.pushReplacement(
                    context, 
                    MaterialPageRoute(builder: (context) => RegisterScreen())
                  );
                },
                child: Text(
                  "¿No tienes cuenta? Regístrate aquí",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
