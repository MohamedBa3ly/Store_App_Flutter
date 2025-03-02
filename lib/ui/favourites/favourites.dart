import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/favourite_icon_change/favourite_icon_cubit.dart';
import '../../cubits/favourite_icon_change/favourite_icon_state.dart';
import '../../model/product_model.dart';
import '../../services/get_all_product_service.dart';
import '../../utils/colors.dart';
import '../widget/product_widget.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Favourites',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        backgroundColor: AppColors.orange,
        elevation: 4.0,
        centerTitle: true,
        automaticallyImplyLeading: false, // Remove the back arrow
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<FavouriteIconCubit, FavouriteItemState>(
          builder: (context, state) {
            return FutureBuilder<List<ProductModel>>(
              future: AllProductServices().getAllProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text("Error loading products"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text(""));
                }

                List<ProductModel> allProducts = snapshot.data!;

                // Ensure state is FavouriteState before accessing favoriteMap
                Map<int, bool> favoriteMap = state is FavouriteState ? state.favoriteMap : {};

                // Filter only favorite products
                List<ProductModel> favoriteProducts = allProducts
                    .where((product) => favoriteMap[product.id] ?? false)
                    .toList();

                if (favoriteProducts.isEmpty) {
                  return const Center(
                    child: Text(
                      "No favorite items yet!",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  );
                }

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: favoriteProducts.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      product: favoriteProducts[index],
                      onClick: () {}, // Optional click event
                    );
                  },
                );
              },
            );
          },
        )

      ),
    );
  }
}
