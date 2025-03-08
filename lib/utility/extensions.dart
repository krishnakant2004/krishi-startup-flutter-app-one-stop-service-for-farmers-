import 'package:flutter/cupertino.dart';
import 'package:krishidost/screens/login_screen/provider/user_provider.dart';
import 'package:krishidost/screens/profile_screen/my_profile_screen/provider/profile_provider.dart';
import 'package:krishidost/screens/shop/product_details_screen/provider/product_detail_provider.dart';
import 'package:krishidost/screens/shop/product_favorite_screen/provider/favorite_provider.dart';
import 'package:krishidost/screens/shop/product_list_screen/provider/product_list_provider.dart';
// import 'package:krishidost/screens/shop/my_cart_screen/cart_screen_provider/cart_screen_provider.dart';
import 'package:provider/provider.dart';
import '../core/data/data_provider.dart';
import '../screens/shop/product_by_category_screen/provider/product_by_category_provider.dart';
import '../screens/shop/product_cart_screen/provider/cart_provider.dart';


extension Providers on BuildContext {
  DataProvider get dataProvider => Provider.of<DataProvider>(this, listen: false);
  UserProvider get userProvider => Provider.of<UserProvider>(this,listen: false);
  CartProvider get cartProvider => Provider.of<CartProvider>(this,listen:false);
  FavoriteProvider get favoriteProvider => Provider.of<FavoriteProvider>(this,listen: false);
  ProductByCategoryProvider get productByCategoryProvider => Provider.of<ProductByCategoryProvider>(this,listen: false);
  ProductDetailProvider get productDetailProvider => Provider.of<ProductDetailProvider>(this,listen: false);
  ProductListProvider get productListProvider => Provider.of<ProductListProvider>(this,listen: false);
  ProfileProvider get profileProvider => Provider.of<ProfileProvider>(this,listen: false);
}






