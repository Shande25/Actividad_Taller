import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:nethub/screens/loginScreen.dart'; // Asegúrate de importar tu pantalla de login
import 'package:flutter/services.dart'; // Necesario para el inputFormatter

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  bool _isLoading = true;
  bool isDarkMode = false; // Variable que controla el modo oscuro
  String? _ageError; // Variable para mostrar un error en el campo de edad

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      // Obtener el usuario actual
      User? user = _auth.currentUser;

      if (user != null) {
        String uid = user.uid;

        // Obtener datos del usuario desde la base de datos
        DatabaseReference userRef = _dbRef.child("users").child(uid);
        DataSnapshot snapshot = await userRef.get(); // Usar get() en lugar de once()

        if (snapshot.exists) {
          Map<String, dynamic> userData = Map<String, dynamic>.from(snapshot.value as Map);

          // Asignar datos a los controladores
          _nameController.text = userData['username'] ?? '';
          _emailController.text = userData['email'] ?? user.email!;
          _ageController.text = userData['age']?.toString() ?? '';
        }
      }
    } catch (e) {
      print("Error cargando datos del usuario: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveUserData() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        String uid = user.uid;

        // Validar que la edad sea un número
        final age = int.tryParse(_ageController.text);
        if (age == null) {
          setState(() {
            _ageError = 'Por favor, ingresa una edad válida';
          });
          return;
        }

        // Actualizar datos del usuario en la base de datos
        await _dbRef.child("users").child(uid).update({
          'username': _nameController.text,
          'email': _emailController.text,
          'age': age,
        });

        // Cerrar sesión automáticamente después de guardar los cambios
        await _auth.signOut();

        // Redirigir al usuario al LoginScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()), // Asegúrate de que LoginScreen esté correctamente configurado
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Información actualizada. Cierre de sesión automático.")),
        );
      }
    } catch (e) {
      print("Error guardando datos del usuario: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al actualizar información")),
      );
    }
  }

  Future<void> _signOut() async {
    try {
      await _auth.signOut(); // Cerrar sesión
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()), // Redirigir al LoginScreen
      );
    } catch (e) {
      print("Error al cerrar sesión: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al cerrar sesión")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(
          "Perfil",
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.wb_sunny_rounded : Icons.nightlight_round,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode; // Alternar entre modo oscuro y claro
              });
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  // Imagen de perfil
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                        'https://www.example.com/profile_image.jpg', // Usa tu imagen de perfil aquí
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Título de la sección de perfil
                  Text(
                    'Información de Perfil',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black, // Cambiar color según el tema
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),

                  // Campos de texto para editar el perfil
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Nombre de usuario",
                      labelStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: isDarkMode ? Colors.red : Colors.blue), // Rojo o azul según el tema
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      fillColor: isDarkMode ? Colors.black : Colors.white,
                      filled: true,
                    ),
                    style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                  ),
                  SizedBox(height: 16),

                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Correo Electrónico",
                      labelStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: isDarkMode ? Colors.red : Colors.blue),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      fillColor: isDarkMode ? Colors.black : Colors.white,
                      filled: true,
                    ),
                    style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                  ),
                  SizedBox(height: 16),

                  // Campo de Edad con validación
                  TextField(
                    controller: _ageController,
                    keyboardType: TextInputType.numberWithOptions(decimal: false),
                    decoration: InputDecoration(
                      labelText: "Edad",
                      labelStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: isDarkMode ? Colors.red : Colors.blue),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      fillColor: isDarkMode ? Colors.black : Colors.white,
                      filled: true,
                      errorText: _ageError, // Mostrar error si hay
                    ),
                    style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, // Solo permite números
                    ],
                  ),
                  SizedBox(height: 20),

                  // Botón para guardar cambios con estilo tipo Netflix (rojo) y texto en blanco
                  ElevatedButton(
                    onPressed: _saveUserData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode ? Colors.red : Colors.black, // Cambiar color según el tema
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text(
                      "Guardar Cambios",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Ícono de Cerrar sesión (en lugar de un botón de texto)
                  IconButton(
                    icon: Icon(Icons.exit_to_app, color: isDarkMode ? Colors.white : Colors.black, size: 30),
                    onPressed: _signOut,
                    tooltip: "Cerrar sesión",
                  ),
                ],
              ),
            ),
    );
  }
}
