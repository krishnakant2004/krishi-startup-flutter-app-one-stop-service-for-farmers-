import 'package:flutter/foundation.dart' hide Category;
import 'package:get/get.dart';
import 'dart:async';
import '../../../../models/api_response.dart';
import '../../../../models/brand.dart';
import '../../../../models/category.dart';
import '../../../../models/order.dart';
import '../../../../models/poster.dart';
import '../../../../models/product.dart';
import '../../../../models/sub_category.dart';
import '../../../../services/http_services.dart';
import '../../../../utility/snack_bar_helper.dart';

class ProductListProvider extends ChangeNotifier {
  HttpService service = HttpService();
  bool isFirstLoad = true;
  bool _isFetching = true;
  bool get isFetching => _isFetching;

  List<Category> _allCategories = [];
  List<Category> _filteredCategories = [];
  List<Category> get categories => _filteredCategories;

  List<SubCategory> _allSubCategories = [];
  List<SubCategory> _filteredSubCategories = [];

  List<SubCategory> get subCategories => _filteredSubCategories;

  List<Brand> _allBrands = [];
  List<Brand> _filteredBrands = [];
  List<Brand> get brands => _filteredBrands;

  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  List<Product> get products => _filteredProducts;
  List<Product> get allProducts => _allProducts;

  List<Poster> _allPosters = [];
  List<Poster> _filteredPosters = [];
  List<Poster> get posters => _filteredPosters;

  List<Order> _allOrders = [];
  List<Order> _filteredOrders = [];
  List<Order> get orders => _filteredOrders;

  Future fetchData() async {
    print('Starting fetchData()');
    _isFetching = true;
    notifyListeners();
    try {
      await Future.wait([
        getAllProducts(showSnack: false),
        getAllCategory(showSnack: false),
        getAllSubCategory(showSnack: false),
        getAllBrands(showSnack: false)
      ]);
    } catch (e) {
      if (kDebugMode) {
        print('Error in fetchData: $e');
      }
      SnackBarHelper.showErrorSnackBar("$e");
    } finally {
      _isFetching = false;
      if (kDebugMode) {
        print(
          'isFetching set to false, products count: ${_filteredProducts.length}');
      }
      notifyListeners();
    }
  }

  Future<List<Category>> getAllCategory({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'categories');
      if (kDebugMode) {
        print(response.statusText);
      }
      if (response.isOk) {
        ApiResponse<List<Category>> apiResponse =
            ApiResponse<List<Category>>.fromJson(
          response.body,
          (json) =>
              (json as List).map((item) => Category.fromJson(item)).toList(),
        ); // ApiResponse.fromJson
        _allCategories = apiResponse.data ?? [];
        _filteredCategories =
            List.from(_allCategories); // Initialize filtered list with all data
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (showSnack) {
        SnackBarHelper.showErrorSnackBar(e.toString());
      }
      rethrow;
    }
    return _filteredCategories;
  }

  void fitterCategories(String keyword) {
    if (keyword.isEmpty) {
      _filteredCategories = List.from(_allCategories);
    } else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredCategories = _allCategories.where((category) {
        return (category.name ?? '').toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  Future<List<SubCategory>> getAllSubCategory({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'subCategories');
      if (response.isOk) {
        ApiResponse<List<SubCategory>> apiResponse = ApiResponse.fromJson(
            response.body,
            (json) => (json as List)
                .map((item) => SubCategory.fromJson(item))
                .toList());
        if (apiResponse.success == true) {
          _allSubCategories = apiResponse.data ?? [];
          _filteredSubCategories = List.from(_allSubCategories);
          notifyListeners();
          if (showSnack) {
            SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          }
        } else {
          if (showSnack) {
            SnackBarHelper.showErrorSnackBar('${apiResponse.message}');
          }
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Failed ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      print(e);
      if (showSnack) if (showSnack) {
        SnackBarHelper.showErrorSnackBar(e.toString());
      }
      rethrow;
    }
    return _filteredSubCategories;
  }

  void filterSubCategories(String keyword) {
    if (keyword.isEmpty) {
      _filteredSubCategories = List.from(_allSubCategories);
    } else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredSubCategories = _allSubCategories.where((subCategory) {
        final subCategoryContainsKeyword =
            (subCategory.name ?? '').toLowerCase().contains(lowerKeyword);
        final categoryContainsKeyword = subCategory.categoryId?.name
                ?.toLowerCase()
                .contains(lowerKeyword) ??
            false;
        return subCategoryContainsKeyword || categoryContainsKeyword;
      }).toList();
    }
    notifyListeners();
  }

  Future<List<Brand>> getAllBrands({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'brands');
      if (response.isOk) {
        ApiResponse<List<Brand>> apiResponse = ApiResponse.fromJson(
            response.body,
            (json) =>
                (json as List).map((item) => Brand.fromJson(item)).toList());
        if (apiResponse.success == true) {
          _allBrands = apiResponse.data ?? [];
          _filteredBrands = List.from(_allBrands);
          notifyListeners();
          if (showSnack) {
            SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          }
        } else {
          if (showSnack) {
            SnackBarHelper.showErrorSnackBar(
                'Failed to add Brand ${apiResponse.message}');
          }
        }
      } else {
        if (showSnack) {
          SnackBarHelper.showErrorSnackBar(
              'Failed ${response.body?['message'] ?? response.statusText}');
        }
      }
    } catch (e) {
      print(e);
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredBrands;
  }

  void filterAllBrands(String keyword) {
    if (keyword.isEmpty) {
      _filteredBrands = List.from(_allBrands);
    } else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredBrands = _allBrands.where((brand) {
        final brandContainsKeyword =
            (brand.name ?? '').toLowerCase().contains(lowerKeyword);
        final subCategoryContainsKeyword =
            brand.subcategoryId?.name?.toLowerCase().contains(lowerKeyword) ??
                false;
        return brandContainsKeyword || subCategoryContainsKeyword;
      }).toList();
    }
    notifyListeners();
  }

  Future<void> getAllProducts({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'products');
      print(response.body);
      if (response.isOk) {
        ApiResponse<List<Product>> apiResponse = ApiResponse.fromJson(
            response.body,
            (json) =>
                (json as List).map((item) => Product.fromJson(item)).toList());
        if (apiResponse.success == true) {
          _allProducts = apiResponse.data ?? [];
          _filteredProducts =
              List.from(_allProducts); // Initialize filtered products
          notifyListeners();
          if (showSnack) {
            SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          }
        } else {
          if (showSnack) {
            SnackBarHelper.showErrorSnackBar(
                'Failed to fetch product ${apiResponse.message}');
          }
        }
      } else {
        if (showSnack) {
          SnackBarHelper.showErrorSnackBar(
              'Failed ${response.body?['message'] ?? response.statusText}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
    }
  }

  void filterProducts(String keyword) {
    final lowerKeyword = keyword.toLowerCase();
    _filteredProducts = keyword.isEmpty
        ? List.from(_allProducts)
        : _allProducts
            .where((product) =>
                (product.name?.toLowerCase().contains(lowerKeyword) ?? false) ||
                (product.proCategoryId?.name
                        ?.toLowerCase()
                        .contains(lowerKeyword) ??
                    false) ||
                (product.proSubCategoryId?.name
                        ?.toLowerCase()
                        .contains(lowerKeyword) ??
                    false))
            .toList();
    notifyListeners();
  }

  Future<void> filterProductServerSide({required String val, showSnack = false}) async {
    try {
      if (kDebugMode) {
        print(val);
      }
      if (val.isEmpty) {
        getAllProducts();
        return;
      }

      Response response = await service.filterProduct(
          endpointUrl: 'products/filter/name?=$val', key: val);
      if (response.isOk) {
        _isFetching = true;
        notifyListeners();
        ApiResponse<List<Product>> apiResponse = ApiResponse.fromJson(
            response.body,
            (json) =>
                (json as List).map((item) => Product.fromJson(item)).toList());
        if (apiResponse.success == true) {
          _allProducts = apiResponse.data ?? [];
          notifyListeners();
          if (showSnack) {
            SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          }
        } else {
          if (showSnack) {
            SnackBarHelper.showErrorSnackBar(
                'Failed to filter product ${apiResponse.message}');
          }
        }
      } else {
        if (showSnack) {
          SnackBarHelper.showErrorSnackBar('Failed to filter product');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
    }
    _isFetching = false;
    notifyListeners();
  }

  //TODO: should complete getAllPosters
  

  //TODO: should complete getAllOrderByUser

  Future<List<Order>> getAllOrders({bool showSnack = false}) async {
    try{
      Response response = await service.getItems(endpointUrl: 'orders');
      if(response.isOk){
        ApiResponse<List<Order>> apiResponse = ApiResponse.fromJson(response.body, (json)=>(json as List).map((item)=>Order.fromJson(item)).toList());
        print(apiResponse.message);
        _allOrders = apiResponse.data ?? [];
        _filteredOrders = List.from(_allOrders);
        notifyListeners();
        if(showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    }catch(e){
      if(showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredOrders;
  }

  filterOrders(String keyword){
    if(keyword.isEmpty){
      _filteredOrders = List.from(_allOrders);
    } else{
      final lowerKeyword = keyword.toLowerCase();
      _filteredOrders = _allOrders.where((order){
        return (order.userID?.name ?? '').toLowerCase().contains(lowerKeyword) || (order.orderStatus ?? '').toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  double calculateDiscountPercentage(num originalPrice, num? discountedPrice) {
    if (originalPrice <= 0) {
      throw ArgumentError('Original price must be greater than zero.');
    }

    //? Ensure discountedPrice is not null; if it is, default to the original price (no discount)
    num finalDiscountedPrice = discountedPrice ?? originalPrice;

    if (finalDiscountedPrice > originalPrice) {
      return originalPrice.toDouble();
    }

    double discount =
        ((originalPrice - finalDiscountedPrice) / originalPrice) * 100;

    //? Return the discount percentage as an integer
    return discount;
  }
}
