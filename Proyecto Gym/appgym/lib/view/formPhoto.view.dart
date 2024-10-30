import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class FormPhotoView extends StatefulWidget {
  const FormPhotoView({super.key});

  @override
  _FormPhotoViewState createState() => _FormPhotoViewState();
}

class _FormPhotoViewState extends State<FormPhotoView> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  XFile? _imageFile;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Solicita el permiso de cámara en tiempo de ejecución
    var status = await Permission.camera.request();
    if (status != PermissionStatus.granted) {
      setState(() {
        _cameraController = null; // Indica que la cámara no está disponible
      });
      return;
    }

    try {
      // Obtener las cámaras disponibles en el dispositivo
      _cameras = await availableCameras();
      _cameraController = CameraController(_cameras![0], ResolutionPreset.high);

      // Configurar el controlador de la cámara y actualizar el estado
      await _cameraController?.initialize();
      if (!mounted) return;
      setState(() {});
    } catch (e) {
      print("Error al inicializar la cámara: $e");
      setState(() {
        _cameraController = null;
      });
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }
    try {
      // Tomar la foto y guardar la referencia en _imageFile
      _imageFile = await _cameraController!.takePicture();
      setState(() {});
    } catch (e) {
      print("Error al capturar la imagen: $e");
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Captura de Foto"),
      ),
      body: Column(
        children: [
          if (_cameraController != null &&
              _cameraController!.value.isInitialized)
            // Vista previa de la cámara
            AspectRatio(
              aspectRatio: _cameraController!.value.aspectRatio,
              child: CameraPreview(_cameraController!),
            )
          else if (_cameraController == null)
            Center(
              child: Text("Error al acceder a la cámara."),
            )
          else
            Center(child: CircularProgressIndicator()),

          // Mostrar la imagen capturada
          if (_imageFile != null)
            Image.file(File(_imageFile!.path), height: 200),

          SizedBox(height: 16),

          // Botón para tomar la foto
          ElevatedButton(
            onPressed: _takePicture,
            child: Text("Tomar Foto"),
          ),
        ],
      ),
    );
  }
}
