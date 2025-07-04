import 'package:krishidost/screens/shop/product_list_screen/provider/product_list_provider.dart';

import '../../../../core/data/data_provider.dart';
import '../../../../models/brand.dart';
import '../../../../models/category.dart';
import '../../../../models/product.dart';
import '../../../../models/sub_category.dart';
import 'package:flutter/cupertino.dart';

class ProductByCategoryProvider extends ChangeNotifier {
  final ProductListProvider _productListProvider;
  String sortByPriceDropDownValue = "Sort By Price";
  Category? mySelectedCategory;
  List<SubCategory> mySelectedSubCategory = [SubCategory(name: 'All')];
  List<SubCategory> subCategories = [];
  List<bool> isSubCategorySelected = [];
  List<Brand> brands = [];
  List<Brand> selectedBrands = [];
  List<Product> filteredProduct = [];

  ProductByCategoryProvider(this._productListProvider);

  filterInitialProductAndSubCategory(Category selectedCategory) {
    mySelectedCategory = selectedCategory;
    subCategories = _productListProvider.subCategories
        .where((element) => element.categoryId?.sId == selectedCategory.sId)
        .toList();
    subCategories.insert(0, SubCategory(name: 'All'));
    isSubCategorySelected = List<bool>.generate(
      subCategories.length,
      (index) => false,
    );
    isSubCategorySelected[0] = true;
    filteredProduct = _productListProvider.products
        .where(
            (element) => element.proCategoryId?.name == selectedCategory.name)
        .toList();
    notifyListeners();
  }

  filterProductBySubCategory(int index) {
    if (isSubCategorySelected[index] == true) {
      mySelectedSubCategory.remove(subCategories[index]);
    } else {
      mySelectedSubCategory.add(subCategories[index]);
    }
    isSubCategorySelected[index] = !isSubCategorySelected[index];

    // mySelectedSubCategory = subCategory;
    if (subCategories[index].name?.toLowerCase() == 'all' ||
        mySelectedSubCategory.length <= 1) {
      filteredProduct = _productListProvider.products
          .where((element) =>
              element.proCategoryId?.name == mySelectedCategory?.name)
          .toList();
      brands = [];
      isSubCategorySelected = List<bool>.generate(
        subCategories.length,
        (index) => false,
      );
      isSubCategorySelected[0] = true;
      mySelectedSubCategory = [SubCategory(name: 'all')];
    } else {
      isSubCategorySelected[0] = false;

      filteredProduct = _productListProvider.products
          .where((element) => mySelectedSubCategory.any((subCategory) =>
              subCategory.name == element.proSubCategoryId?.name))
          .toList();

      brands = _productListProvider.brands
          .where((element) => mySelectedSubCategory.any(
              (subCategory) => subCategory.sId == element.subcategoryId?.sId))
          .toSet()
          .toList();
      selectedBrands =
          selectedBrands.where((brand) => brands.contains(brand)).toList();
    }
    notifyListeners();
  }

  void filterProductByBrand() {
    if (selectedBrands.isEmpty) {
// If no brands are seltcted, show all products in the category
      filteredProduct = _productListProvider.products
          .where((product) => mySelectedSubCategory.any((subCategory) =>
              subCategory.name == product.proSubCategoryId?.name))
          .toList();
    } else {
// Filter products by selected brands
      filteredProduct = _productListProvider.products
          .where((product) =>
              mySelectedSubCategory.any((subCategory) =>
                  subCategory.name == product.proSubCategoryId?.name) &&
              selectedBrands
                  .any((brand) => product.proBrandId?.sId == brand.sId))
          .toList();
    }
    notifyListeners();
  }

  filterProductByName(String name){
    if(name == ''){
      filterProductBySubCategory(0);
    }else{
      filteredProduct = _productListProvider.products.where((product)=> product.name?.contains(name) ?? false).toList();
    }
    updateUI();
  }

  void sortProduct({required bool ascending}) {
    filteredProduct.sort((a, b) {
      if (ascending) {
        sortByPriceDropDownValue = "Low To High";
        return a.price!.compareTo(b.price ?? 0); //sort in ascending order
      } else {
        sortByPriceDropDownValue = "High To Low";
        return b.price!.compareTo(a.price ?? 0); //sort in descending order
      }
    });
    updateUI();
  }

  void updateUI() {
    notifyListeners();
  }
}
