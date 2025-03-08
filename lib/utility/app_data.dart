import 'package:flutter/material.dart';

class AppData {
  const AppData._();

  //size
  static const int defaultSize = 18;

  //style
  static const TextStyle productNamestyle =
      TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 15);
  static const TextStyle bold16sizeTextStyle = TextStyle(
      fontWeight: FontWeight.bold, color: AppData.darkGreen, fontSize: 16);

  //colors
  static const darkOrange = Color(0xFFEC6813);
  static const lightOrange = Color(0xFFf8b89a);

  static const darkGrey = Color(0xFFA6A3A0);
  static const lightGrey = Color(0xFFE5E6E8);
  static const darkGreen = Color(0xFF006400);
  static const lightGreen = Color(0xFF4fff4f);
  static const ExtralightGreen = Color(0xFFb1feb1);

  static List<Color> randomColors = [
    const Color(0xFFFCE4EC),
    const Color(0xFFF3E5F5),
    const Color(0xFFEDE7F6),
    const Color(0xFFE3F2FD),
    const Color(0xFFE0F2F1),
    const Color(0xFFF1F8E9),
    const Color(0xFFFFF8E1),
    const Color(0xFFECEFF1),
  ];

  static List<Color> randomPosterBgColors = [
    const Color(0xFFE70D56),
    const Color(0xFF9006A4),
    const Color(0xFF137C0B),
    const Color(0xFF0F2EDE),
    const Color(0xFFECBE23),
    const Color(0xFFA60FF1),
    const Color(0xFF0AE5CF),
    const Color(0xFFE518D1),
  ];

  static const List<LinearGradient> randomCategoryGradient = [
    LinearGradient(
      colors: [Colors.blue, Colors.cyan],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: [Colors.pinkAccent, Colors.deepPurpleAccent],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    LinearGradient(
      colors: [Colors.orangeAccent, Colors.yellow],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    LinearGradient(
      colors: [Colors.green, Colors.lightGreenAccent],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    )
  ];

  static List<String> innerStyleImages = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1Dw7-4lVfRq74_YEiPEt4e-bQ0_6UA2y73Q&s",
    "https://i0.wp.com/picjumbo.com/wp-content/uploads/amazing-stone-path-in-forest-free-image.jpg?w=600&quality=80",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoFRQjM-wM_nXMA03AGDXgJK3VeX7vtD3ctA&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXJA32WU4rBpx7maglqeEtt3ot1tPIRWptxA&s",
    "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg",
  ];
}
