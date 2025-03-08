import 'package:flutter/material.dart';

import '../../shop/my_order_screen/my_order_screen.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("My Orders",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
      ),
      body: const MyOrderScreen(),
    );
  }
}
