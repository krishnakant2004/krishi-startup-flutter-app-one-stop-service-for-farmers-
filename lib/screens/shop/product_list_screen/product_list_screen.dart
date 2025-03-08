import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:krishidost/screens/shop/product_list_screen/provider/product_list_provider.dart';
import 'package:krishidost/utility/extensions.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utility/constants.dart';
import '../../../widget/product_grid_view.dart';
import 'components/category_selector.dart';
import 'components/product_list_header.dart';

class BuyProductScreen extends StatefulWidget {
  const BuyProductScreen({super.key});

  @override
  State<BuyProductScreen> createState() => _BuyProductScreenState();
}

class _BuyProductScreenState extends State<BuyProductScreen>
    with AutomaticKeepAliveClientMixin {
  final box = GetStorage();
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    final productProvider = context.read<ProductListProvider>();

    if (productProvider.products.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        productProvider.fetchData();
        Future.delayed(const Duration(seconds: 2));
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    Size size = MediaQuery.of(context).size;
    double silverAppbarSize = 112;

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: LikeHeartBagHeader(silverAppbarSize: silverAppbarSize),
      body: Consumer<ProductListProvider>(
        builder: (context, provider, child) {
          if (provider.isFetching && provider.products.isEmpty) {
            return _buildShimmerEffect();
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.productListProvider.fetchData();
            },
            child: context.read<ProductListProvider>().products.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             const  Text(
                                'Something went wrong',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500),
                              ),
                              const Gap(4),
                              ElevatedButton.icon(onPressed: (){
                                context.productListProvider.fetchData();
                              }, label: const Text('Refresh'),
                              icon: const Icon(Icons.refresh),),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: const Color(0xFFF5F5F5),
                        floating: true,
                        pinned: false,
                        snap: true,
                        elevation: 0,
                        expandedHeight: silverAppbarSize,
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          background: CategorySelector(
                            categories: provider.categories,
                            silverSize: silverAppbarSize,
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(8),
                        sliver: SliverToBoxAdapter(
                          child: ProductGridView(
                            items: provider.products,
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Category shimmer
          SizedBox(
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            margin: const EdgeInsets.all(8.0),
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                          ),
                          Container(
                            height: 10,
                            width: 70,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                          ),
                          const Gap(6),
                          Container(
                            height: 10,
                            width: 50,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                          ),
                        ],
                      ),
                    ));
              },
            ),
          ),

          // Product grid shimmer
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product image shimmer
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Product details shimmer
                          Container(
                            height: 12,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Price shimmer
                          Container(
                            height: 12,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
