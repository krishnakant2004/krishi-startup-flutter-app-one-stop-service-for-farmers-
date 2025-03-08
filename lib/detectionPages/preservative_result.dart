import 'package:flutter/material.dart';

class PreservativeResult extends StatelessWidget {
  const PreservativeResult({super.key,required this.result});

  final String result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text("disese prediction"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(result),
        ],
      ),
    );
  }
}
