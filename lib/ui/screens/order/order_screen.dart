import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_day_57/logic/cubits/order/order_cubit.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderCubit>().getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is InitialOrderState) {
            return const Center(
              child: Text("You haven't bought a product yet."),
            );
          }
          if (state is LoadingOrderState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ErrorOrderState) {
            return Center(child: Text(state.errorText));
          }
          final products = (state as LoadedOrderState).products;
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
    );
  }
}
