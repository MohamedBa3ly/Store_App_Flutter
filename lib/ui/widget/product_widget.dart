
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/model/product_model.dart';

import '../../cubits/favourite_icon_change/favourite_icon_cubit.dart';
import '../../cubits/favourite_icon_change/favourite_icon_state.dart';

class ProductCard extends StatelessWidget {
  // final Product product;
  final VoidCallback onClick;
  final ProductModel product;

  const ProductCard({super.key, 
    required this.product,
    required this.onClick
  });



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill( // Ensures the Card takes the full Stack size
          child: InkWell(
            onTap: () {
              onClick();
            },
            child: Card(
              elevation: 2,
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.network(product.image, height: 90, width: 90),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(product.title.substring(0, 8),
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text(r'$''${product.price.toString()}',
                            style: TextStyle(fontSize: 14, color: Colors.green)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 1,
          right: 1,
          child: BlocBuilder<FavouriteIconCubit, FavouriteItemState>(
              builder: (context, state) {
                bool isFavorite = false;

                if (state is FavouriteState) {
                  isFavorite = state.favoriteMap[product.id] ?? false;
                }
                return IconButton(
                  icon: Icon(
                    size: 32,
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    context.read<FavouriteIconCubit>().toggleFavourite(product.id);
                  },
              );
            }
          ),
        ),
      ],
    );
  }


}