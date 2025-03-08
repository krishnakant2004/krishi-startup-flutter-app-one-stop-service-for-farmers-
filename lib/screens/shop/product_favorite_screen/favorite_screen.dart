import 'package:gap/gap.dart';
import 'package:krishidost/widget/circular_container.dart';
import '../../../utility/app_data.dart';
import 'components/favorite_gridview.dart';
import 'provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/extensions.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    // Load both IDs and products when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.favoriteProvider.loadFavoriteProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe9f5f8),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          titleSpacing: 20,
          leadingWidth: 60,
          backgroundColor: Colors.green,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16, top: 3),
            child: CircularContainer(
                color: Colors.white,
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back))),
          ),
          title: Text("Favorites",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: AppData.darkOrange,
                    fontWeight: FontWeight.w800,
                    fontSize: 24,
                  )),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff025839),
                  Color(0xff026c45),
                  Color(0xff03925e),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          actions: [
            CircularContainer(
              height: 45,
              width: 45,
              color: Colors.white,
              child: IconButton(
                onPressed: () => context.favoriteProvider.clearFavoriteList,
                icon: const Icon(Icons.delete),
              ),
            ),
            const Gap(10),
          ],
        ),
      ),
      body: Consumer<FavoriteProvider>(
        builder: (context, favoriteProvider, child) {
          if (favoriteProvider.favoriteProducts.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No favorite items yet',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(4),
            child: FavoriteGridview(
              items: favoriteProvider.favoriteProducts,
            ),
          );
        },
      ),
    );
  }
}
