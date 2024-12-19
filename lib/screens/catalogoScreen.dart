import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nethub/screens/videoScreen.dart';
import 'package:nethub/screens/profileScreen.dart';
import 'package:firebase_database/firebase_database.dart'; // Asegúrate de tener esto importado para usar Firebase Realtime Database

class CatalogoScreen extends StatefulWidget {
  @override
  _CatalogoScreenState createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  int userAge = 21; // Inicializa con un valor predeterminado, pero lo actualizarás desde Firebase.
  
  // Lista de películas
  final List<Map<String, dynamic>> movies = [
    {
      'title': 'Valiente',
      'description': 'Una emocionante aventura en el espacio.',
      'image':
          'https://hips.hearstapps.com/hmg-prod/images/9oymvcp2zyw0zpwotuxldo2msmw-6683e31cc95b0.jpg?crop=1xw:1xh;center,top&resize=980:*',
      'videoUrl':
          'https://firebasestorage.googleapis.com/v0/b/app-pokemon-73fee.appspot.com/o/productos%2Fvaliente.mp4?alt=media&token=b7de827a-34e1-44e3-ad45-351fec637f33',
      'isRestricted': false,
    },
    {
      'title': 'Venom el último baile',
      'description':
          'Mientras Eddie Brock lucha por encontrar algo que se asemeje a la normalidad...',
      'image':
          'https://external-preview.redd.it/QRoTFuj9xNnWiaJ5TZveODcuYA2WwSaRsMVXdb3kAJ8.jpg?width=1080&crop=smart&auto=webp&s=2bcc30d21a7d24b53a00bab921ef5d06c492c151',
      'videoUrl':
          'https://firebasestorage.googleapis.com/v0/b/app-pokemon-73fee.appspot.com/o/productos%2FEl%20Venudo.mp4?alt=media&token=a171480b-5741-4174-a5bf-5a4ba1a51036',
      'isRestricted': false,
    },
    {
      'title': 'El Grinch',
      'description': 'Una criatura verde planea arruinarles la Navidad...',
      'image': 'https://i.ebayimg.com/images/g/sN0AAOSwRWRjTcNB/s-l1600.webp',
      'videoUrl':
          'https://firebasestorage.googleapis.com/v0/b/app-pokemon-73fee.appspot.com/o/productos%2FEl%20Grinch.mp4?alt=media&token=1cdfbf26-953a-4f77-9018-bb339cba387f',
      'isRestricted': false,
    },
    {
      'title': 'Evil Dead Rise',
      'description':
          'Mientras Eddie Brock lucha por encontrar algo que se asemeje a la normalidad...',
      'image':
          'https://www.findelahistoria.com/web/wp-content/uploads/2023/04/evil-dead-rise-729x1080.jpg',
      'videoUrl':
          'https://firebasestorage.googleapis.com/v0/b/app-pokemon-73fee.appspot.com/o/productos%2FEvil%20Dead%20El%20Despertar.mp4?alt=media&token=4cd36a7e-5d7c-4a78-a668-be9fc251bb3a',
      'isRestricted': true,
    },
  ];

  final List<String> carouselImages = [
    'https://external-preview.redd.it/QRoTFuj9xNnWiaJ5TZveODcuYA2WwSaRsMVXdb3kAJ8.jpg?width=1080&crop=smart&auto=webp&s=2bcc30d21a7d24b53a00bab921ef5d06c492c151',
    'https://i.ebayimg.com/images/g/sN0AAOSwRWRjTcNB/s-l1600.webp',
    'https://hips.hearstapps.com/hmg-prod/images/9oymvcp2zyw0zpwotuxldo2msmw-6683e31cc95b0.jpg?crop=1xw:1xh;center,top&resize=980:*',
    'https://www.findelahistoria.com/web/wp-content/uploads/2023/04/evil-dead-rise-729x1080.jpg'
  ];

  PageController _pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchUserAge(); // Cargar la edad del usuario desde Firebase
    _startAutoSlide();
  }

  // Función para obtener la edad del usuario desde Firebase
  void _fetchUserAge() async {
    DatabaseReference userRef = FirebaseDatabase.instance.ref('users/your_user_id'); // Reemplaza 'your_user_id' con el ID real del usuario
    userRef.child('age').get().then((DataSnapshot snapshot) {
      if (snapshot.exists) {
        // Convertir el valor de la edad a un entero
        setState(() {
          userAge = int.tryParse(snapshot.value.toString()) ?? 21; // Usa 21 como valor predeterminado si la conversión falla
        });
      }
    });
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        int currentPage = _pageController.page?.toInt() ?? 0;
        int nextPage = (currentPage + 1) % carouselImages.length;
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _showAgeRestrictionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Acceso Restringido"),
          content:
              Text("Esta película está restringida para menores de 18 años."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Catálogo de Películas",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(), // Navega a la pantalla de perfil
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Carrusel de imágenes
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                itemCount: carouselImages.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    carouselImages[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.7,
                ),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Verificar si la película está restringida y el usuario es menor de 18 años
                      if (movies[index]['isRestricted'] == true && userAge < 18) {
                        _showAgeRestrictionDialog(); // Mostrar el diálogo de restricción
                      } else {
                        // Si la película no está restringida o el usuario tiene la edad suficiente, navega al reproductor de video
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoPlayerScreen(
                              videoUrl: movies[index]['videoUrl'],
                            ),
                          ),
                        );
                      }
                    },
                    child: Card(
                      color: Colors.white10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                movies[index]['image'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movies[index]['title'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  movies[index]['description'],
                                  style: TextStyle(color: Colors.white70),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
