import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _controlsVisible = true; // Variable para controlar la visibilidad de los controles
  late Timer _timer; // Timer para controlar el tiempo de inactividad

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(false);

    // Iniciar el temporizador cuando el video se inicia
    _startHideControlsTimer();
  }

  void _startHideControlsTimer() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_controlsVisible) {
        setState(() {
          _controlsVisible = false; // Ocultar los controles después de 5 segundos
        });
      }
    });
  }

  void _resetHideControlsTimer() {
    // Reiniciar el temporizador cada vez que se detecta un toque o movimiento del mouse
    _timer.cancel();
    setState(() {
      _controlsVisible = true; // Mostrar los controles
    });
    _startHideControlsTimer(); // Reiniciar el temporizador de ocultación
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _timer.cancel(); // Cancelar el temporizador cuando se destruye el widget
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Reproductor de Película",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: FutureBuilder<void>(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error al cargar el video',
                  style: TextStyle(color: Colors.red),
                ),
              );
            } else {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  if (_controlsVisible) // Solo mostrar los controles si están visibles
                    _ControlsOverlay(
                      controller: _controller,
                      onUserInteraction: _resetHideControlsTimer, // Llamar al reset cuando hay interacción
                    ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  final VideoPlayerController controller;
  final VoidCallback onUserInteraction;

  const _ControlsOverlay({required this.controller, required this.onUserInteraction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (controller.value.isPlaying) {
          controller.pause();
        } else {
          controller.play();
        }
        onUserInteraction(); // Resetear el temporizador cada vez que se toca la pantalla
      },
      child: MouseRegion(
        onEnter: (_) => onUserInteraction(), // Mostrar controles si el mouse entra en el área
        onExit: (_) => onUserInteraction(), // Aquí también puedes agregar el comportamiento de esconder los controles
        onHover: (_) => onUserInteraction(), // Mostrar controles mientras el ratón está dentro del área
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Controles de reproducción
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Botón de retroceder 10 segundos
                      IconButton(
                        icon: Icon(
                          Icons.replay_10,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () {
                          final position = controller.value.position;
                          final newPosition = position - Duration(seconds: 10);
                          controller.seekTo(newPosition > Duration.zero ? newPosition : Duration.zero);
                          onUserInteraction(); // Resetear el temporizador al tocar el botón
                        },
                      ),
                      // Botón de reproducir / pausar
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50), // Ajustamos el espacio
                        child: IconButton(
                          icon: Icon(
                            controller.value.isPlaying
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_filled,
                            color: Colors.white,
                            size: 60,
                          ),
                          onPressed: () {
                            if (controller.value.isPlaying) {
                              controller.pause();
                            } else {
                              controller.play();
                            }
                            onUserInteraction(); // Resetear el temporizador al tocar el botón
                          },
                        ),
                      ),
                      // Botón de adelantar 10 segundos
                      IconButton(
                        icon: Icon(
                          Icons.forward_10,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () {
                          final position = controller.value.position;
                          final newPosition = position + Duration(seconds: 10);
                          controller.seekTo(newPosition < controller.value.duration ? newPosition : controller.value.duration);
                          onUserInteraction(); // Resetear el temporizador al tocar el botón
                        },
                      ),
                    ],
                  ),
                  // Barra de progreso
                  VideoProgressIndicator(
                    controller,
                    allowScrubbing: true,
                    colors: VideoProgressColors(
                      playedColor: Colors.redAccent,
                      bufferedColor: Colors.grey,
                      backgroundColor: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
