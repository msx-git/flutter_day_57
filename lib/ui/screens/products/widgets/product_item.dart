import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_day_57/logic/cubits/cart/cart_cubit.dart';
import 'package:flutter_day_57/utils/extensions.dart';

import '../../../../data/models/product.dart';
import '../../../../logic/cubits/product/product_cubit.dart';
import 'manage_product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Options"),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    context.read<ProductCubit>().deleteProduct(product.id);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => ManageProduct(product: product),
                    );
                  },
                  child: const Text(
                    'Edit',
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        padding: const EdgeInsets.all(10),
        clipBehavior: Clip.hardEdge,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              imageUrl: product.imageUrl,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              height: 190,
            ),
            6.height,
            Text(
              product.title,
              style: const TextStyle(fontSize: 16),
            ),
            8.height,
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FittedBox(child: Text("\$${product.price}")),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    context.read<CartCubit>().addToCart(
                          id: product.id,
                          title: product.title,
                          price: product.price,
                          imageUrl: product.imageUrl,
                        );
                  },
                  icon: const Icon(Icons.add_shopping_cart),
                ),
                IconButton(
                  onPressed: () {
                    context.read<ProductCubit>().toggleFavorite(product.id);
                  },
                  icon: product.isFavorite
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_border),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
