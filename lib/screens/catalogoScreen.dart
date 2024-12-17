import 'package:flutter/material.dart';
import 'package:nethub/screens/videoScreen.dart';
 // Asegúrate de importar el VideoPlayerScreen

class CatalogoScreen extends StatelessWidget {
  final List<Map<String, String>> movies = [
    {
      'title': 'Película 1',
      'description': 'Una emocionante aventura en el espacio.',
      'image': 'https://hips.hearstapps.com/hmg-prod/images/9oymvcp2zyw0zpwotuxldo2msmw-6683e31cc95b0.jpg?crop=1xw:1xh;center,top&resize=980:*',
      'videoUrl': 'https://firebasestorage.googleapis.com/v0/b/app-pokemon-73fee.appspot.com/o/productos%2FCris%20MJ%2C%20Kali%20Uchis%2C%20JHAYCO%20-%20SI%20NO%20ES%20CONTIGO%20REMIX.mp4?alt=media&token=6fbad8bf-da92-4561-8bda-adeadca03441',
    },
    {
      'title': 'Película 1',
      'description': 'Una emocionante aventura en el espacio.',
      'image': 'https://hips.hearstapps.com/hmg-prod/images/9oymvcp2zyw0zpwotuxldo2msmw-6683e31cc95b0.jpg?crop=1xw:1xh;center,top&resize=980:*',
      'videoUrl': 'https://firebasestorage.googleapis.com/v0/b/app-pokemon-73fee.appspot.com/o/productos%2FRels%20B%20-%201000%20Millones%20(Audio%20Oficial).mp4?alt=media&token=9e832255-79bc-496a-812e-796ec95e1121',
    },
    {
      'title': 'Película 2',
      'description': 'Una emocionante aventura en el espacio.',
      'image': 'https://hips.hearstapps.com/hmg-prod/images/9oymvcp2zyw0zpwotuxldo2msmw-6683e31cc95b0.jpg?crop=1xw:1xh;center,top&resize=980:*',
      'videoUrl': 'https://firebasestorage.googleapis.com/v0/b/app-pokemon-73fee.appspot.com/o/productos%2FCris%20MJ%2C%20Kali%20Uchis%2C%20JHAYCO%20-%20SI%20NO%20ES%20CONTIGO%20REMIX.mp4?alt=media&token=6fbad8bf-da92-4561-8bda-adeadca03441',
    },
    {
      'title': 'Película 1',
      'description': 'Una emocionante aventura en el espacio.',
      'image': 'https://hips.hearstapps.com/hmg-prod/images/9oymvcp2zyw0zpwotuxldo2msmw-6683e31cc95b0.jpg?crop=1xw:1xh;center,top&resize=980:*',
      'videoUrl': 'https://firebasestorage.googleapis.com/v0/b/app-pokemon-73fee.appspot.com/o/productos%2FCris%20MJ%2C%20Kali%20Uchis%2C%20JHAYCO%20-%20SI%20NO%20ES%20CONTIGO%20REMIX.mp4?alt=media&token=6fbad8bf-da92-4561-8bda-adeadca03441',
    },
    // Agrega más películas si es necesario
  ];

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.6,
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
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.network(
                          movies[index]['image']!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movies[index]['title']!,
                            style: TextStyle(
                              fontSize: 14,
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
                              fontSize: 12,
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
    );
  }
}
