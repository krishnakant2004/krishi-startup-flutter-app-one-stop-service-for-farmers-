// import 'package:flutter/material.dart';
//
// class Pridictdiseseresult extends StatelessWidget {
//   const Pridictdiseseresult({super.key,required this.result,required this.cure});
//
//   final String result;
//   final String cure;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title:const Text("disese prediction"),),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(result),
//         const SizedBox(height:10),
//           Text(cure,textAlign: TextAlign.center,)
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';

class Pridictdiseseresult extends StatelessWidget {
  final String diseaseName;
  final String cureDescription;
  final File? image;
  const Pridictdiseseresult({
    Key? key,
    required this.diseaseName,
    required this.cureDescription,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disease Prediction Result'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12),),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                  image: FileImage(
                    File(image!.path),
                  ),
                )),
              ),
              Text(
                diseaseName,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                cureDescription,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
