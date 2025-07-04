import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/cart.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:krishidost/core/data/data_provider.dart';
import 'package:krishidost/screens/login_screen/login_screen.dart';
import 'package:krishidost/screens/login_screen/provider/user_provider.dart';
import 'package:krishidost/screens/profile_screen/my_profile_screen/provider/profile_provider.dart';
import 'package:krishidost/screens/shop/product_by_category_screen/provider/product_by_category_provider.dart';
import 'package:krishidost/screens/shop/product_cart_screen/provider/cart_provider.dart';
import 'package:krishidost/screens/shop/product_details_screen/provider/product_detail_provider.dart';
import 'package:krishidost/screens/shop/product_favorite_screen/provider/favorite_provider.dart';
import 'package:krishidost/screens/shop/product_list_screen/provider/product_list_provider.dart';
import 'package:krishidost/utility/extensions.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'models/user.dart';
import 'theme.dart';
import 'screens/UserScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  var cart = FlutterCart();
  OneSignal.initialize("93572ec3-f818-4cb5-a5f5-a5ba9758922a");
  await cart.initializeCart(isPersistenceSupportEnabled: false);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => DataProvider(),
      ),
      ChangeNotifierProvider(create: (context) => ProductListProvider()),
      ChangeNotifierProvider(
        create: (context) => UserProvider(context.dataProvider),
      ),
      ChangeNotifierProvider(
        create: (context) => ProfileProvider(context.dataProvider),
      ),
      ChangeNotifierProvider(
        create: (context) => ProductByCategoryProvider(context.productListProvider),
      ),
      ChangeNotifierProvider(
        create: (context) => ProductDetailProvider(context.productListProvider),
      ),
      ChangeNotifierProvider(
        create: (context) => CartProvider(context.userProvider),
      ),
      ChangeNotifierProvider(
          create: (context) => FavoriteProvider(context.productListProvider)),

    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    User? loginUser = context.userProvider.getLoginUsr();
    return GetMaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        },
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      home: loginUser?.sId == null ? const LoginScreen() : const UserScreen(),
    );
  }
}
