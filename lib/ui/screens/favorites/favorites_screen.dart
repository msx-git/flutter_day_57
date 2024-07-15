import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/cubits/product/product_cubit.dart';
import '../products/widgets/product_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is InitialState) {
            return const Center(
              child: Text("You haven't added a product yet."),
            );
          }
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ErrorState) {
            return Center(child: Text(state.errorMessage));
          }
          final products = (state as LoadedState)
              .products
              .where((product) => product.isFavorite)
              .toList();
          return GridView.builder(
            shrinkWrap: true,
            primary: true,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 3 / 5,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductItem(product: product);
            },
          );
        },
      ),
    );
  }
}
