import 'package:flutter/material.dart';

class CatalogoScreen extends StatelessWidget {
  final List<Map<String, String>> movies = [
    {
      'title': 'Película 1',
      'description': 'Una emocionante aventura en el espacio.',
      'image': 'https://hips.hearstapps.com/hmg-prod/images/9oymvcp2zyw0zpwotuxldo2msmw-6683e31cc95b0.jpg?crop=1xw:1xh;center,top&resize=980:*',
      'videoUrl': 'https://firebasestorage.googleapis.com/v0/b/your_project_id.appspot.com/o/videos%2Fvideo1.mp4?alt=media',
    },
    // Agrega más películas con sus URLs
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
                Navigator.pushNamed(
                  context,
                  '/player',
                  arguments: movies[index]['videoUrl'],  // Pasamos la URL del video
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
