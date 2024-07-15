import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_day_57/logic/cubits/cart/cart_cubit.dart';
import 'package:flutter_day_57/logic/cubits/order/order_cubit.dart';

import '../../../data/models/product.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getCartProducts();
  }

  List<Product> prod = [];
  double sum = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Text(state.cartSum.toString()),
              );
            },
          )
        ],
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is InitialCartState) {
            return const Center(
              child: Text("You haven't added a product yet."),
            );
          }
          if (state is LoadingCartState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ErrorCartState) {
            return Center(child: Text(state.errorText));
          }
          final products = (state as LoadedCartState).products;
          prod = products;
          sum = state.cartSum;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                leading: Text("${index + 1}"),
                title: Text(product.title),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.read<OrderCubit>().buy(cartProducts: prod, sum: sum);
          context.read<CartCubit>().clearCart();
        },
        label: const Text("Buy"),
      ),
    );
  }
}
