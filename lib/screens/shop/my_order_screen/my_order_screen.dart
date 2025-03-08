import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishidost/utility/extensions.dart';
import 'package:krishidost/utility/utility_extension.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../core/data/data_provider.dart';
import '../../../widget/order_tile.dart';
import '../../tracking_screen/tracking_screen.dart';
import '../product_list_screen/provider/product_list_provider.dart';


class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return  Consumer<ProductListProvider>(
      builder: (context, provider, child) {
        if(context.productListProvider.orders.isEmpty) {
          return Center(child: Lottie.asset("assets/animation/empty_order_animation.json",repeat: false),);
        }
        return RefreshIndicator(
          onRefresh: (){
            return context.productListProvider.getAllOrders();
          },
          child: ListView.builder(
            itemCount: context.productListProvider.orders.length,
            itemBuilder: (context, index) {
              final order = context.productListProvider.orders[index];
              return OrderTile(
                paymentMethod: order.paymentMethod ?? '',
                items: '${(order.items.safeElementAt(0)?.productName ?? '')} & ${order.items!.length - 1} Items'  ,
                date: order.orderDate ?? '',
                status: order.orderStatus ?? 'pending',
                onTap: (){
                  if(order.orderStatus == 'shipped'){
                    Get.to(TrackingScreen(url: order.trackingUrl ?? ''));
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}
