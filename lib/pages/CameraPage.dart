import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../utils/Colors.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;
  bool _isCameraInitialized = false;
  XFile? _capturedImage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> sendImage() async {
    if (_capturedImage == null) {
      print('No image to send.');
      return;
    }

    final url = Uri.parse('http://192.168.64.54:8004/upload');

    try {
      var request = http.MultipartRequest('POST', url);
      request.files.add(
          await http.MultipartFile.fromPath('image', _capturedImage!.path));
      var response = await request.send();

      if (response.statusCode == 200) {
        print('Image uploaded successfully.');
      } else {
        print('Image upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        controller = CameraController(
          cameras[0],
          ResolutionPreset.max,
        );

        await controller.initialize();

        if (!mounted) return;

        setState(() {
          _isCameraInitialized = true;
        });
      } else {
        print('No cameras found');
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> _takePicture() async {
    if (!controller.value.isInitialized) {
      print('Error: Camera is not initialized.');
      return;
    }

    try {
      final image = await controller.takePicture();
      setState(() {
        _capturedImage = image;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Picture saved to ${image.path}'),
          duration: const Duration(seconds: 2),
        ),
      );

      // Send the image to the server
      await sendImage();
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      // appBar: AppBar(title: const Text('Camera Page')),
      body: Column(
        children: [
          if (_capturedImage != null)
            Expanded(
              child: Image.file(
                File(_capturedImage!.path),
                fit: BoxFit.cover,
              ),
            )
          else
            Expanded(
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: CameraPreview(controller),
              ),
            ),
          // const SizedBox(height: 100),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          _takePicture();
        },
        icon: const Icon(Icons.camera, color: Colors.white),
        label: const Text('Ambil Gambar',
            style: TextStyle(color: CustomColor.white)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
