import 'package:flutter/foundation.dart';
import 'package:krishidost/screens/shop/product_list_screen/provider/product_list_provider.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../models/product.dart';
import '../../../../utility/constants.dart';

class FavoriteProvider extends ChangeNotifier {
  final ProductListProvider _productListProvider;
  final box = GetStorage();

  List<Product> favoriteProducts = []; // Use plural for clarity
  FavoriteProvider(this._productListProvider);


  void updateToFavoriteList(String productId) {
    List<dynamic> favoriteList = box.read(FAVORITE_PRODUCT_BOX) ?? [];

    if (favoriteList.contains(productId)) {
      favoriteList.remove(productId);
    } else {
      favoriteList.add(productId);
    }

    box.write(FAVORITE_PRODUCT_BOX, favoriteList); // Store as a List

    loadFavoriteProducts(); // Refresh the list of favorite products
    notifyListeners();
  }

  bool checkIsItemFavorite(String productId) {
    List<dynamic> favoriteList = box.read(FAVORITE_PRODUCT_BOX) ?? [];
    return favoriteList.contains(productId); // Direct lookup in the Set
  }

  void loadFavoriteProducts() {
    List<dynamic>? favoriteListIds = box.read(FAVORITE_PRODUCT_BOX) ?? [];

    // Efficiently filter products using a Set lookup and firstWhereOrNull
    favoriteProducts = _productListProvider.allProducts.where((product) {
      return favoriteListIds.contains(product.sId);
    }).toList();

    notifyListeners();
  }

  void clearFavoriteList() {
    if (kDebugMode) {
      print("hello");
    }
    box.remove(FAVORITE_PRODUCT_BOX);
    favoriteProducts.clear();
    notifyListeners();
  }
}
