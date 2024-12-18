import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nethub/screens/videoScreen.dart';

class CatalogoScreen extends StatefulWidget {
  @override
  _CatalogoScreenState createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  final List<Map<String, String>> movies = [
    {
      'title': 'Película 1',
      'description': 'Una emocionante aventura en el espacio.',
      'image': 'https://hips.hearstapps.com/hmg-prod/images/9oymvcp2zyw0zpwotuxldo2msmw-6683e31cc95b0.jpg?crop=1xw:1xh;center,top&resize=980:*',
      'videoUrl': 'https://firebasestorage.googleapis.com/v0/b/app-pokemon-73fee.appspot.com/o/productos%2FCris%20MJ%2C%20Kali%20Uchis%2C%20JHAYCO%20-%20SI%20NO%20ES%20CONTIGO%20REMIX.mp4?alt=media&token=6fbad8bf-da92-4561-8bda-adeadca03441',
    },
    {
      'title': 'Película 2',
      'description': 'Una emocionante aventura en el espacio.',
      'image': 'https://hips.hearstapps.com/hmg-prod/images/9oymvcp2zyw0zpwotuxldo2msmw-6683e31cc95b0.jpg?crop=1xw:1xh;center,top&resize=980:*',
      'videoUrl': 'https://firebasestorage.googleapis.com/v0/b/app-pokemon-73fee.appspot.com/o/productos%2FRels%20B%20-%201000%20Millones%20(Audio%20Oficial).mp4?alt=media&token=9e832255-79bc-496a-812e-796ec95e1121',
    },
    {
      'title': 'El Grinch',
      'description': 'Una criatura verde, solitaria y amargada planea arruinarles la Navidad a los habitantes del pueblo contiguo.',
      'image': 'https://i.ebayimg.com/images/g/sN0AAOSwRWRjTcNB/s-l1600.webp',
      'videoUrl': 'https://firebasestorage.googleapis.com/v0/b/app-pokemon-73fee.appspot.com/o/productos%2FEl%20Grinch.mp4?alt=media&token=1cdfbf26-953a-4f77-9018-bb339cba387f',
    },
    {
      'title': 'Venom el último baile',
      'description': 'Mientras Eddie Brock lucha por encontrar algo que se asemeje a la normalidad, Venom, su inquietante compañero simbionte, anhela el caos y la destrucción.',
      'image': 'https://external-preview.redd.it/QRoTFuj9xNnWiaJ5TZveODcuYA2WwSaRsMVXdb3kAJ8.jpg?width=1080&crop=smart&auto=webp&s=2bcc30d21a7d24b53a00bab921ef5d06c492c151',
      'videoUrl': 'https://firebasestorage.googleapis.com/v0/b/app-pokemon-73fee.appspot.com/o/productos%2FEl%20Venudo.mp4?alt=media&token=a171480b-5741-4174-a5bf-5a4ba1a51036',
    },
  ];

  final List<String> carouselImages = [
    'https://external-preview.redd.it/QRoTFuj9xNnWiaJ5TZveODcuYA2WwSaRsMVXdb3kAJ8.jpg?width=1080&crop=smart&auto=webp&s=2bcc30d21a7d24b53a00bab921ef5d06c492c151',
    'https://i.ebayimg.com/images/g/sN0AAOSwRWRjTcNB/s-l1600.webp',
    'https://hips.hearstapps.com/hmg-prod/images/9oymvcp2zyw0zpwotuxldo2msmw-6683e31cc95b0.jpg?crop=1xw:1xh;center,top&resize=980:*',
  ];

  PageController _pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
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
    super.dispose();
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Carrusel de imágenes en la parte superior
            Stack(
              children: [
                Container(
                  height: 250, // Altura reducida del carrusel
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
                Positioned(
                  left: 10,
                  top: 110, // Ajuste de la posición de las flechas
                  child: IconButton(
                    icon: Icon(Icons.arrow_left, color: Colors.white),
                    onPressed: () {
                      int currentPage = _pageController.page?.toInt() ?? 0;
                      if (currentPage > 0) {
                        _pageController.animateToPage(
                          currentPage - 1,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 110, // Ajuste de la posición de las flechas
                  child: IconButton(
                    icon: Icon(Icons.arrow_right, color: Colors.white),
                    onPressed: () {
                      int currentPage = _pageController.page?.toInt() ?? 0;
                      if (currentPage < carouselImages.length - 1) {
                        _pageController.animateToPage(
                          currentPage + 1,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),

            // Título para la sección de Películas y Estrenos
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Películas y Estrenos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // GridView de películas
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: GridView.builder(
                shrinkWrap: true, // Esto permite que el GridView no ocupe toda la altura
                physics: NeverScrollableScrollPhysics(), // Desactiva el desplazamiento
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  childAspectRatio: 0.6, // Ajustado para que las tarjetas sean más pequeñas
                ),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoPlayerScreen(
                            videoUrl: movies[index]['videoUrl']!,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Menos radio para las esquinas
                      ),
                      elevation: 3, // Menos elevación para hacerlo más plano
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                              child: Image.network(
                                movies[index]['image']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movies[index]['title']!,
                                  style: TextStyle(
                                    fontSize: 12, // Tamaño más pequeño para el título
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  movies[index]['description']!,
                                  style: TextStyle(
                                    fontSize: 10, // Tamaño más pequeño para la descripción
                                    color: Colors.grey,
                                  ),
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
