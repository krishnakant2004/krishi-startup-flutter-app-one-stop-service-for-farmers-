import 'package:flutter/material.dart';
import 'package:krishidost/screens/shop/product_by_category_screen/components/subcategory_listview.dart';
import 'package:krishidost/screens/shop/product_by_category_screen/provider/product_by_category_provider.dart';
import 'package:krishidost/utility/extensions.dart';
import 'package:krishidost/widget/product_grid_view_By_Category.dart';
import 'package:provider/provider.dart';
import '../../../models/category.dart';
import 'components/product_by_categary_appbar.dart';

class ProductByCategoryScreen extends StatefulWidget {
  final Category selectedCategory;
  const ProductByCategoryScreen({super.key, required this.selectedCategory});

  @override
  State<ProductByCategoryScreen> createState() => _ProductByCategoryScreenState();
}

class _ProductByCategoryScreenState extends State<ProductByCategoryScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    
    // Initialize data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.productByCategoryProvider.filterInitialProductAndSubCategory(widget.selectedCategory);
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5), // Light Gray
      appBar: ProductByCategaryAppbar(
        selectedCategory: widget.selectedCategory.name ?? "",
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: CustomScrollView(
          slivers: [
          const SliverAppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xffe1e6eb), // Light Grayish White
          floating: true,
          pinned: false,
          snap: true,
          elevation: 0,
          expandedHeight: 110, // Slightly increased height for better spacing
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            background: SubcategoryListview(),
          ),
        ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 0, left: 8, right: 8),
              sliver: SliverToBoxAdapter(
                child: Consumer<ProductByCategoryProvider>(
                  builder: (context, proByCaProvider, child) {
                    return ProductGridViewByCategory(
                        items:proByCaProvider.filteredProduct
                    ); //proByCaProvider.filteredProduct
                  },
                ),
              ),
            )
          ],
        ),
      ), //product by category app bar
    );
  }
}
