// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:krishidost/detectionPages/preservative_result.dart';
// import 'package:http/http.dart' as http;
//
// class CropPredictionForm extends StatefulWidget {
//   const CropPredictionForm({super.key});
//
//   @override
//   State<CropPredictionForm> createState() => _CropPredictionFormState();
// }
//
// class _CropPredictionFormState extends State<CropPredictionForm> {
//   final _formKey = GlobalKey<FormState>();
//
//   String? nitrogen,
//       phosphorus,
//       potassium,
//       temperature,
//       humidity,
//       pHValue,
//       rainfall,
//       state,
//       city;
//
//   Future<void> sendData(Map<String, String> data) async {
//     final url = Uri.parse('http://192.168.137.127:5050/predict');
//     try {
//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: json.encode(data), // Encoding data as JSON
//       );
//
//       if (response.statusCode == 200) {
//         // Successfully got a prediction
//         final result = jsonDecode(response.body)['prediction'];
//         print("Prediction: $result");
//
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: const Text(
//                   'this recommanded crop is the crop based on your input:',style: TextStyle(fontSize: 18),),
//               content: Text(result,style:const  TextStyle(color: Colors.green),),
//               actions: <Widget>[
//               SvgPicture.asset("assets/confirm-svgrepo-com.svg",width: 30,height: 30,),
//                 const SizedBox(width: 10,),
//                 ElevatedButton.icon(
//                   label: const Text("OK"),
//                   onPressed: () {
//                     // Perform the action
//                     Navigator.of(context).pop(); // Close the dialog
//                   },
//
//                 ),
//               ],
//             );
//           },
//         );
//       } else {
//         print("Error ${response.statusCode}: ${response.body}");
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: const Text(
//                   'this recommanded crop is the crop based on your input:',style: TextStyle(fontSize: 18),),
//               content: const Text("somthing went rong",style: TextStyle(color: Colors.red),),
//               actions: <Widget>[
//                 SvgPicture.asset("assets/cancel-svgrepo-com.svg",width: 30,height: 30,),
//                 const SizedBox(width: 10,),
//                 ElevatedButton.icon(
//                   label: const Text("OK"),
//                   onPressed: () {
//                     // Perform the action
//                     Navigator.of(context).pop(); // Close the dialog
//                   },
//
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     } catch (e) {
//       print("Something went wrong: $e");
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text(
//                 'this recommanded crop is the crop based on your input:',style: TextStyle(fontSize: 18),),
//             content: const Text("somthing went rong",style: TextStyle(color: Colors.red),),
//             actions: <Widget>[
//               SvgPicture.asset("assets/cancel-svgrepo-com.svg",width: 30,height: 30,),
//               const SizedBox(width: 10,),
//               ElevatedButton.icon(
//                 label: const Text("OK"),
//                 onPressed: () {
//                   // Perform the action
//                   Navigator.of(context).pop(); // Close the dialog
//                 },
//
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Crop Prediction Form'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const Text(
//                   "Crop Recommendation System 🌱",
//                   style: TextStyle(
//                     fontSize: 24,
//                   ),
//                 ),
//                 TextFormField(
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(
//                     labelText: 'Nitrogen:',
//                   ),
//                   validator: (value) {
//                     if (value == null ||
//                         value.isEmpty ||
//                         int.tryParse(value) == null) {
//                       return 'Please enter  nitrogen value in integer';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     nitrogen = value.trim();
//                   },
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(
//                     labelText: 'Phosphorus:',
//                   ),
//                   validator: (value) {
//                     if (value == null ||
//                         value.isEmpty ||
//                         int.tryParse(value) == null) {
//                       return 'Please enter phosphorus value  in integer';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     phosphorus = value.trim();
//                   },
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(
//                     labelText: 'Potassium:',
//                   ),
//                   validator: (value) {
//                     if (value == null ||
//                         value.isEmpty ||
//                         int.tryParse(value) == null) {
//                       return 'Please enter potassium value  in integer';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     potassium = value.trim();
//                   },
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(
//                     labelText: 'Temperature (°C):',
//                   ),
//                   validator: (value) {
//                     if (value == null ||
//                         value.isEmpty ||
//                         int.tryParse(value) == null) {
//                       return 'Please enter temperature value  in integer';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     temperature = value.trim();
//                   },
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(
//                     labelText: 'Humidity (%):',
//                   ),
//                   validator: (value) {
//                     if (value == null ||
//                         value.isEmpty ||
//                         int.tryParse(value) == null) {
//                       return 'Please enter humidity value  in integer';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     humidity = value.trim();
//                   },
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(
//                     labelText: 'pH Value:',
//                   ),
//                   validator: (value) {
//                     if (value == null ||
//                         value.isEmpty ||
//                         int.tryParse(value) == null) {
//                       return 'Please enter pH value  in integer';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     pHValue = value.trim();
//                   },
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(
//                     labelText: 'Rainfall (mm):',
//                   ),
//                   validator: (value) {
//                     if (value == null ||
//                         value.isEmpty ||
//                         int.tryParse(value) == null) {
//                       return 'Please enter rainfall value in integer';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     rainfall = value.trim();
//                   },
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   keyboardType: TextInputType.text,
//                   decoration: const InputDecoration(
//                     labelText: 'state:',
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'in text alphabet';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     state = value.trim();
//                   },
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   keyboardType: TextInputType.text,
//                   decoration: const InputDecoration(
//                     labelText: 'city:',
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'enter valide city';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     city = value.trim();
//                   },
//                 ),
//                 const SizedBox(height: 16.0),
//                 ElevatedButton(
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       // Navigator.push(context, MaterialPageRoute(builder: (context)=>PreservativeResult(result: ,),),);
//                       await sendData({
//                         'Nitrogen': nitrogen!,
//                         'Phosphorus': phosphorus!,
//                         'Potassium': potassium!,
//                         'Temperature': temperature!,
//                         'Humidity': humidity!,
//                         'pH': pHValue!,
//                         'Rainfall': rainfall!,
//                         'City': city!,
//                         'State': state!,
//                       });
//                     }
//                   },
//                   child: const Text('Predict Crop'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class CropPredictionForm extends StatefulWidget {
  const CropPredictionForm({super.key});

  @override
  State<CropPredictionForm> createState() => _CropPredictionFormState();
}

class _CropPredictionFormState extends State<CropPredictionForm> {
  final _formKey = GlobalKey<FormState>();

  String? nitrogen, phosphorus, potassium, temperature, humidity, pHValue, rainfall, state, city;

  Future<void> sendData(Map<String, String> data) async {
    print("hello");
    final url = Uri.parse('http://127.0.0.1:5000/predict');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body)['prediction'];
        print("Prediction: $result");

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Recommended Crop:', style: TextStyle(fontSize: 18)),
              content: Text(result, style: const TextStyle(color: Colors.green)),
              actions: <Widget>[
                SvgPicture.asset("assets/confirm-svgrepo-com.svg", width: 30, height: 30),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  label: const Text("OK"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
        );
      } else {
        showErrorDialog("Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      showErrorDialog("Something went wrong: $e");
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error', style: TextStyle(fontSize: 18)),
          content: Text(message, style: const TextStyle(color: Colors.red)),
          actions: <Widget>[
            SvgPicture.asset("assets/cancel-svgrepo-com.svg", width: 30, height: 30),
            const SizedBox(width: 10),
            ElevatedButton.icon(
              label: const Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  InputDecoration buildInputDecoration(String label, String hintText) {
    return InputDecoration(
      labelText: label,
      hintText: hintText,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30),),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green.withOpacity(0.7),width: 2),
        borderRadius: BorderRadius.all(Radius.circular(30),),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green),
        borderRadius: BorderRadius.all(Radius.circular(30),),
      ),
  hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.normal)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crop Prediction Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Crop Recommendation System 🌱",
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
                buildTextFormField('Nitrogen', 'Enter nitrogen value', TextInputType.number, (value) {
                  nitrogen = value;
                }),
                const SizedBox(height: 20),
                buildTextFormField('Phosphorus', 'Enter phosphorus value', TextInputType.number, (value) {
                  phosphorus = value;
                }),
                const SizedBox(height: 20),
                buildTextFormField('Potassium', 'Enter potassium value', TextInputType.number, (value) {
                  potassium = value;
                }),
                const SizedBox(height: 20),
                buildTextFormField('Temperature (°C)', 'Enter temperature in °C', TextInputType.number, (value) {
                  temperature = value;
                }),
                const SizedBox(height: 20),
                buildTextFormField('Humidity (%)', 'Enter humidity in %', TextInputType.number, (value) {
                  humidity = value;
                }),
                const SizedBox(height: 20),
                buildTextFormField('pH Value', 'Enter pH value', TextInputType.number, (value) {
                  pHValue = value;
                }),
                const SizedBox(height: 20),
                buildTextFormField('Rainfall (mm)', 'Enter rainfall in mm', TextInputType.number, (value) {
                  rainfall = value;
                }),
                const SizedBox(height: 20),
                buildTextFormField('State', 'Enter your state', TextInputType.text, (value) {
                  state = value;
                }),
                const SizedBox(height: 20),
                buildTextFormField('City', 'Enter your city', TextInputType.text, (value) {
                  city = value;
                }),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await sendData({
                        'Nitrogen': nitrogen!,
                        'Phosphorus': phosphorus!,
                        'Potassium': potassium!,
                        'Temperature': temperature!,
                        'Humidity': humidity!,
                        'pH': pHValue!,
                        'Rainfall': rainfall!,
                        'City': city!,
                        'State': state!,
                      });
                    }
                  },
                  child: const Text('Predict Crop'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField(String label, String hintText, TextInputType inputType, Function(String) onChanged) {
    return TextFormField(
      keyboardType: inputType,
      decoration: buildInputDecoration(label, hintText),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a valid $label';
        }
        return null;
      },
      onChanged: (value) => onChanged(value.trim()),
    );
  }
}

