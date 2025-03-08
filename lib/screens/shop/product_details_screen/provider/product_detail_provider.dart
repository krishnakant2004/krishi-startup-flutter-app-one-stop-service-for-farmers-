import 'package:flutter/cupertino.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:krishidost/screens/shop/product_list_screen/provider/product_list_provider.dart';
import 'package:krishidost/utility/snack_bar_helper.dart';
import 'package:krishidost/utility/utility_extension.dart';
import '../../../../models/product.dart';



class ProductDetailProvider extends ChangeNotifier {
  final ProductListProvider _productListProvider;
  String? selectedVariant;
  var flutterCart = FlutterCart();

  ProductDetailProvider(this._productListProvider);


  void addToCart(Product product){
    if(product.proVariantId!.isNotEmpty && selectedVariant == null){
      SnackBarHelper.showErrorSnackBar('please select a variant');
      return;
    }
    double? price = product.offerPrice != product.price ? product.offerPrice : product.price;
    flutterCart.addToCart(cartModel: CartModel(
        productId: '${product.sId}',
        productName: '${product.name}',
      productImages: ['${product.images.safeElementAt(0)?.url}'],
      variants: [ProductVariant(price: price ?? 0,color:  selectedVariant)],
        productDetails: '${product.description}',
    ));
    selectedVariant= null;
    SnackBarHelper.showSuccessSnackBar('Item added');
    notifyListeners();
  }



  void updateUI() {
    notifyListeners();
  }
}
