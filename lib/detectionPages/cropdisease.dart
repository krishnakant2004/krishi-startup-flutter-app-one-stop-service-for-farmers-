import 'dart:convert';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:krishidost/detectionPages/pridictdisese_result.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class PredictPage extends StatefulWidget {
  const PredictPage({super.key});

  @override
  State<PredictPage> createState() => _PredictPageState();
}

class _PredictPageState extends State<PredictPage> {
  File? _image; //app
  String? _pickedImageUrl; //web file access
  String? cropName;
  bool isPridicting=false;

  final TextEditingController controller_crop = TextEditingController();

  @override
  void initState() {
    super.initState();
  }


  Future<void> _requestPermissions() async {
    if (await Permission.camera.isGranted &&
        await Permission.storage.isGranted) {
      // Permissions are granted
    } else {
      // Request permissions
      await [
        Permission.camera,
        Permission.storage,
      ].request();
    }
  }


  // Function to pick an image for both mobile and web
  Future<void> _pickImage(ImageSource imageSource) async {
      _requestPermissions();
      // Mobile: use ImagePicker to select the image
      final ImagePicker picker = ImagePicker();
      XFile? pickedFile = await picker.pickImage(source: imageSource);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);// Set mobile image
        });
      }
  }

  predictImage() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Image not picked!"),
        ),
      );
      return;
    }

    const String apiUrl = "http://172.16.76.85:5000/predict";//172.16.108.16

    try {
      // Create form data for the request
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      // Add the image file to the request
      request.files.add(await http.MultipartFile.fromPath(
        'image', // Field name used by the server to receive the image
        _image!.path,
      ));

      // Send the request and wait for the response
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final prediction = body['prediction'];
        final cure=body['cure'];
        print(body);
        if (context.mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Pridictdiseseresult(
                diseaseName: prediction,
                cureDescription:cure ,
                image: _image,
              ),
            ),
          );
        }
      } else {
        print(response.statusCode);
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to get prediction")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error: Failed to get prediction"),),
      );
    }
  }


  void _eraseImage() {
    setState(() {
      _image = null;
      _pickedImageUrl=null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("predict"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: controller_crop,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  //label: Text("crop name"),
                  labelText: "crop name:",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: (_image  == null&& _pickedImageUrl == null)
                          ? const AssetImage("assets/images/dragImage.png")
                          :(kIsWeb)?NetworkImage(_pickedImageUrl!): FileImage(File(_image!.path),),
                    ),
                  ),
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.delete_forever_rounded,
                        color: Colors.white),
                    onPressed: _eraseImage,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: ()=>_pickImage(ImageSource.gallery),
                child: const Text('Pick Image from Gallery'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: ()=>_pickImage(ImageSource.camera),
                child: const Text('Pick Image from Camera'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isPridicting = true;
                  });
                  await predictImage();
                  setState(() {
                    isPridicting = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent.shade200,
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isPridicting
                    ? const CircularProgressIndicator(): const Text("Prdict"),

              ),
            ],
          ),
        ),
      ),
    );
  }
}

