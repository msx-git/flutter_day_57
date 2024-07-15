import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_day_57/ui/screens/favorites/favorites_screen.dart';
import 'package:flutter_day_57/ui/screens/order/order_screen.dart';

import '../../../logic/cubits/product/product_cubit.dart';
import '../cart/cart_screen.dart';
import 'widgets/manage_product.dart';
import 'widgets/product_item.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () => context.read<ProductCubit>().getProducts(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          TextButton(
            onPressed: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const OrderScreen(),
              ),
            ),
            child: const Text("Orders"),
          ),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const CartScreen(),
              ),
            ),
            icon: const Text(
              "🛒",
              style: TextStyle(fontSize: 20),
            ),
            // icon: const Icon(Icons.shopping_cart_outlined),
          ),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const FavoritesScreen(),
              ),
            ),
            icon: const Icon(Icons.favorite),
          )
        ],
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is InitialState) {
            return const Center(child: Text("Products aren't loaded yet."));
          }
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ErrorState) {
            return Center(child: Text(state.errorMessage));
          }
          final products = (state as LoadedState).products;
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const ManageProduct(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
